#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;
import mods.zenutils.EventPriority;
import scripts.GlobalVars;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.text.ITextComponent;
import scripts.OriginalMechanism.DeathPenalty.Event_RefineLimitRewards;

// 当物品的 Refine 数值即将超过上限值时，拒绝此次锻造
events.register(function (event as PlayerAnvilUpdateEvent) {
    var item = event.leftItem;
    var tag = item.tag;
    if (isNull(tag)) return;
    var dTag = D(tag);
    if (!(dTag.check("SlashBlade"))) return;

    // 拔刀剑锻造上限的纠正逻辑
    if (GlobalVars.baseRefineLimit > dTag.getInt("RefineLimit")) {
        item.mutable().updateTag({"RefineLimit": GlobalVars.baseRefineLimit});
    }
    if (dTag.check("RefineLimitGained")) {
        var totalLimitGained = GlobalVars.baseRefineLimit;
        var gainedMap = item.tag.RefineLimitGained.asMap();
        for value in gainedMap.valueSet {
            totalLimitGained += value.asInt();
        }
        if (totalLimitGained > dTag.getInt("RefineLimit")) {
            print("warning: this blade's refine limit is corrected.");
            item.mutable().updateTag({"RefineLimit": totalLimitGained});
        } else if (totalLimitGained < dTag.getInt("RefineLimit")) {
            print("warning: this blade's map recorded limit is less than refine limit it has.");
        }
    }

    var refine = dTag.getInt("RepairCounter");
    var limit = dTag.getInt("RefineLimit", 2147483647);
    var player = event.player;
    var playerTag = D(player.data);
    if (refine >= limit) {
        if (!player.world.remote) {
            if (playerTag.getInt("refine_limit_message_sent") == 1) {
                player.sendToast("crafttweaker.cannot_be_refined.1", "", "crafttweaker.cannot_be_refined.2", "", item);
                bladeInfo(player, item);
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
                player.sendToast("crafttweaker.can_be_refined.1", "" ~ remaining, "crafttweaker.can_be_refined.2", "", item);
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

// 工具函数：打印拔刀剑的锻造上限信息

//  维度 ID 列表
static dimID as string[] = ["0", "-1", "56", "1", "7", "28885", "50", "51", "52", "53"];

function bladeInfo(player as IPlayer, blade as IItemStack) as void {
    if (isNull(blade.tag)) return;
    var dTag = D(blade.tag);
    if (dTag.check("RefineLimitGained")) {
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.refine_info.title"));
        for id in dimID {
            player.sendRichTextMessage(ITextComponent.fromTranslation(
                    ("crafttweaker.refine_info.dim" ~ id),
                    ("" ~ dTag.getInt("RefineLimitGained.DIM" ~ id) ~ "/" ~ Event_RefineLimitRewards.rewardMap.memberGet("DIM" ~ id).asInt())
                )
            );
        }
        player.sendRichTextMessage(ITextComponent.fromTranslation(
                "crafttweaker.refine_info.sum", 
                ("§c" ~ dTag.getInt("RepairCounter") ~ "/" ~ dTag.getInt("RefineLimit"))
            )
        );
    }    
}
