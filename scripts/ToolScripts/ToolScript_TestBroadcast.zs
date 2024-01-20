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
            broadCast(ITextComponent.fromTranslation(key ~ ".1", player.name), ITextComponent.fromTranslation(key ~ ".2"), event.player, server);
        }
    );
}

// 工具函数：将两行的播报文本处理成 title 标题和副标题
function broadCast(title as ITextComponent, text as ITextComponent, player as IPlayer, server as IServer) as void {
    server.commandManager.executeCommand(server, "title @a title {\"text\": " + "\"" + title.formattedText + "\", \"color\": \"gold\"}");
    server.commandManager.executeCommand(server, "title @a subtitle {\"text\": " + "\"" + text.formattedText + "\", \"color\": \"green\"}");
    server.commandManager.executeCommand(server, "title @a times 5 20 5");
    player.sendRichTextMessage(title);
    player.sendRichTextMessage(text);
}
