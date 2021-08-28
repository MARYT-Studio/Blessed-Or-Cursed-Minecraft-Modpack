#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
// These three shards do not need specific creativetabs.
// If needed, simply use the commented commands.

// Small Hunting Dim Token
var smallHDToken = mods.contenttweaker.VanillaFactory.createItem("inner_shard");
smallHDToken.rarity = "rare";
smallHDToken.glowing = false;
smallHDToken.register();

// Hunting Dim Token
var shardNature = mods.contenttweaker.VanillaFactory.createItem("inner_gem");
shardNature.rarity = "rare";
shardNature.glowing = true;
shardNature.register();