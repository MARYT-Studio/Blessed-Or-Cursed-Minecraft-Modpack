#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = false;

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
                    player.sendChat("stepOnGround: " ~ stepOnGround(player));
                }
            }
        }
    }
);

// 被测函数：判断是否踩在地上
function stepOnGround(player as IPlayer) as bool {
    return player.onGround() || !(player.world.isAirBlock(player.position));
}
