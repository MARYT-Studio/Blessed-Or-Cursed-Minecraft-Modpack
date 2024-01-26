#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import crafttweaker.server.IServer;
import crafttweaker.text.ITextComponent;

val enabled = false;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            var player = event.player;
            if (player.world.remote) return;
            if (<minecraft:bone>.matches(event.item)) {
                player.sendToast(
                    "crafttweaker.slayer_counter_step3.1", event.player.name,
                    "crafttweaker.slayer_counter_step3.2", "",
                    <minecraft:grass>
                );
            }
        }
    );
}


