#loader crafttweaker reloadableevents
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityTravelToDimensionEvent;

import crafttweaker.player.IPlayer;

events.onEntityTravelToDimension(
    function(event as EntityTravelToDimensionEvent) {
        if(!event.entity instanceof IPlayer) {
            if(event.entity.definition.id == "flammpfeil.slashblade:bladestand") {
                event.cancel();
            }
            else if(event.entity.definition.id == "minecraft:item") {
                var ID as string = event.entity.nbt.Item.id.asString();
                if(ID.contains("slashblade")) {
                    event.cancel();
                }
            }
        }
});