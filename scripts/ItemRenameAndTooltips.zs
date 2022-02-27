import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
// Newbie Items tooltip
val SwordTooltip as string = game.localize("item.crafttweaker.newbiesword.name");
val AxeTooltip as string = game.localize("item.crafttweaker.newbieaxe.name");
val BreadTooltip as string = game.localize("item.crafttweaker.newbiebread.name");
val HammerTooltip as string = game.localize("item.crafttweaker.newbiehammer.name");
val NewbieTooltips as string[] = [SwordTooltip, AxeTooltip, BreadTooltip, HammerTooltip];

// Newbie items
val NewbieItems as IItemStack[] = [<minecraft:diamond_sword:*>, <minecraft:diamond_axe:*>, <minecraft:bread>, <sakura:stone_hammer:*>];
var index as int = 0;
for newbieitem in NewbieItems
{
    newbieitem.addAdvancedTooltip(
        function(item)
        {
            if(!isNull(item.tag.newbie)){return NewbieTooltips[index];}else{return "";}
        }
    );
    index += 1;
}
<patchouli:guide_book>.withTag({"patchouli:book": "lastsmith:smith_guide"}).addTooltip(game.localize("crafttweaker.tls_book.tooltip"));

// Vanilla Minecraft
<minecraft:experience_bottle>.addTooltip(game.localize("crafttweaker.experience_bottle.tooltip"));

// Energy Converter
game.setLocalization("tile.energy_producer_eu.hv.name", game.localize("crafttweaker.power_output.name"));
game.setLocalization("tile.energy_consumer_fe.name", game.localize("crafttweaker.power_input.name"));
game.setLocalization("tile.energy_bridge.name", game.localize("crafttweaker.power_converter.name"));
// ic2
<ic2:energy_crystal:26>.addTooltip(game.localize("crafttweaker.energy_crystal.tooltip"));

<ic2:lapotron_crystal:26>.addTooltip(game.localize("crafttweaker.useless_lapo_crystal.tooltip"));

<ic2:lapotron_crystal:0>.withTag({charge: 1.0E7}).addTooltip(game.localize("crafttweaker.full_lapo_crystal_1.tooltip"));
<ic2:lapotron_crystal:0>.withTag({charge: 1.0E7}).addTooltip(game.localize("crafttweaker.full_lapo_crystal_2.tooltip"));

// ContentTweaker
val lemonBattery = <contenttweaker:lemon_battery>;
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_1.tooltip"));
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_2.tooltip"));
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_3.tooltip"));
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_4.tooltip"));
lemonBattery.addShiftTooltip(game.localize("crafttweaker.lemon_battery_5.tooltip"));

val solderWire = <contenttweaker:solder_wire>;
solderWire.addTooltip(game.localize("crafttweaker.solder_wire.tooltip"));

val basicIC = <contenttweaker:basic_ic>;
basicIC.addTooltip(game.localize("crafttweaker.basic_ic.tooltip"));
basicIC.addShiftTooltip(game.localize("crafttweaker.ic_modules.tooltip"));

val advancedIC = <contenttweaker:advanced_ic>;
advancedIC.addTooltip(game.localize("crafttweaker.advanced_ic_1.tooltip"));
advancedIC.addTooltip(game.localize("crafttweaker.advanced_ic_2.tooltip"));
advancedIC.addShiftTooltip(game.localize("crafttweaker.ic_modules.tooltip"));

val wingPotion = <minecraft:potion>.withTag({Potion: "dcs_climate:dcs.bird"});
wingPotion.addTooltip(game.localize("crafttweaker.wing_potion_1.tooltip"));
wingPotion.addTooltip(game.localize("crafttweaker.wing_potion_2.tooltip"));
wingPotion.addTooltip(game.localize("crafttweaker.bountiful_only.tooltip"));

val sanitySoap = <thaumcraft:sanity_soap>;
sanitySoap.addTooltip(game.localize("craftweaker.sanity_soap.tooltip"));
sanitySoap.addTooltip(game.localize("crafttweaker.bountiful_only.tooltip"));

val twilightKey = <contenttweaker:magic_infused_key>;
twilightKey.addTooltip(game.localize("contenttweaker.magic_infused_key_message_0.text"));
twilightKey.addTooltip(game.localize("contenttweaker.magic_infused_key_message_1.text"));

// Diamond cannot open Twilight Forest Portal
<minecraft:diamond>.addTooltip(game.localize("crafttweaker.diamond_cannot_open_tf_portal.tooltip"));

// Blue Steel Blades are useless
<lastsmith:blade:22>.addTooltip(game.localize("crafttweaker.blue_steel_blade_is_useless.tooltip"));

// Access to Hunting Dim
<huntingdim:frame>.withTag({BaseBlock: {id: "abyssalcraft:dltlog", Count: 1 as byte, Damage: 0 as short}}).addTooltip(game.localize("crafttweaker.craft_it_for_hd.tooltip"));
<contenttweaker:inner_shard>.addTooltip(game.localize("contenttweaker.inner_shard.tooltip"));
<contenttweaker:inner_gem>.addTooltip(game.localize("contenttweaker.inner_gem.tooltip"));

<contenttweaker:humiliation_from_jzahar>.addTooltip(game.localize("contenttweaker.humiliation_from_jzahar_1.tooltip"));
<contenttweaker:humiliation_from_jzahar>.addTooltip(game.localize("contenttweaker.humiliation_from_jzahar_2.tooltip"));

val ic2_armor as IItemStack[] = [<ic2:nano_boots:*>,
    <ic2:nano_chestplate:*>,
    <ic2:nano_helmet:*>,
    <ic2:nano_leggings:*>,
    <ic2:quantum_boots:*>,
    <ic2:quantum_chestplate:*>,
    <ic2:quantum_helmet:*>,
    <ic2:quantum_leggings:*>];
for armor in ic2_armor {
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_1.tooltip"));
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_2.tooltip"));
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_3.tooltip"));
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_4.tooltip"));
}