#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.zenutils.cotx.Item;
// import crafttweaker.item.IMutableItemStack;
var builderpack_all = mods.contenttweaker.VanillaFactory.createExpandItem("cuisine_sapling_pack");
builderpack_all.creativeTab = <creativetab:misc>;
builderpack_all.rarity = "rare";
builderpack_all.maxStackSize = 1;
builderpack_all.itemUseAction = "BOW";
builderpack_all.register();