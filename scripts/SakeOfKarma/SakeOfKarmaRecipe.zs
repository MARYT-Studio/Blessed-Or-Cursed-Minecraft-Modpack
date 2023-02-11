import crafttweaker.item.IItemStack;

val bottle = <dcs_climate:dcs_liquor_bottle>|<sakura:materials:47>;
val rice = <dcs_climate:dcs_food_materials:2>|<sakura:materials:1>;
val soul = <flammpfeil.slashblade:proudsoul:3>;

val waters as IItemStack[] = [
    <minecraft:water_bucket>,
    <forge:bucketfilled>.withTag({FluidName: "sakura.hot_spring_water", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "dcs.hotspring", Amount: 1000})
];

for water in waters {
    recipes.addShaped("sake_of_karma", <contenttweaker:sake_of_karma>,
    [
        [null, rice, null],
        [null, water, null],
        [soul, bottle, soul]
    ]);
}
