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

// For chat format
import mods.zenutils.I18n;
// For broadcasting
import crafttweaker.server.IServer;

val debug = false;

// 每秒 tick 数，常量
val seconds = 20;

// 配置选项
// 奖励计数器时长，暂定为 10 秒钟：若 10 秒钟内玩家未新增杀敌，进行奖励结算
val REWARD_TIME = 10 * seconds;

// 目前采用的是简单的方式，凡是这两种怪物都只刷新计时器
val specialEntity as IEntityDefinition[] = [<entity:minecraft:silverfish>, <entity:minecraft:endermite>];

// 玩家击杀时增加计数器和刷新计时器
events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent)
    {
        var entity = event.entity;
        if (!(entity instanceof IEntityMob)) return; // 非怪物的生物击杀不算
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
                            reward_world_time: world.getWorldTime(),
                        }
                    }
                );
            } else {
                player.update(
                    {
                        slayer_rewards :{
                            // 击杀非特殊的怪物，增加这个计数
                            slayer_counting: ((specialEntity has entity.definition) ? 0 : 1),
                            // 击杀任何怪物，刷新这个时间
                            reward_world_time: world.getWorldTime(),
                        }
                    }
                );
            }
            // 播报部分
            var slayCountingNow = player.data.slayer_rewards.slayer_counting.asInt();
            if (slayCountingNow == 5) {
                player.sendChat(I18n.format("crafttweaker.slayer_counter_step.1"));
            }
            if (slayCountingNow == 10) {
                player.sendChat(I18n.format("crafttweaker.slayer_counter_step.2"));
            }
            if (slayCountingNow == 20) {
                broadCast("crafttweaker.slayer_counter_step.3", player, server);
            }
            if (slayCountingNow == 50) {
                broadCast("crafttweaker.slayer_counter_step.4", player, server);
            }
            if (slayCountingNow == 100) {
                broadCast("crafttweaker.slayer_counter_step.5", player, server);
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
                        hurt_world_time: world.getWorldTime()
                    }
                }
            );
            
            // 若两次受伤时间间隔 3 秒钟以内
            var timeNow = player.world.getWorldTime();
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
        var time = world.getWorldTime();
        if (time - rewardTime >= REWARD_TIME) {
            //debug print
            if (debug) {
                player.sendChat("当前世界时间为" ~ time ~ "，最后一次击杀计时为" ~ rewardTime ~ "，结算奖励，归零计数器。");
            }

            // 播报已积累的杀敌数，等于 0 则不报
            if (slayerCounts > 0) {
                player.sendChat(I18n.format("crafttweaker.slayer_counter_result", "§e" ~ slayerCounts ~ "§r"));
            }
            // 奖励结算
            // 玩家是否为极限模式，是则享受翻倍奖励
            var hardcoreBonus as float = world.worldInfo.hardcoreModeEnabled ? 2.0f : 1.0f;
            if (slayerCounts < 10) {
                player.setXpPoints(player.getXpPoints() + (hardcoreBonus * slayerCounts) as int);
            } else {
                player.setXpPoints(player.getXpPoints() + Math.floor(hardcoreBonus * (0.5 * slayerCounts + 0.5 * slayerCounts * slayerCounts)));
            }
            // 计数归零
            // 计时器重置到当前时间
            player.update({
                slayer_rewards :{
                    slayer_counting: 0,
                    reward_world_time: world.getWorldTime()
                }
            });
        }
    }
);

function broadCast(key as string, player as IPlayer, server as IServer){
    var text as string[] = I18n.format(key, player.name).split("<br>");
    server.commandManager.executeCommand(server, "title @a title {\"text\": " + "\"" + text[0] + "\", \"color\": \"gold\"}");
    server.commandManager.executeCommand(server, "title @a subtitle {\"text\": " + "\"" + text[1] + "\", \"color\": \"green\"}");
    server.commandManager.executeCommand(server, "title @a times 5 20 5");
}
