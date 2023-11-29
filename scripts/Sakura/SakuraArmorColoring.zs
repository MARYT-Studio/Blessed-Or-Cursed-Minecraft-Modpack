// Package importing
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemCondition;
import crafttweaker.data.IData;
// Armor coloring recipes
// Samurai Part
val samuraiHelmet = <sakura:samurai_helmet>.anyDamage();
val samuraiChest = <sakura:samurai_chest>.anyDamage();
val samuraiLeggings = <sakura:samurai_pants>.anyDamage();
val samuraiShoes = <sakura:samurai_shoes>.anyDamage();
val allSamuraiArmorInput as IIngredient[] = [
    samuraiHelmet,
    samuraiChest,
    samuraiLeggings,
    samuraiShoes
];
val allSamuraiHelmetsOutput as IItemStack[] = [
    <sakura:samurai_helmet>.withTag({texture_name: "samurai_armor_1"}),
    <sakura:samurai_helmet>.withTag({texture_name: "samurai_armor_2"}),
    <sakura:samurai_helmet>.withTag({})
];
val allSamuraiChestsOutput as IItemStack[] = [
    <sakura:samurai_chest>.withTag({texture_name: "samurai_armor_1"}),
    <sakura:samurai_chest>.withTag({texture_name: "samurai_armor_2"}),
    <sakura:samurai_chest>.withTag({})
];
val allSamuraiLeggingsOutput as IItemStack[] = [
    <sakura:samurai_pants>.withTag({texture_name: "samurai_armor_1"}),
    <sakura:samurai_pants>.withTag({texture_name: "samurai_armor_2"}),
    <sakura:samurai_pants>.withTag({})
];
val allSamuraiShoesOutput as IItemStack[] = [
    <sakura:samurai_shoes>.withTag({texture_name: "samurai_armor_1"}),
    <sakura:samurai_shoes>.withTag({texture_name: "samurai_armor_2"}),
    <sakura:samurai_shoes>.withTag({})
];
val allSamuraiArmorOutput as IItemStack[][] = [
    allSamuraiHelmetsOutput,
    allSamuraiChestsOutput,
    allSamuraiLeggingsOutput,
    allSamuraiShoesOutput
];
val samuraiDyes as IIngredient[] = [<ore:dyeGreen>, <ore:dyeBlack>, <ore:dyeRed>];
// Soldier Part
val soldierHelmet = <sakura:soldier_helmet>.anyDamage();
val soldierChest = <sakura:soldier_chest>.anyDamage();
val soldierLeggings = <sakura:soldier_pants>.anyDamage();
val soldierShoes = <sakura:soldier_shoes>.anyDamage();
val allSoldierArmorInput as IIngredient[] = [
    soldierHelmet,
    soldierChest,
    soldierLeggings,
    soldierShoes
];
val allSoldierHelmetsOutput as IItemStack[] = [
    <sakura:soldier_helmet>.withTag({texture_name: "soldier_armor_1"}),
    <sakura:soldier_helmet>.withTag({})
];
val allSoldierChestsOutput as IItemStack[] = [
    <sakura:soldier_chest>.withTag({texture_name: "soldier_armor_1"}),
    <sakura:soldier_chest>.withTag({})
];
val allSoldierLeggingsOutput as IItemStack[] = [
    <sakura:soldier_pants>.withTag({texture_name: "soldier_armor_1"}),
    <sakura:soldier_pants>.withTag({})
];
val allSoldierShoesOutput as IItemStack[] = [
    <sakura:soldier_shoes>.withTag({texture_name: "soldier_armor_1"}),
    <sakura:soldier_shoes>.withTag({})
];
val allSoldierArmorOutput as IItemStack[][] = [
    allSoldierHelmetsOutput,
    allSoldierChestsOutput,
    allSoldierLeggingsOutput,
    allSoldierShoesOutput
];
val soldierDyes as IIngredient[] = [<ore:dyeBlack>, <ore:dyeGray>];

// Samurai Recipe Part
for armorType in 0 .. 4
{
    for colorType in 0 .. 3
    {
        recipes.addShapeless(
            // 配方名称
            ("samurai_"~armorType~colorType),
            // 输出产物
            allSamuraiArmorOutput[armorType][colorType],
            // 输入材料
            [
                allSamuraiArmorInput[armorType].marked("armorToColoring"),
                samuraiDyes[colorType]
            ],
            // 配方函数
            function(out,ins,info)
            {
                var outputOriginalData as IData = out.tag;
                var inputNBT as IData = ins.armorToColoring.tag;
                if(!isNull(inputNBT.texture_name))
                {
                    inputNBT = inputNBT - "texture_name";
                }
                return out.withDamage(ins.armorToColoring.damage).withTag(inputNBT + outputOriginalData);
            },
            // 配方动作
            null
        );
    }
}

// Soldier Recipe Part
for armorType in 0 .. 4
{
    for colorType in 0 .. 2
    {
        recipes.addShapeless(
            // 配方名称
            ("soldier_"~armorType~colorType),
            // 输出产物
            allSoldierArmorOutput[armorType][colorType],
            // 输入材料
            [
                allSoldierArmorInput[armorType].marked("armorToColoring"),
                soldierDyes[colorType]
            ],
            // 配方函数
            function(out,ins,info)
            {
                var outputOriginalData as IData = out.tag;
                var inputNBT as IData = ins.armorToColoring.tag;
                if(!isNull(inputNBT.texture_name))
                {
                    inputNBT = inputNBT - "texture_name";
                }
                return out.withDamage(ins.armorToColoring.damage).withTag(inputNBT + outputOriginalData);
            },
            // 配方动作
            null
        );
    }
}

