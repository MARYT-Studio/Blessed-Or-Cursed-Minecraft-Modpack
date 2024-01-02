#loader crafttweaker

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.thaumcraft.Infusion;

// mods removal
var modidList as string[] = [
    "ic2",
    "thaumcraft",
    "botania",
    "energyconverters",
    "base"
];
val ItemNotToHide = 
    // ��ҵ����
    <ic2:wrench>|
    //Ǧϵ��
    <ic2:resource:2>| //Ǧ��ʯ
    <ic2:dust:10>|    //Ǧ��
    <ic2:ingot:3>|    //Ǧ��

    // ��������ʥ�ڻ�õĹ�ҵ������װ
    <ic2:nano_boots:*>|
    <ic2:nano_chestplate:*>|
    <ic2:nano_helmet:*>|
    <ic2:nano_leggings:*>|
    <ic2:quantum_boots:*>|
    <ic2:quantum_chestplate:*>|
    <ic2:quantum_helmet:*>|
    <ic2:quantum_leggings:*>|
    
    //����ϵ��
    <thaumcraft:amber>| 
    <thaumcraft:amber_block>|
    <thaumcraft:amber_brick>|
    <thaumcraft:ore_amber>|
    
    //��ɰϵ��
    <thaumcraft:ore_cinnabar>|
    <thaumcraft:cluster:6>|   //��ɰԭ���
    <thaumcraft:quicksilver>| //ˮ��

    <ic2:crafting:3>|  //�߼��Ͻ�
    <ic2:plate:12>|    //��������
    <ic2:plate:16>|    //���ְܸ�
    <ic2:energy_crystal:*>|  //����ˮ��
    <ic2:lapotron_crystal:*>|  //�����������ˮ��
    <ic2:crafting:4>|  //ǿ��ҿ��

    //TLS���õ�������ʱ����Ʒ
    <thaumcraft:ingot>|  //���ض�
    <thaumcraft:ingot:1>|  //��ս�����
    <thaumcraft:metal_thaumium>|  //���ؿ�
    <thaumcraft:metal_void>|  //��ս�����
    //�İ����ذε����ĺϳɲ���
    <thaumcraft:thaumium_sword>|  //���ؽ�
    <thaumcraft:elemental_sword>|  //���׽�
    <thaumcraft:crimson_blade>|  //Ѫ��֮��
    <thaumcraft:void_sword>|  //��ս�
    // �����Ƴ�Ť������а����
    <thaumcraft:sanity_soap>|
    // ���ڼ��Ť�������Ǽ����
    <thaumcraft:sanity_checker>|
    
    //��Ҫ�õ��Ļ�������
    //IC2
    <ic2:te:70>| //MFE�����

    //Energy Converter
    <energyconverters:energy_bridge>|  //�����Ž���
    <energyconverters:energy_consumer_fe>|  //FE������
    <energyconverters:energy_producer_eu:2>|  //��ѹEU�����
    
    // ��Ϊɰ�ֵ����Ʒ��ֲ��ħ���ķ�ӡ֮��
    // ���� TempFixes ��һ����

    // TODO: �Ƴ���Ԩ���ȣ�ͬʱ�Ƴ����������ɰ��
    <botania:spellcloth>;

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
for food in AbyssalFoods {mods.jei.JEI.removeAndHide(food);}

// Hide the dummy infinite item
mods.jei.JEI.hide(<contenttweaker:dummy_infinite_item>);

// LastSmith Unused Items Hiding
val TlsUnusedItems as IItemStack[] = [
    <lastsmith:blade:15>,
    <lastsmith:blade:17>,
    <lastsmith:blade:19>,
    <lastsmith:blade:23>,
    <lastsmith:blade:21>,
    <lastsmith:heatted_blade:3>,
    <lastsmith:blade:16>,
    <lastsmith:blade:20>,
    <lastsmith:blade:18>,
    <lastsmith:blade:22>,
    <lastsmith:blade:24>,
    <lastsmith:heatted_blade:4>
];

for tlsUnused in TlsUnusedItems {mods.jei.JEI.removeAndHide(tlsUnused);}

// Nyx
mods.jei.JEI.hide(<nyx:meteor_shard>);
