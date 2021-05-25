#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;

// Soldering Iron
var solderingIron = mods.contenttweaker.VanillaFactory.createItem("soldering_iron");
solderingIron.creativeTab = <creativetab:tools>;
solderingIron.setMaxStackSize(1);
solderingIron.rarity = "common";
solderingIron.glowing = false;
solderingIron.register();

// Lemon Battery Materials
var copperChip = mods.contenttweaker.VanillaFactory.createItem("copper_chip");
copperChip.creativeTab = <creativetab:dcs_climate>;
copperChip.rarity = "common";
copperChip.glowing = false;
copperChip.register();

var zincChip = mods.contenttweaker.VanillaFactory.createItem("zinc_chip");
zincChip.creativeTab = <creativetab:dcs_climate>;
zincChip.rarity = "common";
zincChip.glowing = false;
zincChip.register();

var lemonBattery = mods.contenttweaker.VanillaFactory.createItem("lemon_battery");
lemonBattery.creativeTab = <creativetab:dcs_climate>;
lemonBattery.rarity = "common";
lemonBattery.glowing = false;
lemonBattery.register();

// This Item's current texture is made by:
// https://twitter.com/endesga/status/972683776277954561
// Remember to credit the author ENDESGA
var solderWire = mods.contenttweaker.VanillaFactory.createItem("solder_wire");
solderWire.creativeTab = <creativetab:dcs_climate>;
solderWire.rarity = "common";
solderWire.glowing = false;
solderWire.register();