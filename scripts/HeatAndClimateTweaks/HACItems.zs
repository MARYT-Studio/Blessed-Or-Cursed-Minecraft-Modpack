import crafttweaker.item.IItemStack;
// T3 Material Induction Motar
recipes.remove(<dcs_climate:dcs_mechanical>);
recipes.addShaped("induction_motor_new", <dcs_climate:dcs_mechanical> * 2,
    [
        [<twilightforest:knightmetal_ingot>,<contenttweaker:second_proudsoul_bottle>,<twilightforest:knightmetal_ingot>],
        [null,<dcs_climate:dcs_device_shaft_s_sus>, null],
        [<twilightforest:carminite>,<dcs_climate:dcs_device_shaft_s_sus>, <twilightforest:carminite>]
    ]
);
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

// HAC Magic Jewels
// HAC Rings exclude the golden ones, for T3
val HACRings as IItemStack[] = [
    <dcs_climate:dcs_color_ring>,
    <dcs_climate:dcs_color_ring:1>,
    <dcs_climate:dcs_color_ring:2>,
    <dcs_climate:dcs_color_ring:3>,
    <dcs_climate:dcs_color_ring:4>,
];
// HAC Golden Jewels, for T4
val HACGoldenJewels as IItemStack[] = [
    <dcs_climate:dcs_color_ring2:2>,
    <dcs_climate:dcs_color_ring2:3>,
    <dcs_climate:dcs_color_pendant2>,
    <dcs_climate:dcs_color_pendant2:2>,
    <dcs_climate:dcs_color_pendant2:3>,
    <dcs_climate:dcs_color_pendant2:4>
];
// HAC Pendants, for last stage
val HACPendants as IItemStack[] = [
    <dcs_climate:dcs_color_pendant>,
    <dcs_climate:dcs_color_pendant:2>,
    <dcs_climate:dcs_color_pendant:3>,
    <dcs_climate:dcs_color_pendant:4>
];
// Items only for Infinite Heart
val InfiniteHeartItem as IItemStack[] = [
    // 5 Badges
    <dcs_climate:dcs_color_badge>,
    <dcs_climate:dcs_color_badge:1>,
    <dcs_climate:dcs_color_badge:2>,
    <dcs_climate:dcs_color_badge:3>,
    <dcs_climate:dcs_color_badge:4>,
    // HAC Other final items
    <dcs_climate:dcs_sword_toolsteel>
];
// remove all jewels' recipes
val HACJewels as IItemStack[][] = [HACRings, HACGoldenJewels, HACPendants, InfiniteHeartItem];
for jeweltype in HACJewels{for jewel in jeweltype{recipes.remove(jewel);}}