#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.ItemTossEvent;

events.onItemToss(
    function(event as ItemTossEvent) {
        var itemEntity = event.item;
        if (!isNull(itemEntity.item.tag.markdirty)) {
            event.cancel();
        }
    }
);
