#loader crafttweaker reloadable
import crafttweaker.event.PlayerTickEvent;
import mods.zenutils.EventPriority;
import crafttweaker.entity.AttributeModifier;
import crafttweaker.data.IData;

val armorModifier = AttributeModifier.createModifier("newbie_armor", 4.0, 0);
val armorToughnessModifier = AttributeModifier.createModifier("newbie_armor", 2.0, 0);
val armorUUID = armorModifier.uuid;
val armorToughnessUUID = armorToughnessModifier.uuid;

events.onPlayerTick(function (event as PlayerTickEvent) {
    var player = event.player;
    if (player.world.remote) return;
    var item = player.mainHandHeldItem;
    if (isNull(item)) return;
    var armorAttribute = player.getAttribute("generic.armor");
    var armorToughnessAttribute = player.getAttribute("generic.armorToughness");
    
    if (!isNull(item.tag) && isNewbieBlade(item.tag)) {
        if !(armorAttribute.hasModifier(armorModifier)) armorAttribute.applyModifier(armorModifier);
        if !(armorToughnessAttribute.hasModifier(armorToughnessModifier)) armorToughnessAttribute.applyModifier(armorToughnessModifier);
    } else {
        if (armorAttribute.hasModifier(armorModifier)) armorAttribute.removeAllModifiers();
        if (armorToughnessAttribute.hasModifier(armorToughnessModifier)) armorToughnessAttribute.removeAllModifiers();
    }
});

function isNewbieBlade(tag as IData) as bool {
    var d = D(tag);
    return d.getString("CurrentItemName", "") == "custom_newbie";
}
