#loader crafttweaker reloadable
import crafttweaker.event.PlayerTickEvent;
import mods.zenutils.EventPriority;

val yinzhi_zhuguang = <flammpfeil.slashblade:slashbladesilverbamboolight>.withTag({AttackAmplifier: -4.0 as float});

events.register(function (event as PlayerTickEvent) {
    var player = event.player;
    if (player.world.remote) return;
    var item = event.player.mainHandHeldItem;
    if (isNull(item)) return;
    if (isNull(item.tag)) return;
    var tag = item.tag;
    var dTag = D(tag);
    if (dTag.getString("CurrentItemName", "") == "custom_souldevourerbamboolight") {
        var damage = item.damage;
        if (damage == 0) return;
        else {
            var newMaxDamage = dTag.getInt("CustomMaxDamage") - damage;
            if (newMaxDamage >= 1) {
                player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), item.withDamage(0).withTag(tag - "CustomMaxDamage" + {CustomMaxDamage: newMaxDamage}));
            } else {
                if (dTag.getBool("isBroken", false)) {
                    var difficulty = player.world.worldInfo.difficulty;
                    if (difficulty == "EASY") {
                        if (dTag.getInt("killCount") >= 6) {
                            player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), <flammpfeil.slashblade:slashbladewrapper>.withTag(tag - "CurrentItemName" - "CustomMaxDamage" - "ModelName" - "TextureName"));
                            return;
                        } else {
                            player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), yinzhi_zhuguang);
                            return;
                        }
                    }
                    if (difficulty == "NORMAL") {
                        if (dTag.getInt("killCount") >= 8) {
                            player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), <flammpfeil.slashblade:slashbladewrapper>.withTag(tag - "CurrentItemName" - "CustomMaxDamage" - "ModelName" - "TextureName"));
                            return;
                        } else {
                            player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), yinzhi_zhuguang);
                            return;
                        }
                    }
                    if (difficulty == "HARD") {
                        if (dTag.getInt("killCount") >= 10) {
                            player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), <flammpfeil.slashblade:slashbladewrapper>.withTag(tag - "CurrentItemName" - "CustomMaxDamage" - "ModelName" - "TextureName"));
                            return;
                        } else {
                            player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), yinzhi_zhuguang);
                            return;
                        }
                    }
                    player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), yinzhi_zhuguang);
                    return;
                }
            }
        }
    }
}, EventPriority.highest(), true);
