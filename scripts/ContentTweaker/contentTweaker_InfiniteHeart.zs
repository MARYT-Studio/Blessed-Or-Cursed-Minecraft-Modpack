#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
// import crafttweaker.item.IMutableItemStack;
var infHeart = mods.contenttweaker.VanillaFactory.createItem("infinite_heart_laevatain");
infHeart.creativeTab = <creativetab:misc>;
infHeart.rarity = "epic";
infHeart.glowing = true;
infHeart.maxStackSize = 1;
infHeart.itemUseAction = "BOW";
infHeart.register();