// Recipe removal
mods.jei.JEI.removeAndHide(<futuremc:grindstone>);
// Tooltips
<futuremc:grindstone>.addTooltip(game.localize("crafttweaker.grindstone_is_temporarily_banned.tooltip"));

// Spell Cloth from Botania, use this to replace Grindstones.
recipes.remove(<botania:spellcloth>);
recipes.addShapeless("spell_cloth", <botania:spellcloth>, [<ore:enderpearl>, <ore:paper>]);