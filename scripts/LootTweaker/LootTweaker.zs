import loottweaker.LootTweaker;
import loottweaker.vanilla.loot.LootTable;
import loottweaker.vanilla.loot.LootPool;
//Remove HAC Magic Pictures Loot
LootTweaker.getTable("minecraft:chests/woodland_mansion").getPool("main").removeEntry("dcs_climate:forest_picture1");
LootTweaker.getTable("minecraft:chests/woodland_mansion").getPool("main").removeEntry("dcs_climate:forest_picture2");
//Remove HAC Blue Spellcard Loot
LootTweaker.getTable("minecraft:chests/jungle_temple").getPool("main").removeEntry("dcs_climate:jungle_card");
LootTweaker.getTable("minecraft:chests/stronghold_library").getPool("main").removeEntry("dcs_climate:stronghold_card9");
LootTweaker.getTable("minecraft:chests/stronghold_library").getPool("main").removeEntry("dcs_climate:stronghold_card14");
LootTweaker.getTable("minecraft:chests/stronghold_library").getPool("main").removeEntry("dcs_climate:stronghold_card15");