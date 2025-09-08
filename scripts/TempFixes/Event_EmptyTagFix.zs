#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerPickupItemEvent;

events.onPlayerPickupItem(
    function (event as PlayerPickupItemEvent) {
        if (isNull(event.item) || isNull(event.item.item)) return;
        var stack = event.item.item;
        if (stack.definition.owner != "minecraft") return;
        if (stack.hasTag) {
            var tag = event.item.item.tag;
            if (isNull(tag.asMap().keySet) || tag.asMap().keySet.length == 0) {
                var itemEntity = event.item;
                var errorItemStack = stack;
                var amount = errorItemStack.amount;
                var meta = errorItemStack.metadata;
                itemEntity.setDead();
                event.player.give(errorItemStack.definition.defaultInstance.withDamage(meta) * amount);
                event.cancel();
            }
        }
    }
);