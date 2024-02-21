#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;

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
    var pos = player.position;
    var minX = pos.x - 1;
    var minY = pos.y - 1;
    var minZ = pos.z - 1;
    var stickyBlockFlag as bool = false;
    for i in 0 .. 3 {
        for j in 0 .. 3 {
            for k in 0 .. 3 {
                var block = player.world.getBlockState(IBlockPos.create((minX + i), (minY + j), (minZ + k)));
                if (<blockstate:minecraft:web>.matches(block)) {
                    stickyBlockFlag = true;
                    break;
                }
            }
        }
    } 
    return player.onGround() || player.isOnLadder || player.isElytraFlying || player.isInWater || player.isInLava || stickyBlockFlag;
}
