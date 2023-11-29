#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

val debug = false;

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        var player = event.player;
        if (!player.world.remote) {
            var item = event.item;
            var id = item.definition.id;
            if (debug) {
                player.sendChat(id ~
                    ", 是否是拔刀剑：" ~
                    (
                        ((id has "lastsmith") && (id has "slashblade")) || // 是 TLS 的拔刀剑
                        ((id has "flammpfeil") && !(id has "proudsoul"))   // 是 拔刀剑本体的拔刀剑
                    )
                );
            }
        }
    }
);