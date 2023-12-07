import crafttweaker.item.IItemStack;

val tlsItems as IItemStack[] = loadedMods["lastsmith"].items;
val slashbladeItems as IItemStack[] = loadedMods["slashblade"].items;

for item in tlsItems {
    print(item.definition.id);
}

for item in slashbladeItems {
    print(item.definition.id);
}

// <contenttweaker:soldering_iron>.addAdvancedTooltip(
//     function(item)
//     {   
//         var solderingIronNBT as IData = item.tag;
//             if(isNull(solderingIronNBT.PowerLeft))
//             {
//                 return game.localize("crafttweaker.soldering_iron_nouse.tooltip");
//             }
//             else if(solderingIronNBT.PowerLeft.asInt() == 0)
//             {
//                 return game.localize("crafttweaker.soldering_iron_needcharge.tooltip");
//             }
//             else
//             {
//                 var powerLeft as float = solderingIronNBT.PowerLeft.asFloat();
//                 var displayPower as float = powerLeft * 6.25;
//                 return game.localize("crafttweaker.soldering_iron_1.tooltip") ~ displayPower ~ game.localize("crafttweaker.soldering_iron_2.tooltip");
//             }
//     }
// );