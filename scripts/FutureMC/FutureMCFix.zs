import crafttweaker.item.IItemStack;
//Recipes for Soul Soil
recipes.addShapeless("soul_soil",<futuremc:soul_soil>*2,
    [<minecraft:soul_sand>,<minecraft:soul_sand>]
);
//Recipes for Soul Torch
recipes.addShaped("soul_sand_torch",<futuremc:soul_fire_torch>*4,
    [
        [null,<minecraft:coal:*>,null],
        [null,<ore:stickWood>,null],
        [null,<minecraft:soul_sand>,null]
    ]
);
recipes.addShaped("soul_soil_torch",<futuremc:soul_fire_torch>*4,
    [
        [null,<minecraft:coal:*>,null],
        [null,<ore:stickWood>,null],
        [null,<futuremc:soul_soil>,null]
    ]
);
//Recipes for Soul Lantern
recipes.addShaped("soul_lantern",<futuremc:soul_fire_lantern>,
    [
        [<ore:nuggetIron>,<ore:nuggetIron>,<ore:nuggetIron>],
        [<ore:nuggetIron>,<futuremc:soul_fire_torch>,<ore:nuggetIron>],
        [<ore:nuggetIron>,<ore:nuggetIron>,<ore:nuggetIron>]
    ]
);

//FutureMC Sweet Berry Pams Compat
<ore:listAllfruit>.add(<futuremc:sweet_berries>);
<ore:listAllberry>.add(<futuremc:sweet_berries>);

//Sandstone and Red Sandstone localization
game.setLocalization("zh_cn","tile.sandStone.smooth.name","切制砂岩");
game.setLocalization("zh_cn","tile.redSandStone.smooth.name","切制红砂岩");

// Stripped Logs can be crafted into 4 planks, but stripped WOODS cannot.
// Let them can be crafted into planks.
val planksArray as IItemStack[] = [
    <minecraft:planks:0>, // Oak
    <minecraft:planks:1>,// Spruce
    <minecraft:planks:2>, // Birch
    <minecraft:planks:3>, // Jungle Wood
    <minecraft:planks:4>, // Acacia
    <minecraft:planks:5> // Dark Oak
];
val strippedWoodArray as IItemStack[] = [
    <futuremc:stripped_oak_wood>,
    <futuremc:stripped_spruce_wood>,
    <futuremc:stripped_birch_wood>,
    <futuremc:stripped_jungle_wood>,
    <futuremc:stripped_acacia_wood>,
    <futuremc:stripped_dark_oak_wood>
];
for i in 0 .. (planksArray.length - 1){recipes.addShapeless("stripped_wood_to_plank" ~ i, planksArray[i] * 4, [strippedWoodArray[i]]);}