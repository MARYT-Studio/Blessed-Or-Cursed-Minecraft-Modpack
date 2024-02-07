#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = false;

// 可以增删改这个数组的内容来指定启动物品
val starters as IItemStack[] = [
    <minecraft:bone>
];

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (!enabled) {return;}
        var player = event.player;
        if (!player.world.remote) {
            player.sendChat("WorldTime is: " ~ player.world.provider.worldTime);
        }
    }
);

