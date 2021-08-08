#loader crafttweaker reloadableevents
import crafttweaker.events.IEventManager;
import crafttweaker.event.BlockHarvestDropsEvent;
events.onBlockHarvestDrops(
    function(event as BlockHarvestDropsEvent)
    {
        if(!event.world.remote && event.isPlayer)
        {
            var block = event.block;
            if((block.definition.id == "minecraft:leaves") || (block.definition.id == "minecraft:leaves2"))
            {
                var player = event.player;
                if(player.currentItem.name == "item.paper")
                {
                    player.currentItem.mutable().shrink(1);
                    player.give(<dcs_climate:dcs_silkworm>);
                }
            }
        }    
    }
);