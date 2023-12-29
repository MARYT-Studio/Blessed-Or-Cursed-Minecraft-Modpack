#loader crafttweaker reloadable
import crafttweaker.event.PlayerPickupXpEvent;
import crafttweaker.util.Math;

val debug = false;

events.onPlayerPickupXp(
    function (event as PlayerPickupXpEvent) {
        var player = event.player;
        var world = player.world;
        if (world.worldInfo.hardcoreModeEnabled) {
            if (debug) player.sendChat(event.xp);
            player.xpPoints += Math.round(event.xp);
        }
    }
);