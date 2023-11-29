
#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.event.EntityLivingHurtEvent;

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
                            hurt_world_time:world.getWorldTime()
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
                            current_world_time: world.getWorldTime()
                        }
                    }
                );
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
            if (!isNull(player.data) && !isNull(player.data.slayer_rewards)) {
                var slayerRewards = player.data.slayer_rewards;

                if (isNull(slayerRewards.hurt_world_time)) {
                    player.update(
                        {
                            slayer_rewards :{
                                hurt_world_time:world.getWorldTime()
                            }
                        }
                    );
                    return;
                }
                
                // 若两次受伤时间间隔 3 秒钟以内
                if (player.world.getWorldTime() - slayerRewards.hurt_world_time > (3 * seconds)) {
                    var newSlayerCounting = player.data.slayer_rewards.slayer_counting.asInt() - 1;
                    player.update({
                        slayer_rewards :{
                            slayer_counting: max(newSlayerCounting, 1)
                        }
                    });
                    player.sendChat("\u8D85\u8FC7\u4E09\u79D2\u949F\uFF0C\u6263\u51CF");
                } else {
                    player.sendChat("\u4E09\u79D2\u949F\u5185\uFF0C\u4E0D\u6263");
                }
            }
        }
    }
);
