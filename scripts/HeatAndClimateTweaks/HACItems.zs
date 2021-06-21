import crafttweaker.item.IItemStack;
// Magic Cubes
// Variables claming
// Outputs
val blueCube = <dcs_climate:dcs_color_cube>;
val greenCube = <dcs_climate:dcs_color_cube:1>;
val redCube = <dcs_climate:dcs_color_cube:2>;
val blackCube = <dcs_climate:dcs_color_cube:3>;
val whiteCube = <dcs_climate:dcs_color_cube:4>;
// Inputs
val elestialBlock = <dcs_climate:dcs_ore_elestial>;
val HACInactiveCubes as IItemStack[] = [
    blueCube, greenCube, redCube, blackCube, whiteCube
];
val HACExtracts as IItemStack[] = [
    <dcs_climate:dcs_color:5>,
    <dcs_climate:dcs_color:6>,
    <dcs_climate:dcs_color:7>,
    <dcs_climate:dcs_color:8>,
    <dcs_climate:dcs_color:9>
];
val HACColorGems as IItemStack[][] = [
    [<dcs_climate:dcs_gem_blue:2> ,<dcs_climate:dcs_gem_blue:5>],
    [<dcs_climate:dcs_gem_green:2>, <dcs_climate:dcs_gem_green:5>],
    [<dcs_climate:dcs_gem_red:2>, <dcs_climate:dcs_gem_red:5>],
    [<dcs_climate:dcs_gem_black:2>, <dcs_climate:dcs_gem_black:5>],
    [<dcs_climate:dcs_gem_white:2>, <dcs_climate:dcs_gem_white:5>]
];
for index in 0 .. HACInactiveCubes.length
{
    var cube = HACInactiveCubes[index];
    recipes.remove(cube);
    for gemtype in 0 .. HACColorGems[0].length
    {      
        recipes.addShapeless(cube.name~"new_recipe"~gemtype, cube,
        [
            HACExtracts[index],
            elestialBlock,
            HACColorGems[index][gemtype],
            <contenttweaker:nature_shard>
        ]);
    }
}