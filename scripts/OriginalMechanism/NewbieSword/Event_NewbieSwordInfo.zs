#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerLoggedOutEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        var player = event.player;
        if (!player.world.remote) {
            var item = event.item;
            if (!isNull(item.tag) && isNewbieBlade(item.tag)) {
                sendTexts(player);
            }
        }
    }
);

static newbieSwordTexts as string[] = [
    game.localize("item.crafttweaker.newbiesword_1.name"),
    game.localize("item.crafttweaker.newbiesword_2.name"),
    game.localize("item.crafttweaker.newbiesword_3.name")
];

events.onPlayerLoggedOut(
    function(event as PlayerLoggedOutEvent) {
        var player = event.player;
        if (!isNull(player.data) && !isNull(player.data.PlayerPersisted) && !isNull(player.data.PlayerPersisted.NewbieSwordText)) {
            player.update({"PlayerPersisted": {"NewbieSwordText": 0}});
        }
    }
);

// 工具函数：消息在指定的 NBT 移除前只发一次
function sendTexts (player as IPlayer) as void {
    if (!isNull(player.data)) {
        var dTag = D(player.data);
        if (dTag.getInt("PlayerPersisted.NewbieSwordText") == 1) return;
    }
    for text in newbieSwordTexts {
        player.sendChat(text);
    }
    player.update({"PlayerPersisted": {"NewbieSwordText": 1}});
    return;
}

// 工具函数：检测是否为新手拔刀
function isNewbieBlade(tag as IData) as bool {
    var d = D(tag);
    return d.getString("CurrentItemName", "") == "custom_newbie";
}