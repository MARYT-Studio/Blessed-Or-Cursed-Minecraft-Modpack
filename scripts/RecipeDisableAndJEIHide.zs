// Pack Import
import crafttweaker.item.IIngredient;
import mods.thaumcraft.Infusion;
// Recipe removal
var modidList as string[] = [
    "ic2",
    "thaumcraft",
    "botania",
    "energyconverters"
];
val ItemNotToHide = 
    //铅系列
    <ic2:resource:2>| //铅矿石
    <ic2:dust:10>|    //铅粉
    <ic2:ingot:3>|    //铅锭
    
    //琥珀系列
    <thaumcraft:amber>| 
    <thaumcraft:amber_block>|
    <thaumcraft:amber_brick>|
    <thaumcraft:ore_amber>|
    
    //朱砂系列
    <thaumcraft:ore_cinnabar>|
    <thaumcraft:cluster:6>|   //朱砂原矿簇
    // <thaumcraft:quicksilver>; //水银
    <thaumcraft:quicksilver>| //水银

    //TLS会用到的IC2材料
    <ic2:crafting:1>|  //电路板
    <ic2:crafting:2>|  //高级电路板
    <ic2:crafting:3>|  //高级合金
    <ic2:plate:12>|    //致密铁板
    <ic2:plate:16>|    //致密钢板
    <ic2:energy_crystal:*>|  //能量水晶
    <ic2:lapotron_crystal:*>|  //满电的兰波顿水晶
    <ic2:crafting:4>|  //强化铱板

    //TLS会用到的神秘时代物品
    <thaumcraft:ingot>|  //神秘锭
    <thaumcraft:ingot:1>|  //虚空金属锭
    <thaumcraft:metal_thaumium>|  //神秘块
    <thaumcraft:metal_void>|  //虚空金属块
    //四把神秘拔刀剑的合成材料
    <thaumcraft:thaumium_sword>|  //神秘剑
    <thaumcraft:elemental_sword>|  //风雷剑
    <thaumcraft:crimson_blade>|  //血腥之刃
    <thaumcraft:void_sword>|  //虚空剑
    
    //需要用到的机器方块
    //IC2
    <ic2:te:70>| //MFE充电座

    //Energy Converter
    <energyconverters:energy_bridge>|  //能量桥接器
    <energyconverters:energy_producer_fe>|  //FE输入器
    <energyconverters:energy_producer_eu:2>;  //高压EU输出器

// JEI Hide and recipe removal
for modid in modidList
{
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
for modid in thaumModList
{
    for itemThaumcraft in loadedMods[modid].items
    {
        Infusion.removeRecipe(itemThaumcraft);
    }
}