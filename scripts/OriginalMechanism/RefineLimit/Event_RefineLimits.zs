#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;
import crafttweaker.event.PlayerInteractEntityEvent;
import mods.zenutils.EventPriority;
import scripts.GlobalVars;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.text.ITextComponent;

import crafttweaker.util.Math;

import scripts.GlobalVars.debug as debug;
import scripts.GlobalVars.baseRefineLimit as baseRefineLimit;
import scripts.GlobalVars.rewardMap as rewardMap;
import scripts.GlobalVars.blankMap as blankMap;
import scripts.GlobalVars.anvilActionTime as anvilActionTime;

// 当物品的 Refine 数值即将超过上限值时，拒绝此次锻造
events.register(function (event as PlayerAnvilUpdateEvent) {

    // 事件被取消时直接返回，对应不可锻造的拔刀剑（目前是新手剑）
    if (event.isCanceled()) return;

    var item = event.leftItem;
    var tag = item.tag;
    if (isNull(tag)) return;
    var dTag = D(tag);
    if (!(dTag.check("SlashBlade"))) return;

    // 拔刀剑锻造上限的纠正逻辑
    if (baseRefineLimit > dTag.getInt("RefineLimit")) {
        item.mutable().updateTag({"RefineLimit": baseRefineLimit});
    }
    if (dTag.check("RefineLimitGained")) {
        var totalLimitGained = baseRefineLimit;
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
            if (!isSameAnvilAction(player, event.getTimeStamp())) {
                player.sendToast("crafttweaker.cannot_be_refined.1", "", "crafttweaker.cannot_be_refined.2", "", item);
                bladeInfo(player, item);
            }
        }
        event.cancel();
        return;
    }
    if (limit != 2147483647) {       
        if (!player.world.remote) {
            if (!isSameAnvilAction(player, event.getTimeStamp())) {
                var remaining as string = "" ~ (limit - refine);
                player.sendToast("crafttweaker.can_be_refined.1", "" ~ remaining, "crafttweaker.can_be_refined.2", "", item);
            }
        }
    }
},EventPriority.high(), true);

// 给拔刀剑添加锻刀上限
events.register(function (event as PlayerAnvilUpdateEvent) {
    var output = event.outputItem;
    if (loadedMods["flammpfeil.slashblade"].items has output || loadedMods["lastsmith"].items has output) {
        var tag = output.tag;
        if (!isNull(tag)) {
            var dTag = D(tag);
            if (dTag.getInt("RefineLimit") == 0) {
                event.outputItem = output.withTag(tag + {RefineLimit: baseRefineLimit});
            }
        }
    }
},EventPriority.lowest(), true);

// 拔刀剑的锻刀上限查看
events.onPlayerInteractEntity(function (event as PlayerInteractEntityEvent) {
    var player = event.player;
    
    if (player.world.remote) return;

    if (player.isSneaking) {
            var target = event.target;
            if (target.definition.id.endsWith("slashblade:bladestand")) {
                var bladeStandTags = D(target.nbt);
                if (bladeStandTags.check("Blade.tag")) {
                    var dTag = D(bladeStandTags.get("Blade.tag"));
                    if (dTag.check("RefineLimitGained")) {
                        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.refine_info.title"));
                        for id in dimID {
                            player.sendRichTextMessage(ITextComponent.fromTranslation(
                                    ("crafttweaker.refine_info.dim" ~ id),
                                    ("" ~ dTag.getInt("RefineLimitGained.DIM" ~ id) ~ "/" ~ rewardMap.memberGet("DIM" ~ id).asInt())
                                )
                            );
                        }
                        player.sendRichTextMessage(ITextComponent.fromTranslation(
                                "crafttweaker.refine_info.sum", 
                                ("§c" ~ dTag.getInt("RepairCounter") ~ "/" ~ dTag.getInt("RefineLimit"))
                            )
                        );
                    } else {
                    // 初始化
                    if (debug) player.sendChat("Initializing Gained Map");
                    var initMap as IData = blankMap;
                    var world = player.world;
                    var refineLimit = dTag.getInt("RefineLimit", baseRefineLimit);
                    target.nbt.update({
                        "Blade": {
                            "tag": {
                                "RefineLimitGained": initMap, 
                                "RefineLimit": refineLimit                             
                            }
                        }
                    });
                    
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.refine_info.title"));
                    for id in dimID {
                        player.sendRichTextMessage(ITextComponent.fromTranslation(
                                ("crafttweaker.refine_info.dim" ~ id),
                                ("" ~ dTag.getInt("RefineLimitGained.DIM" ~ id) ~ "/" ~ rewardMap.memberGet("DIM" ~ id).asInt())
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
        }
    }
});

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
                    ("" ~ dTag.getInt("RefineLimitGained.DIM" ~ id) ~ "/" ~ GlobalVars.rewardMap.memberGet("DIM" ~ id).asInt())
                )
            );
        }
        player.sendRichTextMessage(ITextComponent.fromTranslation(
                "crafttweaker.refine_info.sum", 
                ("§c" ~ dTag.getInt("RepairCounter") ~ "/" ~ dTag.getInt("RefineLimit"))
            )
        );
    } else {
        // 初始化
        if (debug) player.sendChat("Initializing Gained Map");
        var initMap as IData = blankMap;
        var world = player.world;
        var refineLimit = dTag.getInt("RefineLimit", baseRefineLimit);
        blade.mutable().updateTag({"RefineLimitGained": initMap, "RefineLimit": refineLimit});
    }    
}

// 工具函数：铁砧更新事件消抖函数
function isSameAnvilAction(player as IPlayer, timeStamp as long) as bool {
    
    var playerTag = D(player.data);
    var lastAnvilAction = playerTag.getLong("last_anvil_action", -1L);
    var anvilActionCount = playerTag.getInt("anvil_action_count", 0);
    if (Math.abs(lastAnvilAction - timeStamp) >= anvilActionTime) {
        player.update({"last_anvil_action": timeStamp});
        player.update({"anvil_action_count": 0});
        return false;
    }
    if (anvilActionCount > 3) {
        player.update({"last_anvil_action": timeStamp});
    }    
    return true;
}
