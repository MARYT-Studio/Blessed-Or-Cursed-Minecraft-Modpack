#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = false;

// 锁定到的目标数值
val count = 5000;

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
                if(starter.matches(event.item)) {
                    var sum = 0.0;
                    for i in 0 .. count {
                        sum += player.world.random.nextFloat();
                    }
                    player.sendChat("sum is: " ~ sum ~ ", avg is: " ~ sum/count);
                }
            }
        }
    }
);

