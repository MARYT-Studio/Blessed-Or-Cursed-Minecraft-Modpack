import mods.touhoulittlemaid.Altar;
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
val T2Machines = <dcs_climate:dcs_device_windmill_l>|
    <dcs_climate:dcs_device_watermill>|
    <dcs_climate:dcs_device_reactor_ibc>|
    <dcs_climate:dcs_device_heat_exchanger>|
    <dcs_climate:dcs_device_dynamo>|
    <energyconverters:energy_bridge>|
    <energyconverters:energy_consumer_fe>|
    <energyconverters:energy_producer_eu:2>; 
recipes.remove(T2Machines);
recipes.addShaped("hac_second_windmill",<dcs_climate:dcs_device_windmill_l> * 2,
[
    [<ore:itemCloth>,<dcs_climate:dcs_device_shaft_s_steel>,<ore:itemCloth>],
    [<contenttweaker:second_killcount_token>,<dcs_climate:dcs_device_windmill>,<contenttweaker:second_killcount_token>],
    [<ore:itemCloth>,<dcs_climate:dcs_device_shaft_s_steel>,<ore:itemCloth>]
]);
recipes.addShaped("hac_watermill",<dcs_climate:dcs_device_watermill>,
[
    [<contenttweaker:tech_shard>, <ic2:plate:12>, <contenttweaker:second_killcount_token>],
    [<ic2:plate:12>, <dcs_climate:dcs_device_shaft_x_steel>, <ic2:plate:12>],
    [<contenttweaker:second_killcount_token>, <ic2:plate:12>, <contenttweaker:tech_shard>]
]);
recipes.addShaped("hac_reactor_ibc",<dcs_climate:dcs_device_reactor_ibc>,
[
    [null, <minecraft:brewing_stand>, null],
    [<contenttweaker:tech_shard>, <contenttweaker:tech_shard>, <contenttweaker:tech_shard>],
    [<ic2:plate:12>, <dcs_climate:dcs_device_ibc>, <ic2:plate:12>]
]);
recipes.addShaped("hac_heat_exchanger",<dcs_climate:dcs_device_heat_exchanger>,
[
    [<contenttweaker:second_killcount_token>, <futuremc:netherite_ingot>, <contenttweaker:tech_shard>],
    [<dcs_climate:dcs_color_cube:5>, <dcs_climate:dcs_color_cube:7>, <contenttweaker:first_proudsoul_bottle>],
    [<contenttweaker:second_killcount_token>, <futuremc:netherite_ingot>, <contenttweaker:tech_shard>]
]);
recipes.addShaped("hac_dynamo",<dcs_climate:dcs_device_dynamo>,
[
    [<tofucraft:material:23>, null, <tofucraft:material:23>],
    [<ic2:plate:16>, <contenttweaker:basic_ic>, <ic2:plate:16>],
    [<ic2:plate:16>, <contenttweaker:tech_shard>, <ic2:plate:16>]
]);

// Energy Converters
// Tho they are not HAC machines, their recipes are listed here.
// They are also T2 Machines.
recipes.addShaped("power_converter_input",<energyconverters:energy_consumer_fe>,
[
    [null, <tofucraft:material:21>, null],
    [null, <contenttweaker:basic_ic>, null],
    [<ic2:plate:12>, <contenttweaker:tech_shard>, <ic2:plate:12>]
]);
recipes.addShaped("power_converter_output",<energyconverters:energy_producer_eu:2>,
    [[null, <tofucraft:material:23>, null],
    [null, <contenttweaker:basic_ic>, null],
    [<ic2:plate:12>, <contenttweaker:tech_shard>, <ic2:plate:12>]
]);
recipes.addShaped("power_converter",<energyconverters:energy_bridge>,
[
    [<ic2:plate:12>, <contenttweaker:basic_ic>, <ic2:plate:12>],
    [<ic2:plate:12>, <contenttweaker:tech_shard>, <ic2:plate:12>]
]);

// IC2 MFE
// This machine is also T2 Machine.
val MFE = <ic2:te:70>.withTag({});
Altar.addItemCraftRecipe("ic2_mfe", 0.5,
                        MFE,
                        <ic2:crafting:3>,
                        <tofucraft:material:23>,
                        <tofucraft:material:21>,
                        <contenttweaker:advanced_ic>,
                        <contenttweaker:tech_shard>,
                        <contenttweaker:first_proudsoul_bottle>
                        );