#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.server.IServer;
import crafttweaker.text.ITextComponent;

val enabled = false;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            broadCast(ITextComponent.fromTranslation("crafttweaker.slayer_counter_step3.1", event.player.name), ITextComponent.fromTranslation("crafttweaker.slayer_counter_step3.2"), event.player, server);
        }
    );
}

// 工具函数：将两行的播报文本处理成 title 标题和副标题
function broadCast(title as ITextComponent, text as ITextComponent, player as IPlayer, server as IServer) as void {
    server.commandManager.executeCommand(server, "title @a title {\"text\": " + "\"" + title.unformattedComponentText + "\", \"color\": \"gold\"}");
    server.commandManager.executeCommand(server, "title @a subtitle {\"text\": " + "\"" + text.unformattedComponentText + "\", \"color\": \"green\"}");
    server.commandManager.executeCommand(server, "title @a times 5 20 5");
    player.sendRichTextMessage(title);
    player.sendRichTextMessage(text);
    print("\u4E09\u79CDtext:");
    print(title.formattedText);
    print(title.unformattedComponentText);
    print(title.unformattedText);
}
