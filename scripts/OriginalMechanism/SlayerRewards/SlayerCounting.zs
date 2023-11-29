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
            if (isNull(player.data) || isNull(player.data.slayer_rewards) || ) {
                player.update(
                    slayer_rewards :{
                        // \u51FB\u6740\u975E\u7279\u6B8A\u7684\u602A\u7269\uFF0C\u589E\u52A0\u8FD9\u4E2A\u8BA1\u6570
                        slayer_counting = (specialEntity has entity.definition) ? 0 : 1,
                        // \u51FB\u6740\u4EFB\u4F55\u602A\u7269\uFF0C\u5237\u65B0\u8FD9\u4E2A\u65F6\u95F4
                        current_world_time = world.getWorldTime()
                    }
                );
            } else {
                slayerCounting = player.data.slayer_rewards.slayer_counting.asInt();
                slay = (specialEntity has entity.definition) ? 0 : 1,
                player.update({
                    // \u51FB\u6740\u975E\u7279\u6B8A\u7684\u602A\u7269\uFF0C\u589E\u52A0\u8FD9\u4E2A\u8BA1\u6570
                    slayer_counting = slayerCounting + slay,
                    // \u51FB\u6740\u4EFB\u4F55\u602A\u7269\uFF0C\u5237\u65B0\u8FD9\u4E2A\u65F6\u95F4
                    current_world_time = world.getWorldTime()
                });
            }
        }
    }
);
