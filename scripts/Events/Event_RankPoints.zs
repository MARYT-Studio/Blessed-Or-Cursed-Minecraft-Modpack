#loader crafttweaker reloadable
import mods.engraving.event.EntityStylishChangeEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;

val debug = false;

events.onEntityStylishRankChange(
    function (event as EntityStylishChangeEvent) {
        if (event.entity instanceof IPlayer) {
            var player as IPlayer = event.entity;
            if (debug) {player.sendChat("before modifying: " ~ event.amount);}
            if (event.amount > 0) {event.amount = Math.round(1.2f * event.amount);}            
            if (debug) {player.sendChat("after modifying: " ~ event.amount);}
        }
    }
);