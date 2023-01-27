#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerInteractBlockEvent;
events.onPlayerInteractBlock(
    function(event as PlayerInteractBlockEvent){if(event.block.definition.id == "twilightforest:uncrafting_table"){event.cancel();}}
);