// #loader crafttweaker reloadable
// import crafttweaker.events.IEventManager;
// import crafttweaker.event.ItemTossEvent;

/*
events.onItemToss(
    function(event as ItemTossEvent) {
        event.player.sendMessage("player drops an item.");
        var itemEntity = event.item;
        if (!isNull(itemEntity.item.tag.markdirty)) {
            event.player.sendMessage("item is dirty.");
            // event.cancel();
            // event.item.mutable.shrink();
            // event.player.give(item.removeTag("markdirty"));
        }
    }
);
*/

// TODO: This script makes Blades disappear. It's its bug. Rewrite or remove this after we know how SlashBlade mod uses its `markdirty` NBT tag.
