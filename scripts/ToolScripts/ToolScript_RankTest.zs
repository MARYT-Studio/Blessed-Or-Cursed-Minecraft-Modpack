#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerTickEvent;

val enabled = false;

val seconds = (2 * 20); // real-world time to count. Because TickEvent is fired twice in a tick, it should be multiplied by 2, rather than 1*20.

events.onPlayerTick(
    function(event as PlayerTickEvent) {
        if (enabled) {
            if (event.side == "CLIENT") { return; }
            else {
                var player = event.player;
                if (isNull(player.data.ranktest_ticks)) {
                    player.update({ranktest_ticks: 0});
                } else {
                    var ticks as int = player.data.ranktest_ticks.asInt();
                    if (ticks >= 5 * seconds) {
                        player.sendMessage("五秒已到！");
                        player.update({ranktest_ticks: 0});
                        return;
                    }
                    player.update({ranktest_ticks: ticks + 1});
                }
            }
        }
    }
);
