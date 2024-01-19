#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import mods.zenutils.EventPriority;
import scripts.GlobalVars;
import crafttweaker.util.Math;

// debug 开关
val debug = false;
// 奖励概率
val prob = 0.1f;
// 键为维度 ID，值为提升的锻刀上限数
val rewardMap = {
    "DIM0": 0,
    "DIM56": 5,
    "DIM-1": 10,
    "DIM1": 15,
    "DIM7": 20,
    "DIM28885": 10,
    "DIM50": 20,
    "DIM51": 30,
    "DIM52": 40,
    "DIM53": 50
} as IData;

val blankMap = {    
    "DIM0": 0,
    "DIM56": 0,
    "DIM-1": 0,
    "DIM1": 0,
    "DIM7": 0,
    "DIM28885": 0,
    "DIM50": 0,
    "DIM51": 0,
    "DIM52": 0,
    "DIM53": 0
} as IData;

// Toast 文本
val text as string[] = game.localize("crafttweaker.refine_limit_gained").split("<br>");

// 奖励部分，玩家杀敌概率奖励锻刀上限
events.onEntityLivingDeath(
    function (event as EntityLivingDeathEvent) {
        if !(event.entityLivingBase instanceof IEntityMob) return;
        var world = event.entityLivingBase.world;
        if (world.remote) return;
        if (event.damageSource.trueSource instanceof IPlayer) {
            var player as IPlayer = event.damageSource.trueSource;
            var item as IItemStack = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
            // 过滤非拔刀剑物品
            if (isNull(item.tag)) return;
            var dTag = D(item.tag);
            if (!(dTag.check("SlashBlade"))) return;
            // 判断是否需要初始化
            if (!(dTag.check("RefineLimitGained"))) {
                // 初始化
                if (debug) player.sendChat("Initializing Gained Map");
                var initMap as IData = blankMap;
                var refineLimit = dTag.getInt("RefineLimit", GlobalVars.baseRefineLimit);
                // 如果该维度可以获取锻刀上限，那么需要在初始化的同时给予此次杀敌的锻刀上限奖励
                if (D(rewardMap).getInt("DIM" ~ world.dimension) > 0 && world.random.nextFloat() < prob) {
                    initMap = blankMap + {("DIM" ~ world.dimension): 1};
                    refineLimit += 1;
                }
                player.sendToast({text: text[0]} as IData, {text: text[1]} as IData, item);
                server.commandManager.executeCommand(server, "playsound minecraft:block.anvil.use player " ~ player.name ~ " " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " 0.6 1.4 0.0");
                item.mutable().updateTag({"RefineLimitGained": initMap, "RefineLimit": refineLimit});
            } else {
                var gainedMap as IData = dTag.get("RefineLimitGained");
                if (D(gainedMap).getInt("DIM" ~ world.dimension) < D(rewardMap).getInt("DIM" ~ world.dimension) && world.random.nextFloat() < prob) {
                    var newMap as IData = gainedMap + {("DIM" ~ world.dimension): D(gainedMap).getInt("DIM" ~ world.dimension) + 1};
                    var refineLimit = 1 + dTag.getInt("RefineLimit", GlobalVars.baseRefineLimit);
                    player.sendToast({text: text[0]} as IData, {text: text[1]} as IData, item);
                    server.commandManager.executeCommand(server, "playsound minecraft:block.anvil.use player " ~ player.name ~ " " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " 0.6 1.4 0.0");
                    item.mutable().updateTag({"RefineLimitGained": newMap, "RefineLimit": refineLimit});
                }
            }
        }
    }
);

// TODO: 惩罚部分，修改玩家背包里的拔刀剑锻刀上限
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
