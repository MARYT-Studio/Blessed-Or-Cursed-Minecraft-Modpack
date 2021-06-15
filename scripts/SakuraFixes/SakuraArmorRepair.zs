import crafttweaker.item.IIngredient;
import mods.vanillaanvilrepair.addRepairEntry;
val samuraiArmor as IIngredient[] = [
    <sakura:samurai_helmet>,
    <sakura:samurai_chest>,
    <sakura:samurai_pants>,
    <sakura:samurai_shoes>
];
val solderArmor as IIngredient[] = [
    <sakura:soldier_helmet>,
    <sakura:soldier_chest>,
    <sakura:soldier_pants>,
    <sakura:soldier_shoes>
];
for armor in samuraiArmor
{
    addRepairEntry(armor, <sakura:sakura_diamond>);
}
for armor in solderArmor
{
    addRepairEntry(armor, <ore:ingotSteel>);
}