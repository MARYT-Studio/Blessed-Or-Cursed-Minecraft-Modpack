#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.BlockHarvestDropsEvent;
import crafttweaker.block.IBlock;

events.onBlockHarvestDrops(function(event as BlockHarvestDropsEvent) {
    if (!event.world.remote) { // world.remote
        if (!event.silkTouch) {
            if (event.block.definition.id == "contenttweaker:sake_of_karma") {
                event.drops = [];
            }
        }
    }
});