#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

val enabled = false;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            var limited = event.item.tag has "RefineLimit";
            if (!event.player.world.remote) {
                event.player.sendChat("\u5DF2\u8BBE\u7F6E\u4E0A\u9650\uFF1A" ~ limited);
                if (limited) {
                    event.player.sendChat("\u4E0A\u9650\u503C\uFF1A" ~ event.item.tag.memberGet("RefineLimit"));
                }    
            }
            
        }
    );
}
