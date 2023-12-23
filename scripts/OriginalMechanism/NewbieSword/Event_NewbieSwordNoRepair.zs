#loader crafttweaker reloadable
import crafttweaker.event.PlayerTickEvent;
import mods.zenutils.EventPriority;

events.register(function (event as PlayerTickEvent) {
    var player = event.player;
    var item = event.player.mainHandHeldItem;
    if (isNull(item)) return;
    if (isNull(item.tag)) return;
    var tag = item.tag;
    var dTag = D(tag);
    if (dTag.getString("CurrentItemName", "") == "custom_newbie") {
        var damage = item.damage;
        if (damage == 0) return;
        else {
            var newMaxDamage = dTag.getInt("CustomMaxDamage") - damage;
            if (newMaxDamage >= 1) {
                player.setItemToSlot(player.activeHand, item.withDamage(0).withTag(tag - "CustomMaxDamage" + {CustomMaxDamage: newMaxDamage}));
            } else {
                if (dTag.getBool("isBroken", false)) {
                    item.mutable().shrink(1);
                    return;
                }
            }
        }
    }
}, EventPriority.highest(), true);
