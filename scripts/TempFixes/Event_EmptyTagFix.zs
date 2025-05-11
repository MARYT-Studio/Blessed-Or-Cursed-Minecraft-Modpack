#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerPickupItemEvent;

events.onPlayerPickupItem(
    function (event as PlayerPickupItemEvent) {
        if (event.item.item.hasTag) {
            var tag = event.item.item.tag;
            if (tag.asMap().keySet.length == 0) {
                var itemEntity = event.item;
                var errorItemStack = event.item.item;
                var amount = errorItemStack.amount;
                event.cancel();
                itemEntity.setDead();
                event.player.give(errorItemStack.definition.defaultInstance * amount);
            }
        }
    }
);