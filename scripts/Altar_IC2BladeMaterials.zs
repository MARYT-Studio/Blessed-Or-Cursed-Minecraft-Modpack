import mods.touhoulittlemaid.Altar;
val Lapotron = <ic2:lapotron_crystal>.withTag({charge: 1.0E7});
val EnergyCrystal = <ic2:energy_crystal>.withTag({charge: 1000000.0});

val IridiumPlate = <ic2:crafting:4>;

Altar.addItemCraftRecipe("lapotron_crystal", 4.0,
                         Lapotron,
                         <minecraft:stone>,<minecraft:stone>,<minecraft:stone>);
Altar.addItemCraftRecipe("energy_crystal", 2.0,
                         EnergyCrystal,
                         <minecraft:dirt>,<minecraft:dirt>,<minecraft:dirt>);
Altar.addItemCraftRecipe("iridium_plate", 1.0,
                         IridiumPlate,
                         <minecraft:grass>,<minecraft:grass>,<minecraft:grass>);