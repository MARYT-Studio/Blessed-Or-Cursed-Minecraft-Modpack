import crafttweaker.item.IIngredient;
// Soldering Iron and Lemon Battery
mods.jei.JEI.addDescription([<contenttweaker:soldering_iron>, <contenttweaker:lemon_battery>],
[
    game.localize("crafttweaker.soldering_iron_1.desc"),
    game.localize("crafttweaker.soldering_iron_2.desc"),
    game.localize("crafttweaker.soldering_iron_3.desc"),
    game.localize("crafttweaker.soldering_iron_4.desc")   
]);
// To reduce the complexity of coding, I made SlashBlades' JEI descriptions into the SlashBladeTiering.zs
// Abyssal Ingot
mods.jei.JEI.addDescription(<contenttweaker:abyssal_ingot>,
    [
        game.localize("crafttweaker.abyssal_ingot.desc")
    ]
);
mods.jei.JEI.addDescription(<liquid:dcs.mazai>,
    [
        game.localize("crafttweaker.mazai.desc")
    ]
);
val mojian_Yanmodao = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yamato", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yamato", TextureName: "named/yamato", SpecialAttackType: 0, IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float, "SB.SEffect": {}, });
val sanhua = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.sange", TextureName: "named/sange/sange", SpecialAttackType: 7, IsBewitchedActived: 1 as byte, baseAttackModifier: 6.0 as float});
val twilightItems as IIngredient[] = [
    <contenttweaker:nature_shard>,
    <contenttweaker:magic_shard>,
    <contenttweaker:magic_infused_key>,
    mojian_Yanmodao,
    sanhua
];
mods.jei.JEI.addDescription(twilightItems, ["crafttweaker.twilight_items.desc"]);

val warpItems as IIngredient[] = [
    <thaumcraft:sanity_checker>,
    <thaumcraft:sanity_soap>,
    <abyssalcraft:shoggothflesh>,
    <abyssalcraft:shoggothflesh:1>,
    <abyssalcraft:shoggothflesh:2>,
    <abyssalcraft:shoggothflesh:3>,
    <abyssalcraft:shoggothflesh:4>,
    <dcs_climate:dcs_food_antibiotic:7>
];
mods.jei.JEI.addDescription(warpItems, ["crafttweaker.warp_items.desc"]);