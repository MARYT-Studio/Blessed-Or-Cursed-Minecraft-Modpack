// Vanilla Minecraft
<minecraft:experience_bottle>.addTooltip("除了与村民交易，还有其他的获得方法");

// Energy Converter
game.setLocalization("zh_cn", "tile.energy_producer_eu.hv.name", "能量输出端口");
game.setLocalization("zh_cn", "tile.energy_consumer_fe.name", "能量接入端口");
game.setLocalization("zh_cn", "tile.energy_bridge.name", "能量转换器");

// ic2
<ic2:energy_crystal:26>.addTooltip("将它放在MFE中充满来制作纳米太刀");

<ic2:lapotron_crystal:26>.addTooltip("§c§l没有用途，不能获得");

<ic2:lapotron_crystal:0>.withTag({charge: 1.0E7}).addTooltip("直接合成得到，仅作为合成材料");
<ic2:lapotron_crystal:0>.withTag({charge: 1.0E7}).addTooltip("不能用于储存电量。");