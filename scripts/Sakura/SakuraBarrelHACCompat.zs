import mods.sakura.liquid_to_itemStack.AddRecipe;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;

// 空纸盒
for index in 1 .. 21 {
    var output = <dcs_climate:dcs_food_pack>.withDamage(index);
    AddRecipe(<dcs_climate:dcs_food_pack>, output, output.liquid);
}

// 空酒瓶 - 酒
for index in 1 .. 17 {
    var output = <dcs_climate:dcs_liquor_bottle>.withDamage(index);
    AddRecipe(<dcs_climate:dcs_liquor_bottle>, output, output.liquid);
}

// 空酒瓶 - 饮料
for index in 0 .. 3 {
    var output = <dcs_climate:dcs_water_bottle>.withDamage(index);
    AddRecipe(<dcs_climate:dcs_liquor_bottle>, output, output.liquid);
}