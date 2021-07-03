import crafttweaker.item.IItemStack;
import crafttweaker.recipes.ICraftingRecipe;
val slabList = 
    <absentbydesign:slab_concrete_magenta>|
    <absentbydesign:slab_concrete_orange>|
    <absentbydesign:slab_concrete_pink>|
    <absentbydesign:slab_concrete_yellow>|
    <absentbydesign:slab_concrete_white>|
    <absentbydesign:slab_concrete_silver>|
    <absentbydesign:slab_concrete_purple>|
    <absentbydesign:slab_granite>|
    <absentbydesign:slab_andesite>|
    <absentbydesign:slab_diorite>|
    <absentbydesign:slab_granite_smooth>|
    <absentbydesign:slab_andesite_smooth>|
    <absentbydesign:slab_diorite_smooth>|
    <absentbydesign:slab_prismarine>|
    <absentbydesign:slab_prismarine_bricks>|
    <absentbydesign:slab_prismarine_dark>|
    <absentbydesign:slab_cobble_moss>|
    <absentbydesign:slab_bricks_cracked>|
    <absentbydesign:slab_bricks_mossy>|
    <absentbydesign:slab_end_bricks>|
    <absentbydesign:slab_netherbrick_red>|
    <absentbydesign:slab_stone>|
    <absentbydesign:slab_netherrack>|
    <absentbydesign:slab_end_stone>|
    <absentbydesign:slab_coarse_dirt>|
    <absentbydesign:slab_snow>|
    <absentbydesign:slab_concrete_red>|
    <absentbydesign:slab_concrete_blue>|
    <absentbydesign:slab_concrete_brown>|
    <absentbydesign:slab_concrete_cyan>|
    <absentbydesign:slab_concrete_green>|
    <absentbydesign:slab_concrete_gray>|
    <absentbydesign:slab_concrete_light_blue>|
    <absentbydesign:slab_concrete_lime>;
for recipe in recipes.all
{
    if(recipe.resourceDomain has "absentbydesign")
    {
        var output = recipe.output;
        var inputs = recipe.ingredients1D;
        for input in inputs
        {
            if(!isNull(input))
            {
                var realOutput as IItemStack = (slabList has output) ? output * 2 : output * 1;
                var singleInput as IItemStack = input;
                mods.futuremc.Stonecutter.addOutput(singleInput, realOutput);
                break;
            }
        }
    }
}
