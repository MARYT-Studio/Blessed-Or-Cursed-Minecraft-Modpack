#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import mods.zenutils.I18n;
import crafttweaker.server.IServer;

val enabled = false;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            broadCast("crafttweaker.slayer_counter_step.3", event.player, server);
        }
    );
}

// 工具函数：将两行的播报文本处理成 title 标题和副标题
function broadCast(key as string, player as IPlayer, server as IServer){
    var text as string[] = I18n.format(key, player.name).split("<br>");
    server.commandManager.executeCommand(server, "title @a title {\"text\": " + "\"" + text[0] + "\", \"color\": \"gold\"}");
    server.commandManager.executeCommand(server, "title @a subtitle {\"text\": " + "\"" + text[1] + "\", \"color\": \"green\"}");
    server.commandManager.executeCommand(server, "title @a times 5 20 5");
}
