#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerAnvilUpdateEvent;
import crafttweaker.item.IItemStack;

function isSlashBlade(id as string) as bool {
    return (
        ((id has "lastsmith") && (id has "slashblade")) || // 是 TLS 的拔刀剑
        ((id has "flammpfeil") && !(id has "proudsoul"))   // 是 拔刀剑本体的拔刀剑
    );
}

events.onPlayerAnvilUpdate (
    function(event as PlayerAnvilUpdateEvent) {
        var player = event.player;
        var leftItem = event.leftItem;
        if (true) {
            if (isNull(leftItem.tag) || isNull(leftItem.tag.refine_limit)) {
                player.sendChat("Cancelled");
                event.cancel();
            } else {
                player.sendChat("not cancelled");
            }
        }
    }
);