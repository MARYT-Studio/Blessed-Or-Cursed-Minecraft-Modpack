import crafttweaker.item.IItemStack;
// Variables claiming
// Items only for Infinite Heart
val InfiniteHeartItem as IItemStack[] = [
    // 5 Badges
    <item:dcs_climate:dcs_color_badge>,
    <item:dcs_climate:dcs_color_badge:1>,
    <item:dcs_climate:dcs_color_badge:2>,
    <item:dcs_climate:dcs_color_badge:3>,
    <item:dcs_climate:dcs_color_badge:4>,
    // HAC Other final items
    <item:dcs_climate:dcs_sword_toolsteel>
];
var index as int = 0;
for item in InfiniteHeartItem {
    recipes.addShapeless("recycle_end_items" ~ index,
    <touhou_little_maid:substitute_jizo>,
    [item]
    );
    index = index + 1;
}