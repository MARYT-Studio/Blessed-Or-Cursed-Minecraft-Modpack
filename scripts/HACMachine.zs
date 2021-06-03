// Tier 1
val T1Machines = <dcs_climate:dcs_device_chamber>|<dcs_climate:dcs_device_windmill>|<dcs_climate:dcs_device_fan>;
val T1Ingots = <ore:ingotBronze>|<ore:ingotBrass>;
recipes.remove(T1Machines);
recipes.addShaped("hac_chamber",<dcs_climate:dcs_device_chamber>,
[
    [T1Ingots,<contenttweaker:first_killcount_token>,T1Ingots],
    [<minecraft:redstone>,<minecraft:furnace>,<minecraft:redstone>],
    [T1Ingots,<minecraft:redstone>,T1Ingots]
]
);

recipes.addShaped("hac_fan",<dcs_climate:dcs_device_fan>,
[
    [T1Ingots|<minecraft:iron_ingot>,<contenttweaker:first_killcount_token>,T1Ingots|<minecraft:iron_ingot>],
    [<minecraft:redstone>,<dcs_climate:dcs_device_bellow>,<minecraft:redstone>],
    [T1Ingots|<minecraft:iron_ingot>,<minecraft:redstone>,T1Ingots|<minecraft:iron_ingot>]
]
);

recipes.addShaped("hac_first_windmill",<dcs_climate:dcs_device_windmill>*4,
[
    [<ore:plankWood>,<contenttweaker:first_killcount_token>,<ore:plankWood>],
    [<contenttweaker:first_killcount_token>,<dcs_climate:dcs_spindle:1>,<contenttweaker:first_killcount_token>],
    [<ore:plankWood>,<contenttweaker:first_killcount_token>,<ore:plankWood>],
]
);

// Tier 2
// Considering we need T3 machine Dynamo to charge IC2 Blades,
// We move Dynamo from T3 to T2.
val T2Machines = <dcs_climate:dcs_device_windmill_l>|<dcs_climate:dcs_device_watermill>|<dcs_climate:dcs_device_reactor_ibc>|<dcs_climate:dcs_device_heat_exchanger>|<dcs_climate:dcs_device_dynamo>;
recipes.remove(T2Machines);
recipes.addShaped("hac_second_windmill",<dcs_climate:dcs_device_windmill_l>,
[
    [<ore:itemCloth>,<dcs_climate:dcs_device_shaft_s_steel>,<ore:itemCloth>],
    [<contenttweaker:second_killcount_token>,<dcs_climate:dcs_device_windmill>,<contenttweaker:second_killcount_token>],
    [<ore:itemCloth>,<dcs_climate:dcs_device_shaft_s_steel>,<ore:itemCloth>]
]);