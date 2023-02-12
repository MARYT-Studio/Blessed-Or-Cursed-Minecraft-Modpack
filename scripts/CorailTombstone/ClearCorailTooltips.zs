import crafttweaker.item.IIngredient;

val corailItems as IIngredient[] = [
    <tombstone:decorative_grave_simple>,
    <tombstone:decorative_grave_simple:1>,
    <tombstone:decorative_grave_normal>,
    <tombstone:decorative_grave_normal:1>,
    <tombstone:decorative_grave_cross>,
    <tombstone:decorative_grave_cross:1>,
    <tombstone:decorative_tombstone>,
    <tombstone:decorative_tombstone:1>,
    <tombstone:decorative_subaraki_grave>,
    <tombstone:decorative_subaraki_grave:1>,
    <tombstone:decorative_grave_original>,
    <tombstone:decorative_grave_original:1>,
    <tombstone:crafting_ingredient:4>];

for item in corailItems {
    // TODO: Wait for a new tooltip handler function
    item.clearTooltip();
}