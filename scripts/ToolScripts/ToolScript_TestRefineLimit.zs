#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (!event.player.world.remote) event.player.sendChat("\u5DF2\u8BBE\u7F6E\u4E0A\u9650\uFF1A" ~ (event.item.tag has "refine_limit"));
    }
);