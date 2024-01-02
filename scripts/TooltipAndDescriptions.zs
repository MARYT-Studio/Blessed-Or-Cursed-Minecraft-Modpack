import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;

// Tooltips

// Newbie Items tooltip
val SwordTooltip as string = game.localize("item.crafttweaker.newbiesword.name");
val AxeTooltip as string = game.localize("item.crafttweaker.newbieaxe.name");
val BreadTooltip as string = game.localize("item.crafttweaker.newbiebread.name");
val HammerTooltip as string = game.localize("item.crafttweaker.newbiehammer.name");
val NewbieTooltips as string[] = [SwordTooltip, AxeTooltip, BreadTooltip, HammerTooltip];

// Newbie items
val NewbieItems as IItemStack[] = [<minecraft:diamond_sword:*>, <minecraft:diamond_axe:*>, <minecraft:bread>, <sakura:stone_hammer:*>];
var index as int = 0;
for newbieitem in NewbieItems {
    newbieitem.addAdvancedTooltip(
        function(item) {
            if (!isNull(item.tag.newbie)) {
                return NewbieTooltips[index];
            } else {
                return "";
            }
        }
    );
    index += 1;
}
<patchouli:guide_book>.withTag({"patchouli:book": "lastsmith:smith_guide"}).addTooltip(game.localize("crafttweaker.tls_book.tooltip"));

// Vanilla Minecraft
<minecraft:experience_bottle>.addTooltip(game.localize("crafttweaker.experience_bottle.tooltip"));

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

val ic2_armor as IItemStack[] = [
    <ic2:nano_boots:*>,
    <ic2:nano_chestplate:*>,
    <ic2:nano_helmet:*>,
    <ic2:nano_leggings:*>,
    <ic2:quantum_boots:*>,
    <ic2:quantum_chestplate:*>,
    <ic2:quantum_helmet:*>,
    <ic2:quantum_leggings:*>
];
for armor in ic2_armor {
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_1.tooltip"));
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_2.tooltip"));
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_3.tooltip"));
    armor.addTooltip(game.localize("crafttweaker.ic2_armor_4.tooltip"));
}

<dcs_climate:dcs_sword_toolsteel>.addTooltip(game.localize("crafttweaker.toolsteelsword_1.tooltip"));
<dcs_climate:dcs_sword_toolsteel>.addTooltip(game.localize("crafttweaker.toolsteelsword_2.tooltip"));
<dcs_climate:dcs_sword_toolsteel>.addTooltip(game.localize("crafttweaker.toolsteelsword_3.tooltip"));
<dcs_climate:dcs_sword_toolsteel>.addTooltip(game.localize("crafttweaker.toolsteelsword_4.tooltip"));
<dcs_climate:dcs_sword_toolsteel>.addTooltip(game.localize("crafttweaker.toolsteelsword_5.tooltip"));

<contenttweaker:dummy_infinite_item>.addTooltip(game.localize("crafttweaker.immortal_item_1.tooltip"));
<contenttweaker:dummy_infinite_item>.addTooltip(game.localize("crafttweaker.immortal_item_2.tooltip"));

// ----------------------------------------------------------------

// JEI Descriptions

// Soldering Iron and Lemon Battery
mods.jei.JEI.addDescription([<contenttweaker:soldering_iron>, <contenttweaker:lemon_battery>],
[
    game.localize("crafttweaker.soldering_iron_1.desc"),
    game.localize("crafttweaker.soldering_iron_2.desc"),
    game.localize("crafttweaker.soldering_iron_3.desc"),
    game.localize("crafttweaker.soldering_iron_4.desc")   
]);
// To reduce the complexity of coding, I made SlashBlades' JEI descriptions into the SlashBladeTiering.zs
// Abyssal Ingot
mods.jei.JEI.addDescription(<contenttweaker:abyssal_ingot>,
    [
        game.localize("crafttweaker.abyssal_ingot.desc")
    ]
);
mods.jei.JEI.addDescription(<liquid:dcs.mazai>,
    [
        game.localize("crafttweaker.mazai.desc")
    ]
);
val mojian_Yanmodao = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yamato", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yamato", TextureName: "named/yamato", IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float, "SB.SEffect": {}, });
val sanhua = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.sange", TextureName: "named/sange/sange", IsBewitchedActived: 1 as byte, baseAttackModifier: 6.0 as float});
val twilightItems as IIngredient[] = [
    <contenttweaker:nature_shard>,
    <contenttweaker:magic_shard>,
    <contenttweaker:magic_infused_key>,
    mojian_Yanmodao,
    sanhua
];
mods.jei.JEI.addDescription(twilightItems, ["crafttweaker.twilight_items.desc"]);

val warpItems as IIngredient[] = [
    <thaumcraft:sanity_checker>,
    <thaumcraft:sanity_soap>,
    <dcs_climate:dcs_food_antibiotic:7>
];
mods.jei.JEI.addDescription(warpItems, ["crafttweaker.warp_items.desc"]);

val shoggothFlesh as IItemStack[] = [
    <abyssalcraft:shoggothflesh:0>,
    <abyssalcraft:shoggothflesh:1>,
    <abyssalcraft:shoggothflesh:2>,
    <abyssalcraft:shoggothflesh:3>,
    <abyssalcraft:shoggothflesh:4>
];
var i as int = 1;
// Replace subItems with a static list to avoid potential bugs in SMP
for flesh in shoggothFlesh {
    mods.jei.JEI.addDescription(flesh, game.localize("crafttweaker.warp_items.desc") ~ flesh.displayName ~ game.localize("crafttweaker.warp_items_1.desc") ~ (i * 10) ~ game.localize("crafttweaker.warp_items_2.desc"));
    i += 1;
}
// Desc for Infinite Heart Items
val InfiniteHeartItems as IItemStack[] = [
    // 5 Badges
    <dcs_climate:dcs_color_badge>,
    <dcs_climate:dcs_color_badge:1>,
    <dcs_climate:dcs_color_badge:2>,
    <dcs_climate:dcs_color_badge:3>,
    <dcs_climate:dcs_color_badge:4>,
    // HAC Other final items
    <dcs_climate:dcs_sword_toolsteel>
];
for infItem in InfiniteHeartItems {
    mods.jei.JEI.addDescription(infItem, game.localize("crafttweaker.infinity_items.desc"));
}

<contenttweaker:sake_of_karma>.addTooltip(game.localize("crafttweaker.sake_of_karma_1.tooltip"));
<contenttweaker:sake_of_karma>.addTooltip(game.localize("crafttweaker.sake_of_karma_2.tooltip"));
<contenttweaker:sake_of_karma>.addTooltip(game.localize("crafttweaker.sake_of_karma_3.tooltip"));
<contenttweaker:sake_of_karma>.addTooltip(game.localize("crafttweaker.sake_of_karma_4.tooltip"));
<contenttweaker:sake_of_karma>.addTooltip(game.localize("crafttweaker.sake_of_karma_5.tooltip"));
mods.jei.JEI.addDescription(<contenttweaker:sake_of_karma>, game.localize("crafttweaker.sake_of_karma.desc"));