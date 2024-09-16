#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

val enabled = false;
// 脱战时间阈值，单位 Tick，和 out_of_combat.cfg 中的取值应一致
val outOfCombatThreshold = 120L;

// 中断脱战计时器工具
events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (enabled) {
            var player = event.player;
            if (player.world.remote) return;
            if (<minecraft:bone>.matches(event.item)) {
                var data = D(player.data);
                var current = data.getLong("PlayerPersisted.out_of_combat.stopOutOfCombatTimer", -1);
                player.sendChat("stopOutOfCombatTimer: " ~ current);
                
                if (player.isSneaking) {
                    if (current < 0) {player.update({PlayerPersisted: {out_of_combat: {stopOutOfCombatTimer: 1000L}}});}
                    player.sendChat("stopOutOfCombatTimer has been set to: " ~ data.getLong("PlayerPersisted.out_of_combat.stopOutOfCombatTimer", -1));
                }
            }
        }
    }
);

// 脱战状态检测工具
events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (enabled) {
            var player = event.player;
            if (player.world.remote) return;
            if (<minecraft:bowl>.matches(event.item)) {
                var data = D(player.data);
                var message = data.getLong("PlayerPersisted.out_of_combat.outOfCombatTime") >= outOfCombatThreshold ? "Player is out of combat." : "Player is still not out of combat.";
                player.sendChat("noAttackingTime: " ~ data.getLong("PlayerPersisted.out_of_combat.noAttackingTime") ~
                    ", noAttackedTime: " ~ data.getLong("PlayerPersisted.out_of_combat.noAttackedTime") ~
                    ", outOfCombatTime: " ~ data.getLong("PlayerPersisted.out_of_combat.outOfCombatTime") ~ ". " ~ message
                );
                
            }
        }
    }
);

