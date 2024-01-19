#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.server.IServer;

val enabled = false;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            var player = event.player;
            if (player.world.remote) return;
            if (<minecraft:bone>.matches(event.item)) {
                player.xpPoints = 5000;
            }
            else player.sendChat(player.xpPoints);
        }
    );
}
