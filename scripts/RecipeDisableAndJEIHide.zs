// Pack Import
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.thaumcraft.Infusion;
// 4 mods' item removal
var modidList as string[] = [
    "ic2",
    "thaumcraft",
    "botania",
    "energyconverters",
    "base",
    "tombstone"
];
val ItemNotToHide = 
    // \u5DE5\u4E1A\u6273\u624B
    <ic2:wrench>|
    //\u94C5\u7CFB\u5217
    <ic2:resource:2>| //\u94C5\u77FF\u77F3
    <ic2:dust:10>|    //\u94C5\u7C89
    <ic2:ingot:3>|    //\u94C5\u952D

    // \u53EF\u4EE5\u5728\u4E07\u5723\u8282\u83B7\u5F97\u7684\u5DE5\u4E1A\u62A4\u7532\u5957\u88C5
    <ic2:nano_boots:*>|
    <ic2:nano_chestplate:*>|
    <ic2:nano_helmet:*>|
    <ic2:nano_leggings:*>|
    <ic2:quantum_boots:*>|
    <ic2:quantum_chestplate:*>|
    <ic2:quantum_helmet:*>|
    <ic2:quantum_leggings:*>|
    
    //\u7425\u73C0\u7CFB\u5217
    <thaumcraft:amber>| 
    <thaumcraft:amber_block>|
    <thaumcraft:amber_brick>|
    <thaumcraft:ore_amber>|
    
    //\u6731\u7802\u7CFB\u5217
    <thaumcraft:ore_cinnabar>|
    <thaumcraft:cluster:6>|   //\u6731\u7802\u539F\u77FF\u7C07
    // <thaumcraft:quicksilver>; //\u6C34\u94F6
    <thaumcraft:quicksilver>| //\u6C34\u94F6

    //TLS\u4F1A\u7528\u5230\u7684IC2\u6750\u6599
    // \u8FD9\u4E24\u79CD\u7269\u54C1\u88AB CoT\u6CE8\u518C\u7684\u7269\u54C1\u66FF\u6362\u4E86
    // <ic2:crafting:1>|  //\u7535\u8DEF\u677F
    // <ic2:crafting:2>|  //\u9AD8\u7EA7\u7535\u8DEF\u677F

    <ic2:crafting:3>|  //\u9AD8\u7EA7\u5408\u91D1
    <ic2:plate:12>|    //\u81F4\u5BC6\u94C1\u677F
    <ic2:plate:16>|    //\u81F4\u5BC6\u94A2\u677F
    <ic2:energy_crystal:*>|  //\u80FD\u91CF\u6C34\u6676
    <ic2:lapotron_crystal:*>|  //\u6EE1\u7535\u7684\u5170\u6CE2\u987F\u6C34\u6676
    <ic2:crafting:4>|  //\u5F3A\u5316\u94F1\u677F

    //TLS\u4F1A\u7528\u5230\u7684\u795E\u79D8\u65F6\u4EE3\u7269\u54C1
    <thaumcraft:ingot>|  //\u795E\u79D8\u952D
    <thaumcraft:ingot:1>|  //\u865A\u7A7A\u91D1\u5C5E\u952D
    <thaumcraft:metal_thaumium>|  //\u795E\u79D8\u5757
    <thaumcraft:metal_void>|  //\u865A\u7A7A\u91D1\u5C5E\u5757
    //\u56DB\u628A\u795E\u79D8\u62D4\u5200\u5251\u7684\u5408\u6210\u6750\u6599
    <thaumcraft:thaumium_sword>|  //\u795E\u79D8\u5251
    <thaumcraft:elemental_sword>|  //\u98CE\u96F7\u5251
    <thaumcraft:crimson_blade>|  //\u8840\u8165\u4E4B\u5203
    <thaumcraft:void_sword>|  //\u865A\u7A7A\u5251
    // \u7528\u4E8E\u79FB\u9664\u626D\u66F2\u7684\u795B\u90AA\u80A5\u7682
    <thaumcraft:sanity_soap>|
    // \u7528\u4E8E\u68C0\u6D4B\u626D\u66F2\u7684\u795E\u667A\u68C0\u6D4B\u4EEA
    <thaumcraft:sanity_checker>|
    
    //\u9700\u8981\u7528\u5230\u7684\u673A\u5668\u65B9\u5757
    //IC2
    <ic2:te:70>| //MFE\u5145\u7535\u5EA7

    //Energy Converter
    <energyconverters:energy_bridge>|  //\u80FD\u91CF\u6865\u63A5\u5668
    <energyconverters:energy_consumer_fe>|  //FE\u8F93\u5165\u5668
    <energyconverters:energy_producer_eu:2>|  //\u9AD8\u538BEU\u8F93\u51FA\u5668
    
    // \u4F5C\u4E3A\u7802\u8F6E\u7684\u66FF\u4EE3\u54C1\uFF0C\u690D\u7269\u9B54\u6CD5\u7684\u5C01\u5370\u4E4B\u5E03
    // \u5C5E\u4E8E TempFixes \u7684\u4E00\u90E8\u5206
    <botania:spellcloth>|

    // Corail Tombstone \u7684\u88C5\u9970\u7269\u54C1
    <tombstone:decorative_grave_simple>|
    <tombstone:decorative_grave_simple:1>|
    <tombstone:decorative_grave_normal>|
    <tombstone:decorative_grave_normal:1>|
    <tombstone:decorative_grave_cross>|
    <tombstone:decorative_grave_cross:1>|
    <tombstone:decorative_tombstone>|
    <tombstone:decorative_tombstone:1>|
    <tombstone:decorative_subaraki_grave>|
    <tombstone:decorative_subaraki_grave:1>|
    <tombstone:decorative_grave_original>|
    <tombstone:decorative_grave_original:1>|
    <tombstone:crafting_ingredient:4>;

// JEI Hide and recipe removal
for modid in modidList {
    for itemToCheck in loadedMods[modid].items
    {
        if(!(ItemNotToHide.matches(itemToCheck)))
        {
            recipes.remove(itemToCheck);
            mods.jei.JEI.hide(itemToCheck);
        }
    }
}
var thaumModList as string[] = [
    "thaumcraft",
    "lastsmith"
];
for modid in thaumModList {
    for itemThaumcraft in loadedMods[modid].items {
        Infusion.removeRecipe(itemThaumcraft);
    }
}
// HAC removals
recipes.remove(<minecraft:tipped_arrow>.withTag({Potion: "dcs_climate:dcs.bird"}));
mods.jei.JEI.hide(<minecraft:tipped_arrow>.withTag({Potion: "dcs_climate:dcs.bird"}));
val HACItemsToHide as IItemStack[] = [
    <dcs_climate:dcs_magic_picture_g>,
    <dcs_climate:dcs_color_ring2>,
    <dcs_climate:dcs_color_ring2:1>,
    <dcs_climate:dcs_color_pendant:1>, // Green Pendant, infinite HP restore
    <dcs_climate:dcs_color_pendant2:1>,
    <dcs_climate:dcs_magic_card:6>,
    <dcs_climate:dcs_magic_card:9>,
    <dcs_climate:dcs_gemboots_blue>,
    <dcs_climate:dcs_magic_picture_u>,
    <dcs_climate:dcs_magic_card:11>,
    <minecraft:splash_potion>.withTag({Potion: "dcs_climate:dcs.bird"}),
    <minecraft:lingering_potion>.withTag({Potion: "dcs_climate:dcs.bird"}),
    <dcs_climate:dcs_magic_card_m>,
    <dcs_climate:dcs_magic_card_m:4>,
    <dcs_climate:dcs_color_ring2:4> // White Golden Ring, it can remove bad effects
];
for item in HACItemsToHide {
    mods.jei.JEI.removeAndHide(item);
}
val wingBlessingPotions as IItemStack[] = [
    <minecraft:splash_potion>.withTag({Potion: "minecraft:awkward"}),
    <minecraft:lingering_potion>.withTag({Potion: "minecraft:awkward"}),
    <minecraft:potion>.withTag({Potion: "minecraft:awkward"})
];
for potion in wingBlessingPotions {
    brewing.removeRecipe(potion, <dcs_climate:dcs_color:4>);
}
// remove recipe of splash wing blessing potion
brewing.removeRecipe(<minecraft:potion>.withTag({Potion: "dcs_climate:dcs.bird"}), <minecraft:gunpowder>);
// remove recipe of lingering wing blessing potion
brewing.removeRecipe(<minecraft:splash_potion>.withTag({Potion: "dcs_climate:dcs.bird"}), <minecraft:dragon_breath>);

// Twilight Forest Block and Chain remove
mods.jei.JEI.removeAndHide(<twilightforest:block_and_chain>);
// AbyssalCraft ODE and its core
mods.jei.JEI.removeAndHide(<abyssalcraft:odb>);
// ODB Core is needed to perform Boss summon ritual,
// Because its explosion is disabled, so it is safe to unban it.
// mods.jei.JEI.removeAndHide(<abyssalcraft:odbcore>);

// HAC Motor Vehicles
val HACMotors as IItemStack[] = [
    <dcs_climate:dcs_motor_scooter>,
    <dcs_climate:dcs_motor_scooter:1>,
    <dcs_climate:dcs_motor_scooter:2>,
    <dcs_climate:dcs_motor_scooter:3>,
    <dcs_climate:dcs_magnetic_hover>
];
for motor in HACMotors{mods.jei.JEI.removeAndHide(motor);}

// HAC Useless Manganese Ingot
mods.jei.JEI.removeAndHide(<dcs_climate:dcs_ingot:16>);

// remove abyssalcraft's overpowered foods
// fried egg is saved, because it is reasonable
val AbyssalFoods as IItemStack[] = [
    <abyssalcraft:mre>,
    <abyssalcraft:ironp>,
    <abyssalcraft:chickenp>,
    <abyssalcraft:porkp>,
    <abyssalcraft:beefp>,
    <abyssalcraft:fishp>,
    <abyssalcraft:dirtyplate>,
    <abyssalcraft:eggp>,
    <abyssalcraft:cloth>
];
for food in AbyssalFoods{mods.jei.JEI.removeAndHide(food);}

// Hide the dummy infinite item
mods.jei.JEI.hide(<contenttweaker:dummy_infinite_item>);

// Corail Tombstone Specially Hide
val torcherinoToHide as IItemStack[] = [
    
];
for item in torcherino {mods.jei.JEI.removeAndHide(item);}
