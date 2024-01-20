#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.server.IServer;
import crafttweaker.text.ITextComponent;

val enabled = true;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            broadCast("crafttweaker.slayer_counter_step3", event.player, server);
        }
    );
}

// 工具函数：将两行的播报文本处理成 title 标题和副标题
function broadCast(key as string, player as IPlayer, server as IServer) as void {
    server.commandManager.executeCommand(server, "title @a title {\"text\": " + "\"" + ITextComponent.fromTranslation(key ~ ".1", player.name).formattedText + "\", \"color\": \"gold\"}");
    server.commandManager.executeCommand(server, "title @a subtitle {\"text\": " + "\"" + ITextComponent.fromTranslation(key ~ ".2").formattedText + "\", \"color\": \"green\"}");
    server.commandManager.executeCommand(server, "title @a times 5 20 5");
}
