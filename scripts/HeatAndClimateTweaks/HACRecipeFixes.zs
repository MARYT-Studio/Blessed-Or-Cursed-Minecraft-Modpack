// Craft Brass Tools and Armor with Bronze
val bronzeIngot = <dcs_climate:dcs_ingot:9>;
recipes.addShaped("brass_axe_with_bronze",<dcs_climate:dcs_axe_brass>,
[
    [null,bronzeIngot,bronzeIngot],
    [<ore:stickWood>,<ore:stickWood>,bronzeIngot]
]);
recipes.addShaped("brass_pick_with_bronze",<dcs_climate:dcs_pickaxe_brass>,
[
    [null,null,bronzeIngot],
    [<ore:stickWood>,<ore:stickWood>,bronzeIngot],
    [null,null,bronzeIngot]
]);
recipes.addShaped("brass_spade_with_bronze",<dcs_climate:dcs_spade_brass>,
[
    [<ore:stickWood>,<ore:stickWood>,bronzeIngot]
]);
recipes.addShaped("brass_sword_with_bronze",<dcs_climate:dcs_sword_brass>,
[
    [<ore:stickWood>,bronzeIngot,bronzeIngot]
]);
recipes.addShaped("brass_scythe_with_bronze",<dcs_climate:dcs_scythe_brass>,
[
    [null,bronzeIngot,null],
    [null,null,bronzeIngot],
    [<ore:stickWood>,<ore:stickWood>,bronzeIngot]
]);
recipes.addShaped("brass_helmet_with_bronze",<dcs_climate:dcs_met_brass>,
[
    [bronzeIngot,bronzeIngot,bronzeIngot],
    [bronzeIngot,<ore:itemCloth>,bronzeIngot]
]);
recipes.addShaped("brass_chestplate_with_bronze",<dcs_climate:dcs_plate_brass>,
[
    [bronzeIngot,null,bronzeIngot],
    [bronzeIngot,<ore:itemCloth>,bronzeIngot],
    [bronzeIngot,bronzeIngot,bronzeIngot]
]);
recipes.addShaped("brass_leggings_with_bronze",<dcs_climate:dcs_leggins_brass>,
[
    [bronzeIngot,<ore:itemCloth>,bronzeIngot],
    [bronzeIngot,null,bronzeIngot],
    [bronzeIngot,null,bronzeIngot]
]);
recipes.addShaped("brass_boots_with_bronze",<dcs_climate:dcs_boots_brass>,
[
    [bronzeIngot,null,bronzeIngot],
    [bronzeIngot,<ore:itemCloth>,bronzeIngot]
]);

// Lower the Pottery Pot's price
recipes.addShaped("dcs_device_pottery_pot_with_brick",<dcs_climate:dcs_device_pottery_pot>,
[
    [<minecraft:brick>,<ore:itemCloth>,<minecraft:brick>],
    [<minecraft:brick>,null,<minecraft:brick>],
    [<minecraft:brick>,<minecraft:brick>,<minecraft:brick>]
]);
// Modify the Blaze Powder recipe added by HAC Magic Module.
// This recipe allows player to craft Blaze Powder with red drop and gunpowder, which is too cheap.
recipes.removeByRecipeName("dcs_climate:magic/dcs_blaze_powder_0");
recipes.addShapeless("dcs_magic_new_blazepowder", <minecraft:blaze_powder>, [<dcs_climate:dcs_color:7>, <minecraft:gunpowder>]);

// HAC Tofu should have tofu oredict
<ore:listAlltofu>.add(<dcs_climate:dcs_food_noentity:3>);
// and furnace recipe
furnace.addRecipe(<tofucraft:tofu_food:3>, <dcs_climate:dcs_food_noentity:3>, 0.3);
