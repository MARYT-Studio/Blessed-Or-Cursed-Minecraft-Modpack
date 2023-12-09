
#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
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
        var world as IWorld = entity.world;
        var source = event.damageSource.trueSource;
        
        if (isNull(source)) return;
        if (source instanceof IPlayer) {
            var player as IPlayer = source;
            if (isNull(player.data) || isNull(player.data.slayer_rewards)) {
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
            } else {
                var slayerCounting = player.data.slayer_rewards.slayer_counting.asInt();
                var slay = (specialEntity has entity.definition) ? 0 : 1;
                player.update(
                    {
                        slayer_rewards :{
                            slayer_counting: (slayerCounting + slay),
                        }
                    }
                );
                player.sendChat("\u4F60\u8FBE\u6210\u4E86"+ player.data.slayer_rewards.slayer_counting +"\u8FDE\u6740\uFF01");
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
            if (!isNull(player.data) && !isNull(player.data.slayer_rewards)) {
                var slayerRewards = player.data.slayer_rewards;                
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
                var hurtWorldTime = slayerRewards.hurt_world_time;
                if (timeNow - hurtWorldTime > (3 * seconds)) {
                    var newSlayerCounting = player.data.slayer_rewards.slayer_counting.asInt() - 1;
                    player.update({
                        slayer_rewards :{
                            slayer_counting: max(newSlayerCounting, 1)
                        }
                    });
                    player.sendChat("\u5F53\u524D\u65F6\u95F4" + timeNow + "\uFF0C\u4E0A\u6B21\u53D7\u4F24\u65F6\u95F4" + hurtWorldTime + "\u3002\u8D85\u8FC7\u4E09\u79D2\u949F\uFF0C\u6263\u51CF\uFF0C\u5269\u4F59\u8FDE\u6740\u8BA1\u6570" + player.data.slayer_rewards.slayer_counting.asInt());
                } else {
                    player.sendChat("\u4E09\u79D2\u949F\u5185\uFF0C\u4E0D\u6263");
                }
            }
        }
    }
);

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
            // 奖励结算
            if (slayerCounts < 10) {
                player.xp += slayerCounts;
            } else {
                player.xp += Math.floor(0.5 * slayerCounts + 0.5 * slayerCounts * slayerCounts);
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