import crafttweaker.item.IIngredient;
val dye as IIngredient[] = [
    <minecraft:dye:10>,
    <minecraft:dye:14>,
    <minecraft:dye:2>,
    <minecraft:dye:1>,
    <minecraft:dye:6>,
    <minecraft:dye:5>
];
var i as int = 0;
for soil in <botania:altgrass>.definition.subItems
{
    recipes.addShapeless("botania_altgrass" ~ i,
    soil,
    [<minecraft:grass>,dye[i]]);
    i += 1;
}

recipes.addShapeless("botania_infused_grass", <botania:enchantedsoil>, [<minecraft:grass>, <minecraft:wheat_seeds>]);