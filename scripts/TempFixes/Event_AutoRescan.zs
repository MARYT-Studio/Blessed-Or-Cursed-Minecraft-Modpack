#loader crafttweaker reloadable
import crafttweaker.event.EntityJoinWorldEvent;
import crafttweaker.player.IPlayer;
import mods.zenutils.NetworkHandler;

events.onEntityJoinWorld(
    function(event as EntityJoinWorldEvent) {
    if (event.entity instanceof IPlayer) {
        var player as IPlayer = event.entity;
        if (!player.world.remote) {
            // TODO: find a way to execute /rescan. It is a client-only command.
            // NetworkHandler.sendTo("rescan", player);
            return;
        }
    }
});

// NetworkHandler.registerServer2ClientMessage("rescan", function(player, byteBuf) {
    // player.sendChat("client tried to do the rescanning");
    // player.executeCommand("rescan");
// });
