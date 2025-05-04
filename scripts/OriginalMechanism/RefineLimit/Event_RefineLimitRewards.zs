#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.entity.IEntityDefinition;
import mods.zenutils.EventPriority;
import crafttweaker.util.Math;

import scripts.GlobalVars.debug as debug;
import scripts.GlobalVars.baseRefineLimit as baseRefineLimit;
import scripts.GlobalVars.rewardMap as rewardMap;
import scripts.GlobalVars.blankMap as blankMap;


// 奖励概率
val prob = 0.1f;

// TODO: 把 entityMatch() 与 slime 数组提取为全局函数和变量，作为工具使用
// 两种不属于 IEntityMob 但是应当判定为怪物的生物
val slime as string[] = ["slime", "magma_cube"];

// 奖励部分，玩家杀敌概率奖励锻刀上限
events.onEntityLivingDeath(
    function (event as EntityLivingDeathEvent) {
        var entity = event.entityLivingBase;
        if (entity instanceof IPlayer) return; // 杀玩家不算
        if (!(entity instanceof IEntityMob) && !(entityMatch(slime, entity.definition))) return; // 不是怪物不算
        var world = event.entityLivingBase.world;
        if (world.remote) return;
        if (event.damageSource.trueSource instanceof IPlayer) {
            var player as IPlayer = event.damageSource.trueSource;
            var item as IItemStack = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
            // 过滤非拔刀剑物品
            if (isNull(item) || isNull(item.tag)) return;
            var dTag = D(item.tag);
            if (!(dTag.check("SlashBlade"))) return;
            // 判断是否需要初始化
            if (!(dTag.check("RefineLimitGained"))) {
                // 初始化
                if (debug) player.sendChat("Initializing Gained Map");
                var initMap as IData = blankMap;
                var refineLimit = dTag.getInt("RefineLimit", baseRefineLimit);
                // 如果该维度可以获取锻刀上限，那么需要在初始化的同时给予此次杀敌的锻刀上限奖励
                if (D(rewardMap).getInt("DIM" ~ world.dimension) > 0 && world.random.nextFloat() < prob) {
                    initMap = blankMap + {("DIM" ~ world.dimension): 1};
                    refineLimit += 1;

                    // 因此获取锻造数时,需要播放声音和提示
                    player.sendToast("crafttweaker.refine_limit_gained.1", "", "crafttweaker.refine_limit_gained.2", "", item);
                    server.commandManager.executeCommand(server, "playsound minecraft:block.anvil.use player " ~ player.name ~ " " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " 0.6 1.4 0.0");
                }
                item.mutable().updateTag({"RefineLimitGained": initMap, "RefineLimit": refineLimit});
            } else {
                var gainedMap as IData = dTag.get("RefineLimitGained");
                var gained as int = D(gainedMap).getInt("DIM" ~ world.dimension);
                var gainLimit as int = D(rewardMap).getInt("DIM" ~ world.dimension);
                if (world.random.nextFloat() < prob) {                
                    if (gained < gainLimit) {
                        var newMap as IData = gainedMap + {("DIM" ~ world.dimension): D(gainedMap).getInt("DIM" ~ world.dimension) + 1};
                        var refineLimit = 1 + dTag.getInt("RefineLimit", baseRefineLimit);
                        var last as int = gainLimit - gained;
                        if (last <= 1) {  // if filled
                            player.sendToast("crafttweaker.refine_limit_gained.full.1", "", "crafttweaker.refine_limit_gained.full.2", "", item);
                        }
                        else player.sendToast("crafttweaker.refine_limit_gained.1", "", "crafttweaker.refine_limit_gained.2", "\u00A7e\u00A7l" ~ last, item);
                        server.commandManager.executeCommand(server, "playsound minecraft:block.anvil.use player " ~ player.name ~ " " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " 0.6 1.4 0.0");
                        item.mutable().updateTag({"RefineLimitGained": newMap, "RefineLimit": refineLimit});
                    } else {
                        player.sendToast("crafttweaker.refine_limit_gained.full.1", "", "crafttweaker.refine_limit_gained.full.2", "", item);
                    }                    
                }
            }
        }
    }
);

events.register(
    function (event as EntityLivingDeathEvent) {
        // 如果死亡事件被取消，则免除惩罚（藤蔓徽章）
        if (event.isCanceled()) return;
        if (event.entityLivingBase instanceof IPlayer) {
            var player as IPlayer = event.entityLivingBase;
            for index in 0 .. player.inventorySize {
                var item = player.getInventoryStack(index);
                if (!isNull(item) && !isNull(item.tag)) {
                    var dTag = D(item.tag);
                    if (dTag.check("SlashBlade")) {
                        if (dTag.check("RefineLimitGained")) {
                            var gainedMap as IData = dTag.get("RefineLimitGained");
                            var refineLimitGained = dTag.getInt("RefineLimitGained.DIM" ~ player.dimension);
                            if (refineLimitGained > 0) {
                                var delta = 1 + (Math.ceil(0.5f * refineLimitGained));
                                var newMap as IData = gainedMap + {("DIM" ~ player.dimension): max(0, (refineLimitGained - delta))};
                                var newRefineLimit = max(0, (dTag.getInt("RefineLimit") - delta));
                                item.mutable().updateTag({"RefineLimitGained": newMap, "RefineLimit": newRefineLimit});
                            }
                        }
                    }
                }
            }
        }        
    }, EventPriority.lowest(), true
);

// 工具函数：生物匹配
function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}

// 工具函数：满值、过半、未过半用不同颜色
function color(value as int, limit as int) as string {
    if (value < 0.5f * limit) {
        return "\u00A7a";
    } else if (value >= limit) {
        return value > limit ? "\u00A7c\u00A7l" : "\u00A7c";
    } else return "\u00A76";
}
