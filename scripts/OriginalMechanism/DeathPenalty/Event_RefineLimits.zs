#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerAnvilUpdateEvent;
import crafttweaker.item.IItemStack;

// 目前上限值仍然是初始值。
// TODO: 替换成锻造数成长公式
val limitBasicValue = 1000;

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
        if (true) {
            // 事件逻辑部分
            if (!isSlashBlade(leftItem.definition.id)) {
                return;
            }
            if(isNull(player.data.PlayerPersisted) || isNull(player.data.PlayerPersisted.refine_limit)) {
                player.update({
                    PlayerPersisted: { refine_limit: limitBasicValue }
                }); 
                return;
            }
            var refineLimit = player.data.PlayerPersisted.refine_limit.asInt();
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
                    player.sendChat("\u5F53\u524D\u62D4\u5200\u5251\u7684\u953B\u9020\u6570\uFF1A" + refine);
                    // 如果事件被取消
                    if(event.isCanceled()) {
                        player.sendChat("\u62D4\u5200\u5251\u953B\u9020\u6570\u8D85\u51FA\u4F60\u53EF\u4EE5\u627F\u53D7\u7684\u4E0A\u9650" + refineLimit + "\uFF0C\u953B\u9020\u53D6\u6D88\u3002");
                    }
                } else {
                    player.update({refine_limit_message_counter : counter + 1});
                }
            }
        }
    }
);