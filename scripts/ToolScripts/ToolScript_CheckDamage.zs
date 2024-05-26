#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = false;

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (!enabled) return;
        var player = event.player;
        if (!player.world.remote) {
            if (!isNull(event.item.tag)) {
                player.sendChat("Current damage before damaged: " ~ (event.item.maxDamage - event.item.damage));
                player.sendChat("20% of current damage: " ~ Math.ceil(0.2f * (event.item.maxDamage - event.item.damage)));
                event.item.mutable().damageItem(Math.ceil(0.2f * (event.item.maxDamage - event.item.damage)), player);
                player.sendChat("Damage after damaged: " ~ (event.item.maxDamage - event.item.damage));
            }
        }
    }
);

