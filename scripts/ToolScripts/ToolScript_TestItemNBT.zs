#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

val enabled = false;
val shihun_zhuguang = <lastsmith:.slashblade.named>.withTag({TextureName: "custom/souldevourerbamboolight/texture", ModelName: "custom/souldevourerbamboolight/model", CurrentItemName: "custom_souldevourerbamboolight", CustomMaxDamage: 20, RepairCounter: 4 as int, baseAttackModifier: 2.0 as float});

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            var player = event.player;
            if (player.world.remote) return;
            if (<minecraft:bone>.matches(event.item)) {
                player.give(shihun_zhuguang);
            }
        }
    );
}
