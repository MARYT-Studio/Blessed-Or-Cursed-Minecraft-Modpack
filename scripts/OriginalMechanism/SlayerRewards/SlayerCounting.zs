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

// Packages for math utilities
import crafttweaker.util.IRandom;

// For random Teleporting
import crafttweaker.util.Position3f;

// Packages for Potion function
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;

// For send Messages
import crafttweaker.text.ITextComponent;

val specialEntity as IEntityDefinition[] = [<entity:minecraft:silverfish>, <entity:minecraft:endermite>];

events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent)
    {
        var entity = event.entity;
        var world as IWorld = entity.world;
        var source = event.damageSource.trueSource;
        
        if (isNull(source)) return;
        if(source instanceof IPlayer) {
            var player as IPlayer = source;
            if (isNull(player.data) || isNull(player.data.slayer_rewards)) {
                player.update(
                    {
                        slayer_rewards :{
                            // 击杀非特殊的怪物，增加这个计数
                            slayer_counting: ((specialEntity has entity.definition) ? 0 : 1),
                            // 击杀任何怪物，刷新这个时间
                            current_world_time: world.getWorldTime()
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
