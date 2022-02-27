import crafttweaker.item.IItemStack;
import mods.touhoulittlemaid.Altar;
val armorInputs as IItemStack[] = [
    <ic2:nano_boots:*>,
    <ic2:nano_chestplate:*>,
    <ic2:nano_helmet:*>,
    <ic2:nano_leggings:*>,
    <ic2:quantum_boots:*>,
    <ic2:quantum_chestplate:*>,
    <ic2:quantum_helmet:*>,
    <ic2:quantum_leggings:*>
];

val armorOutputs as IItemStack[] = [
    <ic2:nano_boots>.withTag({charge: 1000000.0}),
    <ic2:nano_chestplate>.withTag({charge: 1000000.0}),
    <ic2:nano_helmet>.withTag({charge: 1000000.0}),
    <ic2:nano_leggings>.withTag({charge: 1000000.0}),
    <ic2:quantum_boots>.withTag({charge: 1.0E7}),
    <ic2:quantum_chestplate>.withTag({charge: 1.0E7}),
    <ic2:quantum_helmet>.withTag({charge: 1.0E7}),
    <ic2:quantum_leggings>.withTag({charge: 1.0E7})
];

val essence as IItemStack = <abyssalcraft:gatekeeperessence>;

for index in 0 .. 4 {
    Altar.addItemCraftRecipe("nano_charging" + index, 2.5,
                         armorOutputs[index], 
                         armorInputs[index],
                         essence,
                         essence
                        );
}

for index in 4 .. 8 {
    Altar.addItemCraftRecipe("quantum_charging" + index, 5.0,
                         armorOutputs[index], 
                         armorInputs[index],
                         essence,
                         essence,
                         essence,
                         essence
                        );
}