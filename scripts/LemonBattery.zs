// Two Chips
recipes.addShapeless(<contenttweaker:copper_chip> * 3,[<ore:ingotCopper>]);
recipes.addShapeless(<contenttweaker:zinc_chip> * 3,[<ore:ingotZinc>]);

val lemonBattery = <contenttweaker:lemon_battery>;
lemonBattery.addTooltip("电解质丰富的水果都可以做电池，");
lemonBattery.addTooltip("为什么非得是柚子呢？");
lemonBattery.addTooltip("将其与烙铁合成可以给烙铁充电，");
lemonBattery.addTooltip("或作为熔炉的燃料。");
lemonBattery.addShiftTooltip("§o向曾经带给我们欢乐的苹果奶茶MOD致敬。");

recipes.addShapeless("lemon_battery",lemonBattery,[<contenttweaker:copper_chip>,<contenttweaker:zinc_chip>,<ore:cropLemon>]);

// Lemon Battery for furnace fuel
furnace.setFuel(lemonBattery, 4800);