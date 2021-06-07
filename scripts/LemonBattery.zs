// Two Chips
recipes.addShapeless(<contenttweaker:copper_chip> * 3,[<ore:ingotCopper>]);
recipes.addShapeless(<contenttweaker:zinc_chip> * 3,[<ore:ingotZinc>]);

val lemonBattery = <contenttweaker:lemon_battery>;

recipes.addShapeless("lemon_battery",lemonBattery,[<contenttweaker:copper_chip>,<contenttweaker:zinc_chip>,<ore:cropLemon>]);

// Lemon Battery for furnace fuel
furnace.setFuel(lemonBattery, 4800);