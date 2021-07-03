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