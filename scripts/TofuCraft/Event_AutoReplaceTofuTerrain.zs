#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerPickupItemEvent;

events.onPlayerPickupItem(
    function (event as PlayerPickupItemEvent) {
        var picked = event.item.item;
        if (<tofucraft:tofu_terrain>.matches(picked)) {
            event.cancel();
            event.item.setDead();
            event.player.give(<tofucraft:blocktofumomen> * picked.amount);
        }
    }
);