
#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;
import crafttweaker.util.Math;

// Packages for CraftTweaker Events
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.event.EntityLivingHurtEvent;
import crafttweaker.event.PlayerTickEvent;

// Packages for math utilities
import crafttweaker.util.IRandom;

// For random Teleporting
import crafttweaker.util.Position3f;

// Packages for Potion function
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;

// For send Messages
import crafttweaker.text.ITextComponent;

// For broadcasting
import crafttweaker.server.IServer;

val debug = false;

// 每秒 tick 数，常量
val seconds = 20;

// 配置选项
// 奖励计数器时长，暂定为 10 秒钟：若 10 秒钟内玩家未新增杀敌，进行奖励结算
val REWARD_TIME = 10 * seconds;

// 两种不属于 IEntityMob 但是应当判定为怪物的生物
val slime as string[] = ["slime", "magma_cube"];

// 目前采用的是简单的方式，凡是这两种怪物都只刷新计时器
val specialEntity as string[] = ["silverfish", "endermite"];

// Toast 文本
val textStep11 = "crafttweaker.slayer_counter_step1.1";
val textStep12 = "crafttweaker.slayer_counter_step1.2";
val textStep21 = "crafttweaker.slayer_counter_step2.1";
val textStep22 = "crafttweaker.slayer_counter_step2.2";


val textStep1 as string[] = [textStep11, textStep12];
val textStep2 as string[] = [textStep21, textStep22];

// 玩家击杀时增加计数器和刷新计时器
events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent)
    {
        var entity = event.entity;
        if (entity instanceof IPlayer) return;  // 玩家死了不算
        if (!(entity instanceof IEntityMob) && !(entityMatch(slime, entity.definition))) return; // 非怪物的生物击杀不算
        var world as IWorld = entity.world;
        var source = event.damageSource.trueSource;
        
        if (isNull(source)) return;
        if (source instanceof IPlayer) {
            var player as IPlayer = source;
            if (!isNull(player.data) && !isNull(player.data.slayer_rewards) && !isNull(player.data.slayer_rewards.slayer_counting)) {
                var slayerCounting = player.data.slayer_rewards.slayer_counting.asInt();
                var slay = (specialEntity has entity.definition) ? 0 : 1;
                player.update(
                    {
                        slayer_rewards :{
                            // 击杀非特殊的怪物，增加这个计数
                            slayer_counting: (slayerCounting + slay),
                            // 击杀任何怪物，刷新这个时间
                            reward_world_time: world.provider.getWorldTime(),
                        }
                    }
                );
            } else {
                player.update(
                    {
                        slayer_rewards :{
                            // 击杀非特殊的怪物，增加这个计数
                            slayer_counting: ((entityMatch(specialEntity, entity.definition)) ? 0 : 1),
                            // 击杀任何怪物，刷新这个时间
                            reward_world_time: world.provider.getWorldTime(),
                        }
                    }
                );
            }
            // 播报部分
            var slayCountingNow = player.data.slayer_rewards.slayer_counting.asInt();
            if (slayCountingNow == 5) {
                if (debug) player.sendChat("SlayerCounting: 5");
                var icon = player.mainHandHeldItem;
                if (isNull(icon) || isNull(icon.tag) || isNull(icon.tag.SlashBlade)) {
                    player.sendToast(textStep1[0], "", textStep1[1], "", <minecraft:iron_sword>);
                } else {
                    player.sendToast(textStep1[0], "", textStep1[1], "", icon);
                }                
            }
            if (slayCountingNow == 10) {
                var icon = player.mainHandHeldItem;
                if (isNull(icon) || isNull(icon.tag) || isNull(icon.tag.SlashBlade)) {
                    player.sendToast(textStep2[0], "", textStep2[1], "", <minecraft:iron_sword>);
                } else {
                    player.sendToast(textStep2[0], "", textStep2[1], "", icon);
                }                
            }
            if (slayCountingNow == 20) {
                for pl in world.getAllPlayers() {
                    pl.sendToast("crafttweaker.slayer_counter_step3.1", "§6" ~ player.name, "crafttweaker.slayer_counter_step3.2", "", <minecraft:iron_sword>);
                }
            }
            if (slayCountingNow == 50) {
                for pl in world.getAllPlayers() {
                    pl.sendToast("crafttweaker.slayer_counter_step4.1", "§6" ~ player.name, "crafttweaker.slayer_counter_step4.2", "", <minecraft:iron_sword>);
                }
            }
            if (slayCountingNow == 100) {
                for pl in world.getAllPlayers() {
                    pl.sendToast("crafttweaker.slayer_counter_step5.1", "§6" ~ player.name, "crafttweaker.slayer_counter_step5.2", "", <minecraft:iron_sword>);
                }
            }
            // debug print
            if (debug) {
                player.sendChat("已刷新reward_time到：" ~ player.data.slayer_rewards.reward_world_time.asInt());
            }
        }
    }
);

// 玩家受伤时扣除计时器数值
events.onEntityLivingHurt(
    function (event as EntityLivingHurtEvent) {
        var entityLiving = event.entityLivingBase;
        if (entityLiving instanceof IPlayer) {
            var player as IPlayer = entityLiving;
            var world = player.world;
            if (world.remote) return;                         
            // 不论如何，受伤计时器都要更新
            player.update(
                {
                    slayer_rewards :{
                        hurt_world_time: world.provider.getWorldTime()
                    }
                }
            );
            
            // 若两次受伤时间间隔 3 秒钟以内
            var timeNow = player.world.provider.getWorldTime();
            var hurtWorldTime = player.data.slayer_rewards.hurt_world_time;
            if (timeNow - hurtWorldTime > (3 * seconds)) {
                var newSlayerCounting = max((player.data.slayer_rewards.slayer_counting.asInt() - 1), 1);
                player.update({
                    slayer_rewards :{
                        slayer_counting: newSlayerCounting
                    }
                });
            }        
        }
    }
);

// 奖励结算
events.onPlayerTick(
    function (event as PlayerTickEvent) {
        var player = event.player;
        var world = player.world;
        if (world.remote) return;
        if (isNull(player.data) || isNull(player.data.slayer_rewards)) return;
        var slayerRewards = player.data.slayer_rewards;
        if (isNull(slayerRewards.slayer_counting) || isNull(slayerRewards.reward_world_time)) return;
        var slayerCounts = slayerRewards.slayer_counting;
        var rewardTime = slayerRewards.reward_world_time;
        var time = world.provider.getWorldTime();
        if (time - rewardTime >= REWARD_TIME) {
            //debug print
            if (debug) {
                player.sendChat("当前世界时间为" ~ time ~ "，最后一次击杀计时为" ~ rewardTime ~ "，结算奖励，归零计数器。");
            }

            // 播报已积累的杀敌数，等于 0 则不报
            if (slayerCounts > 0) {
                var icon = player.mainHandHeldItem;
                if (isNull(icon) || isNull(icon.tag) || isNull(icon.tag.SlashBlade)) {
                    player.sendToast("crafttweaker.slayer_counter_result.1", "§e" ~ slayerCounts ~ "§r", "crafttweaker.slayer_counter_result.2", "", <minecraft:iron_sword>);
                } else {
                    player.sendToast("crafttweaker.slayer_counter_result.1", "§e" ~ slayerCounts ~ "§r", "crafttweaker.slayer_counter_result.2", "", icon);
                }                
                
            }
            // 奖励结算
            // 玩家是否为极限模式，是则享受翻倍奖励
            var hardcoreBonus as float = world.worldInfo.hardcoreModeEnabled ? 2.0f : 1.0f;
            // 加经验，杀敌数等于 0 则不加
            if (slayerCounts > 0) {
                if (slayerCounts < 10) {
                    player.setXpPoints(player.getXpPoints() + (hardcoreBonus * slayerCounts) as int);
                } else {
                    player.setXpPoints(player.getXpPoints() + Math.floor(hardcoreBonus * (0.5 * slayerCounts + 0.5 * slayerCounts * slayerCounts)));
                }
            }
            // 计数归零
            // 计时器重置到当前时间
            player.update({
                slayer_rewards :{
                    slayer_counting: 0,
                    reward_world_time: world.provider.getWorldTime()
                }
            });
        }
    }
);

function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}
