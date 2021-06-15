#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;

// KillCount Tokens
var firstKillCount = mods.contenttweaker.VanillaFactory.createItem("first_killcount_token");
firstKillCount.creativeTab = <creativetab:lastsmith>;
firstKillCount.rarity = "common";
firstKillCount.glowing = false;
firstKillCount.register();

var secondKillCount = mods.contenttweaker.VanillaFactory.createItem("second_killcount_token");
secondKillCount.creativeTab = <creativetab:lastsmith>;
secondKillCount.rarity = "uncommon";
secondKillCount.glowing = false;
secondKillCount.register();

var thirdKillCount = mods.contenttweaker.VanillaFactory.createItem("third_killcount_token");
thirdKillCount.creativeTab = <creativetab:lastsmith>;
thirdKillCount.rarity = "rare";
thirdKillCount.glowing = true;
thirdKillCount.register();

var fourthKillCount = mods.contenttweaker.VanillaFactory.createItem("fourth_killcount_token");
fourthKillCount.creativeTab = <creativetab:lastsmith>;
fourthKillCount.rarity = "epic";
fourthKillCount.glowing = true;
fourthKillCount.register();

// ProudSoul Bottles
var firstProudSoul = mods.contenttweaker.VanillaFactory.createItem("first_proudsoul_bottle");
firstProudSoul.creativeTab = <creativetab:lastsmith>;
firstProudSoul.rarity = "common";
firstProudSoul.glowing = false;
firstProudSoul.register();

var secondProudSoul = mods.contenttweaker.VanillaFactory.createItem("second_proudsoul_bottle");
secondProudSoul.creativeTab = <creativetab:lastsmith>;
secondProudSoul.rarity = "rare";
secondProudSoul.glowing = true;
secondProudSoul.register();

var thirdProudSoul = mods.contenttweaker.VanillaFactory.createItem("third_proudsoul_bottle");
thirdProudSoul.creativeTab = <creativetab:lastsmith>;
thirdProudSoul.rarity = "epic";
thirdProudSoul.glowing = true;
thirdProudSoul.register();