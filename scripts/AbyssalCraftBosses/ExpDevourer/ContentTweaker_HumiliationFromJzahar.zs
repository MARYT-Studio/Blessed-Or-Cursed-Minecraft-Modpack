#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.zenutils.cotx.Item;
// import crafttweaker.item.IMutableItemStack;
var infHeart = mods.contenttweaker.VanillaFactory.createExpandItem("humiliation_from_jzahar");
infHeart.creativeTab = <creativetab:acitems>;
infHeart.rarity = "uncommon";
infHeart.maxStackSize = 1;
infHeart.itemUseAction = "BOW";
infHeart.register();