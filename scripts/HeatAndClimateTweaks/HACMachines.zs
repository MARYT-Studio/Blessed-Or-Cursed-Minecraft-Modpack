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
    <dcs_climate:dcs_device_stonemill>|
    <dcs_climate:dcs_device_watermill>|
    <dcs_climate:dcs_device_reactor_ibc>|
    <dcs_climate:dcs_device_heat_exchanger>|
    <dcs_climate:dcs_device_dynamo>|
    <energyconverters:energy_bridge>|
    <energyconverters:energy_consumer_fe>|
    <energyconverters:energy_producer_eu:2>; 
recipes.remove(T2Machines);
recipes.addShaped("hac_mill", <dcs_climate:dcs_device_stonemill>,
    [
        [<ore:stone>, <ore:stone>, <ore:stone>],
        [null, <dcs_climate:dcs_spindle:2>, null],
        [<ore:stone>, <contenttweaker:second_killcount_token>, <ore:stone>]
    ]
);
recipes.addShaped("hac_second_windmill",<dcs_climate:dcs_device_windmill_l> * 2,
[
    [<ore:itemCloth>,<dcs_climate:dcs_device_shaft_s_steel>,<ore:itemCloth>],
    [<contenttweaker:second_killcount_token>,<dcs_climate:dcs_device_windmill>,<contenttweaker:second_killcount_token>],
    [<ore:itemCloth>,<dcs_climate:dcs_device_shaft_s_steel>,<ore:itemCloth>]
]);
recipes.addShaped("hac_watermill",<dcs_climate:dcs_device_watermill>,
[
    [<contenttweaker:tech_shard>, <ic2:plate:12>, <contenttweaker:nature_shard>],
    [<ic2:plate:12>, <dcs_climate:dcs_device_shaft_x_steel>, <ic2:plate:12>],
    [<contenttweaker:nature_shard>, <ic2:plate:12>, <contenttweaker:tech_shard>]
]);
recipes.addShaped("hac_reactor_ibc",<dcs_climate:dcs_device_reactor_ibc>,
[
    [null, <minecraft:brewing_stand>, null],
    [<contenttweaker:tech_shard>, <contenttweaker:tech_shard>, <contenttweaker:tech_shard>],
    [<ic2:plate:12>, <dcs_climate:dcs_device_ibc>, <ic2:plate:12>]
]);
recipes.addShaped("hac_heat_exchanger",<dcs_climate:dcs_device_heat_exchanger>,
[
    [<contenttweaker:tech_shard>, <futuremc:netherite_ingot>, <futuremc:netherite_ingot>],
    [<minecraft:ice>|<minecraft:packed_ice>|<futuremc:blue_ice>,<contenttweaker:second_killcount_token>,<dcs_climate:dcs_cont_metal:5>],
    [<contenttweaker:magic_shard>, <futuremc:netherite_ingot>, <futuremc:netherite_ingot>]
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

// HAC T3 Machines
val T3Machines = <dcs_climate:dcs_device_brewing_under>|
<dcs_climate:dcs_device_distillator>|
<dcs_climate:dcs_device_windmill_ex>|
<dcs_climate:dcs_device_boiler_turbine>|
<dcs_climate:dcs_device_gas_burner>|
<dcs_climate:dcs_device_diesel_engine>|
<dcs_climate:dcs_device_kinetic_motor>|
<dcs_climate:dcs_device_reactor>|
<dcs_climate:dcs_device_crusher>|
<dcs_climate:dcs_device_freezer>|
<dcs_climate:dcs_device_tankyard>|
<dcs_climate:dcs_device_yardpart>|
<dcs_climate:dcs_device_press_machine>|
<dcs_climate:dcs_device_portal_manager>|
<dcs_climate:dcs_device_player_panel>;
recipes.remove(T3Machines);
recipes.addShaped("brewing_under_new", <dcs_climate:dcs_device_brewing_under>,
    [
        [<ore:ingotSUS>, <contenttweaker:third_killcount_token>, <ore:ingotSUS>],
        [<dcs_climate:dcs_ingot:18>, <ore:bucketEmpty>, <dcs_climate:dcs_ingot:18>],
        [<dcs_climate:dcs_ingot:17>, <ore:ingotSUS>, <dcs_climate:dcs_ingot:17>]
    ]
);
recipes.addShaped("distillator_new", <dcs_climate:dcs_device_distillator>,
    [
        [<twilightforest:carminite>, <contenttweaker:third_killcount_token>, <twilightforest:carminite>],
        [<dcs_climate:dcs_ingot:18>, null, <dcs_climate:dcs_ingot:18>],
        [<ore:ingotSUS>, <twilightforest:knightmetal_block>, <ore:ingotSUS>]
    ]
);
recipes.addShaped("windmill_ex_new", <dcs_climate:dcs_device_windmill_ex> * 4,
    [
        [<contenttweaker:third_killcount_token>, <dcs_climate:dcs_device_shaft_s_sus>, <contenttweaker:third_killcount_token>],
        [<dcs_climate:dcs_device_shaft_s_sus>, <dcs_climate:dcs_device_windmill_l>, <dcs_climate:dcs_device_shaft_s_sus>],
        [<contenttweaker:third_killcount_token>, <dcs_climate:dcs_device_shaft_s_sus>, <contenttweaker:third_killcount_token>]
    ]
);
recipes.addShaped("boiler_turbine_new", <dcs_climate:dcs_device_boiler_turbine>,
    [
        [<dcs_climate:dcs_ingot:18>, <dcs_climate:dcs_ingot:18>, <ore:ingotStainlessSteel>],
        [<contenttweaker:third_killcount_token>, <ore:gearToolSteel>, <dcs_climate:dcs_device_heat_exchanger>],
        [<dcs_climate:dcs_ingot:18>, <dcs_climate:dcs_ingot:18>, <ore:ingotStainlessSteel>]
    ]
);
recipes.addShaped("gas_burner_new", <dcs_climate:dcs_device_gas_burner>,
    [
        [<ore:ingotStainlessSteel>, null, <ore:ingotStainlessSteel>],
        [<twilightforest:naga_scale>, null, <twilightforest:naga_scale>],
        [<ore:gearToolSteel>, <contenttweaker:second_proudsoul_bottle>, <twilightforest:block_storage:2>] // 钢叶块
    ]
);
recipes.addShaped("diesel_engine_new", <dcs_climate:dcs_device_diesel_engine> * 2,
    [
        [<dcs_climate:dcs_ingot:18>, <contenttweaker:third_killcount_token>, <dcs_climate:dcs_ingot:18>],
        [<dcs_climate:dcs_ingot:18>, <dcs_climate:dcs_mechanical:3>, <dcs_climate:dcs_ingot:18>],
        [<ore:ingotStainlessSteel>, <minecraft:piston>, <ore:ingotStainlessSteel>]
    ]
);
recipes.addShaped("kinetic_motor_new", <dcs_climate:dcs_device_kinetic_motor>,
    // 暂时未作修改
    [
        [<dcs_climate:dcs_device_shaft_s_sus>, <ore:gearToolSteel>, <dcs_climate:dcs_mechanical>],
        [<ore:ingotStainlessSteel>, <ore:ingotStainlessSteel>, <ore:ingotStainlessSteel>]
    ]
);
recipes.addShaped("reactor_new", <dcs_climate:dcs_device_reactor>,
    [
        [<dcs_lib:dcs_checker>, <dcs_climate:dcs_device_steel_pot>, <contenttweaker:third_killcount_token>],
        [<dcs_climate:dcs_mechanical>, <dcs_climate:dcs_ingot:18>, <dcs_climate:dcs_ingot:18>],
        [<twilightforest:knightmetal_block>, <ore:gearToolSteel>, <twilightforest:block_storage:4>]
    ]
);
recipes.addShaped("crusher_new", <dcs_climate:dcs_device_crusher>,
    [
        [null, <minecraft:hopper>, null],
        [<ore:gearToolSteel>, <dcs_climate:dcs_mechanical>, <ore:gearToolSteel>],
        [<twilightforest:knightmetal_block>, <contenttweaker:third_killcount_token>, <twilightforest:block_storage:4>]
    ]
);
recipes.addShaped("freezer_new", <dcs_climate:dcs_device_freezer>,
    [
        [<dcs_climate:dcs_device_ibc>, <twilightforest:naga_scale>, <twilightforest:naga_scale>],
        [<contenttweaker:second_proudsoul_bottle>, <minecraft:end_rod>, <minecraft:dragon_breath>],
        [<twilightforest:block_storage:2>, <ore:gearToolSteel>, <ore:ingotStainlessSteel>]
    ]
);
recipes.addShaped("press_machine_new", <dcs_climate:dcs_device_press_machine>,
    [
        [<ore:ingotStainlessSteel>, <ore:gearToolSteel>, <ore:ingotStainlessSteel>],
        [<ore:ingotStainlessSteel>, <contenttweaker:second_proudsoul_bottle>, <ore:ingotStainlessSteel>],
        [<ore:ingotStainlessSteel>, <twilightforest:knightmetal_block>, <ore:ingotStainlessSteel>]
    ]
);
// Recipes of Transportation And Storage Machines
recipes.addShapeless("tankyard_new", <dcs_climate:dcs_device_tankyard>, [<dcs_climate:dcs_device_yardpart>, <ore:gearSteel>]);
recipes.addShaped("yardpart_new", <dcs_climate:dcs_device_yardpart> * 8, [[null, <ore:ingotStainlessSteel>, null], [<ore:ingotStainlessSteel>, <ore:blockGlass>, <ore:ingotStainlessSteel>], [null, <ore:ingotStainlessSteel>, null]]);
recipes.addShaped("portal_manager_new", <dcs_climate:dcs_device_portal_manager>, [[<ore:ingotSilver>, <dcs_climate:dcs_gemcore>, <ore:ingotSilver>], [<ore:ingotBSCCO>, <dcs_climate:dcs_mechanical>, <ore:ingotBSCCO>], [<ore:ingotSilver>, <ore:gearToolSteel>, <ore:ingotSilver>]]);
recipes.addShaped("player_panel_new", <dcs_climate:dcs_device_player_panel>, [[<ore:blockGlass>, <ore:blockGlass>, <ore:blockGlass>], [null, <ore:gemBismuth>, null], [<ore:gemSchorl>, <dcs_climate:dcs_mechanical:6>, <ore:gemSchorl>]]);