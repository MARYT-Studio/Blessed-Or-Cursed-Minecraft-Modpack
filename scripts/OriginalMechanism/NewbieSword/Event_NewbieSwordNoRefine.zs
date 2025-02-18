#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;
import mods.zenutils.EventPriority;

import crafttweaker.util.Math;
import crafttweaker.player.IPlayer;

import scripts.GlobalVars.anvilActionTime as anvilActionTime;

events.register(function (event as PlayerAnvilUpdateEvent) {
    if (event.leftItem.hasTag && !isNull(event.leftItem.tag.CurrentItemName) && event.leftItem.tag.CurrentItemName.asString() == "custom_newbie") {
        var item = event.leftItem;
        if (!event.player.world.remote) {
            var player = event.player;
            if (!isSameAnvilAction(player, event.getTimeStamp())) {
                player.sendToast("crafttweaker.nbsword_cannot_be_refined.1", "", "crafttweaker.nbsword_cannot_be_refined.2", "", item);
            }
        }
        event.cancel();
    }
}, EventPriority.highest(), true);

// 工具函数：铁砧更新事件消抖函数
function isSameAnvilAction(player as IPlayer, timeStamp as long) as bool {
    
    var playerTag = D(player.data);
    var lastAnvilAction = playerTag.getLong("last_anvil_action", -1L);
    var anvilActionCount = playerTag.getInt("anvil_action_count", 0);
    if (Math.abs(lastAnvilAction - timeStamp) >= anvilActionTime) {
        player.update({"last_anvil_action": timeStamp});
        player.update({"anvil_action_count": 0});
        return false;
    }
    if (anvilActionCount > 3) {
        player.update({"last_anvil_action": timeStamp});
    }    
    return true;
}
