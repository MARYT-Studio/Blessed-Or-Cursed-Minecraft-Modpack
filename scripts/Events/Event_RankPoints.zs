#loader crafttweaker reloadable
import mods.engraving.event.EntityStylishChangeEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.util.Math;

val debug = true;

events.onEntityStylishRankChange(
    function (event as EntityStylishChangeEvent) {
        if (event.entity instanceof IPlayer) {
            var player as IPlayer = event.entity;
            if (debug) {player.sendChat("before modifying: " ~ event.amount ~ ", reason: " ~ event.reason);}
            if (event.amount > 0) {event.amount = Math.round(1.2f * event.amount);}
            var reason = event.reason;
            var amount = event.amount;
            if (reason != "") {
                event.amount = calcAmount(player, reason, amount);
            }            
            if (debug) {player.sendChat("after modifying: " ~ event.amount);}
        }
    }
);

// 公式：计算新的扣分数值
function calcAmount(player as IPlayer, reason as string, amount as int) as int {
    var data = player.data;
    if (isNull(player.data)) return 0;
    var dTag = D(player.data);
    var rankPoints = dTag.getInt("SBRankPoint");
    if (reason == "DropLongTime") {
        return (0 - 100 - rankPoints % 100);
    }
    if (reason == "DropShortTime") {
        var difficulty = player.world.worldInfo.difficulty;
        if (rankPoints > 500) {
            if (difficulty == "EASY") return 0 - 34 - Math.floor(((rankPoints - 500) % 33) / 2.0f) as int;
            if (difficulty == "NORMAL") return 0 - 34 - Math.floor(((rankPoints - 500) % 33) / 1.5f) as int;
            else return 0 - 34 - Math.floor(((rankPoints - 500) % 33) / 1.0f) as int;
        } else {
            if (difficulty == "EASY") return (0 - 25 - Math.floor(1.0D * (rankPoints % 100) / 2.5) as int);
            if (difficulty == "NORMAL") return (0 - 25 - Math.floor(1.0D * (rankPoints % 100) / 1.5) as int);
            else return (0 - 25 - Math.floor(1.0D * (rankPoints % 100) / 1.0) as int);
        }
    }
}
