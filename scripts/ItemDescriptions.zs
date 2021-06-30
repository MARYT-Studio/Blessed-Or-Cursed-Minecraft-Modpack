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
