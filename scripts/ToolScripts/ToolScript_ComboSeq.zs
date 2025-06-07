#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = false;

events.onPlayerTick(
    function(event as PlayerTickEvent) {
        if (!enabled) return;
        if (event.side == "CLIENT") return;
        var player = event.player;
        if (!isNull(player.mainHandHeldItem) && player.mainHandHeldItem.definition.isSlashBlade()) {
            var blade = player.mainHandHeldItem;
            var comboSeq = D(blade.tag).getInt("comboSeq", -1);
            if (comboSeq >= 0) {
                player.sendChat("Current comboSeq: " + comboSeq);
            } else player.sendChat("Current comboSeq is null");
        }
    }
);
