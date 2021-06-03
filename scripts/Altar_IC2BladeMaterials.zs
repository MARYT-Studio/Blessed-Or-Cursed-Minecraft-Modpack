import mods.touhoulittlemaid.Altar;
// Three Outputs
val Lapotron = <ic2:lapotron_crystal>.withTag({charge: 1.0E7});
val EnergyCrystal = <ic2:energy_crystal>.withTag({charge: 1000000.0});
val IridiumPlate = <ic2:crafting:4>;

// Three Materials
val AdvancedAlloy = <ic2:crafting:3>;
val CircuitPlate = <contenttweaker:basic_ic>;
val AdvancedCircuit = <contenttweaker:advanced_ic>;

Altar.addItemCraftRecipe("lapotron_crystal", 4.0,
                         Lapotron,
                         EnergyCrystal,
                         <minecraft:lapis_block>,
                         AdvancedCircuit,
                         <contenttweaker:second_killcount_token>);
Altar.addItemCraftRecipe("energy_crystal", 2.0,
                         EnergyCrystal,
                         <minecraft:diamond>,
                         <minecraft:redstone_block>,
                         CircuitPlate,
                         <contenttweaker:first_proudsoul_bottle>);
Altar.addItemCraftRecipe("iridium_plate", 1.0,
                         IridiumPlate,
                         AdvancedAlloy,
                         // HAC Silver block
                         <dcs_climate:dcs_ore_metal_new:6>,
                         // HAC Activated White Cube
                         <dcs_climate:dcs_color_cube:9>);