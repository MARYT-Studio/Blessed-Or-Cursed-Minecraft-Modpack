#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;
import mods.zenutils.EventPriority;
import scripts.GlobalVars;
import crafttweaker.data.IData;

// 当物品的 Refine 数值即将超过上限值时，拒绝此次锻造
events.register(function (event as PlayerAnvilUpdateEvent) {
    var item = event.leftItem;
    var tag = item.tag;
    if (isNull(tag)) return;
    var dTag = D(tag);
    var refine = dTag.getInt("RepairCounter");
    var limit = dTag.getInt("RefineLimit", 2147483647);
    var player = event.player;
    var playerTag = D(player.data);
    if (refine >= limit) {
        if (!player.world.remote) {
            if (playerTag.getInt("refine_limit_message_sent") == 1) {
                var text as string[] = game.localize("crafttweaker.cannot_be_refined").split("<br>");
                player.sendToast({text: text[0]} as IData, {text: text[1]} as IData, item);
                player.update({"refine_limit_message_sent": 3});
            } else {
                player.update({"refine_limit_message_sent": playerTag.getInt("refine_limit_message_sent") - 1});
            }
        }
        event.cancel();
        return;
    }
    if (limit != 2147483647) {       
        if (!player.world.remote) {
            if (playerTag.getInt("refine_limit_message_sent") == 1) {
                var remaining as string = "" ~ (limit - refine);
                var text as string[] = game.localize("crafttweaker.can_be_refined", remaining).split("<br>");
                player.sendToast({text: text[0]} as IData, {text: text[1]} as IData, item);
                player.update({"refine_limit_message_sent": 3});
            } else {
                player.update({"refine_limit_message_sent": playerTag.getInt("refine_limit_message_sent") - 1});
            }         
        }
    }
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
