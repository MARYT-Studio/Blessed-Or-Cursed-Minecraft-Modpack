#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;
import mods.zenutils.EventPriority;
import scripts.GlobalVars;

// 当物品的 Refine 数值即将超过上限值时，拒绝此次锻造
events.register(function (event as PlayerAnvilUpdateEvent) {
    var item = event.leftItem;
    var tag = item.tag;
    if (isNull(tag)) return;
    var dTag = D(tag);
    var refine = dTag.getInt("RepairCounter");
    var limit = dTag.getInt("RefineLimit", 2147483647);
    if (refine >= limit) event.cancel();
},EventPriority.highest(), true);

// 给拔刀剑添加锻刀上限
events.register(function (event as PlayerAnvilUpdateEvent) {
    var output = event.outputItem;
    if (loadedMods["flammpfeil.slashblade"].items has output || loadedMods["lastsmith"].items has output) {
        var tag = output.tag;
        if (!isNull(tag)) {
            var dTag = D(tag);
            if (dTag.getInt("RefineLimit") == 0) {
                event.outputItem = output.withTag(tag + {RefineLimit: GlobalVars.baseRefineLimit});
            }
        }
    }
},EventPriority.lowest(), true);
