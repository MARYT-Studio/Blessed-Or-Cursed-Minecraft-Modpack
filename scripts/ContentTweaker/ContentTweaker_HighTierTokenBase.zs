#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
// These three shards do not need specific creativetabs.
// If needed, simply use the commented commands.

// Sci-Tech Shard
var thirdKillCountTokenBase = mods.contenttweaker.VanillaFactory.createItem("third_killcount_token_base");
thirdKillCountTokenBase.rarity = "rare";
thirdKillCountTokenBase.glowing = false;
thirdKillCountTokenBase.register();

// Nature Shard
var fourthKillCountTokenBase = mods.contenttweaker.VanillaFactory.createItem("fourth_killcount_token_base");
fourthKillCountTokenBase.rarity = "epic";
fourthKillCountTokenBase.glowing = false;
fourthKillCountTokenBase.register();

// Magic(Thaumic) Shard
var thirdProudSoulBottleBase = mods.contenttweaker.VanillaFactory.createItem("third_proudsoul_bottle_base");
thirdProudSoulBottleBase.rarity = "epic";
thirdProudSoulBottleBase.glowing = false;
thirdProudSoulBottleBase.register();