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
            var toolLowDurability as bool = false;
            var weaponLowDurability as bool = false;
            var armorLowDurability as bool = false;
            var miscLowDurability as bool = false;
            var item = event.item;
            
            if (item.maxDamage - item.damage <= item.maxDamage/5) {
                if (item.definition.isWeapons(false)) weaponLowDurability = true;
                else if (item.definition.isTools(true)) toolLowDurability = true;
                else if (item.definition.isArmor()) armorLowDurability = true;
                else miscLowDurability = true;
            }

            player.sendChat("toolLowDurability = " ~ toolLowDurability);
            player.sendChat("weaponLowDurability = " ~ weaponLowDurability);
            player.sendChat("armorLowDurability = " ~ armorLowDurability);
            player.sendChat("miscLowDurability = " ~ miscLowDurability);
        }
    }
);

