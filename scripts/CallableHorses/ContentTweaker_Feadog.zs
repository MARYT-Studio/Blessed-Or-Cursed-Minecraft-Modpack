#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.zenutils.cotx.Item;
// import crafttweaker.item.IMutableItemStack;
var feadog = mods.contenttweaker.VanillaFactory.createExpandItem("feadog");
feadog.creativeTab = <creativetab:horsetweaks>;
feadog.rarity = "epic";
feadog.glowing = false;
feadog.maxStackSize = 1;
feadog.itemUseAction = "BOW";
feadog.register();
