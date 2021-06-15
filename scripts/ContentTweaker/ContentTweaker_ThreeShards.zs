#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
// These three shards do not need specific creativetabs.
// If needed, simply use the commented commands.

// Sci-Tech Shard
var shardTech = mods.contenttweaker.VanillaFactory.createItem("tech_shard");
// shardTech.creativeTab = <creativetab:ic2>;
shardTech.rarity = "rare";
shardTech.glowing = false;
shardTech.register();

// Nature Shard
var shardNature = mods.contenttweaker.VanillaFactory.createItem("nature_shard");
// shardNature.creativeTab = <creativetab:ic2>;
shardNature.rarity = "rare";
shardNature.glowing = false;
shardNature.register();

// Magic(Thaumic) Shard
var shardThaumic = mods.contenttweaker.VanillaFactory.createItem("magic_shard");
// shardThaumic.creativeTab = <creativetab:ic2>;
shardThaumic.rarity = "rare";
shardThaumic.glowing = false;
shardThaumic.register();