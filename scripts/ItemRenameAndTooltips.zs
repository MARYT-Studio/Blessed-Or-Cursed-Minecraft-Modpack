// Vanilla Minecraft
<minecraft:experience_bottle>.addTooltip(game.localize("crafttweaker.experience_bottle.tooltip"));

// Energy Converter
game.setLocalization("tile.energy_producer_eu.hv.name", game.localize("crafttweaker.power_output.name"));
game.setLocalization("tile.energy_consumer_fe.name", game.localize("crafttweaker.power_input.name"));
game.setLocalization("tile.energy_bridge.name", game.localize("crafttweaker.power_converter.name"));
// ic2
<ic2:energy_crystal:26>.addTooltip(game.localize("crafttweaker.energy_crystal.tooltip"));

<ic2:lapotron_crystal:26>.addTooltip(game.localize("crafttweaker.useless_lapo_crystal.tooltip"));

<ic2:lapotron_crystal:0>.withTag({charge: 1.0E7}).addTooltip(game.localize("crafttweaker.full_lapo_crystal_1.tooltip"));
<ic2:lapotron_crystal:0>.withTag({charge: 1.0E7}).addTooltip(game.localize("crafttweaker.full_lapo_crystal_2.tooltip"));

// ContentTweaker
val lemonBattery = <contenttweaker:lemon_battery>;
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_1.tooltip"));
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_2.tooltip"));
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_3.tooltip"));
lemonBattery.addTooltip(game.localize("crafttweaker.lemon_battery_4.tooltip"));
lemonBattery.addShiftTooltip(game.localize("crafttweaker.lemon_battery_5.tooltip"));

val solderWire = <contenttweaker:solder_wire>;
solderWire.addTooltip(game.localize("crafttweaker.solder_wire.tooltip"));

val basicIC = <contenttweaker:basic_ic>;
basicIC.addTooltip(game.localize("crafttweaker.basic_ic.tooltip"));
basicIC.addShiftTooltip(game.localize("crafttweaker.ic_modules.tooltip"));

val advancedIC = <contenttweaker:advanced_ic>;
advancedIC.addTooltip(game.localize("crafttweaker.advanced_ic_1.tooltip"));
advancedIC.addTooltip(game.localize("crafttweaker.advanced_ic_2.tooltip"));
advancedIC.addShiftTooltip(game.localize("crafttweaker.ic_modules.tooltip"));