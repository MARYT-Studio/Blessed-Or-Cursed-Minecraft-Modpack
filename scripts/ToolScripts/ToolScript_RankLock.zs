#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = false;

// 锁定到的目标数值

val targetRank = 5000;

// 评级锁定模式的开、关是手持特定的物品点击右键，可以增删改这个数组的内容来指定启动物品

val starters as IItemStack[] = [
    <minecraft:bone>
];

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (!enabled) {return;}
        var player = event.player;
        if (!player.world.remote) {
            for starter in starters {
                if(starter has event.item) {
                    if (isNull(player.data.PlayerPersisted)) {return;}
                    
                    if(isNull(player.data.PlayerPersisted.rank_lock)) {
                        player.update({PlayerPersisted: {rank_lock: true}});
                        player.sendChat("\u9501\u5B9A\u6A21\u5F0F\uFF1A\u5F00");
                    } else {
                        var invsersed_lock = !(player.data.PlayerPersisted.rank_lock.asBool());
                        player.update({PlayerPersisted: {rank_lock: invsersed_lock}});
                        invsersed_lock ? player.sendChat("\u9501\u5B9A\u6A21\u5F0F\uFF1A\u5F00") : player.sendChat("\u9501\u5B9A\u6A21\u5F0F\uFF1A\u5173");
                    }
                }
            }
        }
    }
);

events.onPlayerTick(
    function(event as PlayerTickEvent) {
        if (!enabled) {return;}
        if (event.side == "CLIENT") {return;}
        var player = event.player;
        if(isNull(player.data.PlayerPersisted.rank_lock)) {return;}
        if(player.data.PlayerPersisted.rank_lock.asBool()) {
            player.update({SBRankPoint: targetRank});
        }
    }
);
