import crafttweaker.item.IItemStack;
val materials = <mcwfurnitures:oak_plate>|
<mcwfurnitures:spruce_plate>|
<mcwfurnitures:birch_plate>|
<mcwfurnitures:jungle_plate>|
<mcwfurnitures:acacia_plate>|
<mcwfurnitures:dark_oak_plate>|
<mcwfurnitures:cabinet_door>|
<mcwfurnitures:drawer>|
<mcwfurnitures:iron_handle>;

for itemToCheck in loadedMods["mcwfurnitures"].items
{
    if(!(materials.matches(itemToCheck)))
    {
        itemToCheck.addTooltip(game.localize("crafttweaker.mcwfurnitures.tooltip"));
    }
}