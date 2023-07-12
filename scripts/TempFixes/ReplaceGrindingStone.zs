// Tooltips
<futuremc:grindstone>.addTooltip(game.localize("crafttweaker.grindstone_is_temporarily_banned_1.tooltip"));
<futuremc:grindstone>.addTooltip(game.localize("crafttweaker.grindstone_is_temporarily_banned_2.tooltip"));

// Spell Cloth from Botania, use this to replace Grindstones.
recipes.remove(<botania:spellcloth>);
recipes.addShapeless("spell_cloth", <botania:spellcloth>, 
    [
        <ore:enderpearl>, <ore:paper>
    ]
);
