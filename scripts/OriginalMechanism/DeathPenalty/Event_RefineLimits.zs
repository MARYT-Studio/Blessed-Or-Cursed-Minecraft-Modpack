#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

val debug = false;

// TODO: 将这个脚本替换成 onAnvilUpdate
events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        var player = event.player;
        if (!player.world.remote) {
            var item = event.item;
            var id = item.definition.id;
            if (debug) {
                player.sendChat(id ~
                    ", \u662F\u5426\u662F\u62D4\u5200\u5251\uFF1A" ~
                    (
                        ((id has "lastsmith") && (id has "slashblade")) || // \u662F TLS \u7684\u62D4\u5200\u5251
                        ((id has "flammpfeil") && !(id has "proudsoul"))   // \u662F \u62D4\u5200\u5251\u672C\u4F53\u7684\u62D4\u5200\u5251
                    )
                );
            }
        }
    }
);