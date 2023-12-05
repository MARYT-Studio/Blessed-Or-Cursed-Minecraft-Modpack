#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerAnvilUpdateEvent;
import crafttweaker.event.PlayerAnvilRepairEvent;
import crafttweaker.item.IItemStack;

// 目前上限值仍然是初始值。
// TODO: 替换成锻造数成长公式
val limitBasicValue = 2;

function isSlashBlade(id as string) as bool {
    return (
        ((id has "lastsmith") && (id has "slashblade")) || // 是 TLS 的拔刀剑
        ((id has "flammpfeil") && !(id has "proudsoul"))   // 是 拔刀剑本体的拔刀剑
    );
}

events.onPlayerAnvilUpdate (
    function(event as PlayerAnvilUpdateEvent) {
        var player = event.player;
        var leftItem = event.leftItem;
        // 事件逻辑部分
        // if (!isSlashBlade(leftItem.definition.id)) {
        //     return;
        // }
        if(isNull(leftItem.tag) || isNull(leftItem.tag.refine_limit)) {
            event.outputItem = leftItem.updateTag({refine_limit: limitBasicValue});
            event.xpCost = 2;
            event.materialCost = 1;
            player.sendChat("已设置上限：" ~ (event.outputItem.tag has "refine_limit"));
            return;
        }
        var refineLimit = leftItem.tag.refine_limit.asInt();
        var refine = isNull(leftItem.tag.RepairCounter) ? 0 : leftItem.tag.RepairCounter.asInt();
        if (refine > refineLimit) {
            event.cancel();
        }
        
        // 发送聊天消息部分
        if (!player.world.remote) {
            if (isNull((player.data.refine_limit_message_counter))) {
                player.update({refine_limit_message_counter : 1});
                return;
            }
            var counter = player.data.refine_limit_message_counter.asInt();
            if (counter == 3) { // 这个 3 是数出来的，在上面的 isRemote 过滤条件下，这个事件会被计数 3 次
                player.update({refine_limit_message_counter : 1});
                // 把要发送的信息放在这里，每次铁砧更新事件就只会发一次
                player.sendChat("当前拔刀剑的锻造数：" + refine);
                // 如果事件被取消
                if(event.isCanceled()) {
                    player.sendChat("拔刀剑锻造数超出你可以承受的上限" + refineLimit + "，锻造取消。");
                }
            } else {
                player.update({refine_limit_message_counter : counter + 1});
            }
        }
    }
);