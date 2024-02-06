#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = true;

// 可以增删改这个数组的内容来指定启动物品
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
                    player.sendChat("print to log");
                    print(player.world.getCustomWorldData());
                }
            }
        }
    }
);

