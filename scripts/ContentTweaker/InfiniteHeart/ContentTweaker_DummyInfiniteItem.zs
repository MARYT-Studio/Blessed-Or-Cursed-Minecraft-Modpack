#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
var dummyInfItem = mods.contenttweaker.VanillaFactory.createItem("dummy_infinite_item");
dummyInfItem.creativeTab = <creativetab:misc>;
dummyInfItem.rarity = "epic";
dummyInfItem.glowing = true;
dummyInfItem.maxStackSize = 1;
dummyInfItem.register();