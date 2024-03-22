#loader crafttweaker reloadable

import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;

// 农历龙年新年过完了，今后只有打龙会发红包
events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent) {
        if(!event.entity.world.remote && (event.damageSource.trueSource instanceof IPlayer)) {
            var player as IPlayer = event.damageSource.trueSource;
            if(!(event.entity instanceof IPlayer) && ("EnderDragon" has event.entity.definition.name)) {
                player.give(<contenttweaker:red_envelope_lubang>);
            }
        }
    }
);
