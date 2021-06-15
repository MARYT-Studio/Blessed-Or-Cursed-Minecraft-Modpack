#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;

// Basic Circuit
var basicIC = mods.contenttweaker.VanillaFactory.createItem("basic_ic");
basicIC.creativeTab = <creativetab:ic2>;
basicIC.rarity = "common";
basicIC.glowing = false;
basicIC.register();

// Advanced Circuit
var advancedIC = mods.contenttweaker.VanillaFactory.createItem("advanced_ic");
advancedIC.creativeTab = <creativetab:ic2>;
advancedIC.rarity = "common";
advancedIC.glowing = false;
advancedIC.register();