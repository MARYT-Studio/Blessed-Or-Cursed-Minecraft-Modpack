#loader crafttweaker reloadable
import crafttweaker.event.PlayerRespawnEvent;
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import mods.zenutils.EventPriority;

// debug 开关
val debug = true;
// 初始锻刀上限
val baseRefineLimit = 10;
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
                var initMap as IData = blankMap + {("DIM" ~ world.dimension): 1};
                item.mutable().updateTag({"RefineLimitGained": initMap});
            } else {
                var gainedMap as IData = dTag.get("RefineLimitGained");
                if (D(gainedMap).getInt("DIM" ~ world.dimension) <= D(rewardMap).getInt("DIM" ~ world.dimension)) {
                    gainedMap = gainedMap + {("DIM" ~ world.dimension): D(gainedMap).getInt("DIM" ~ world.dimension) + 1};
                    item.mutable().updateTag({"RefineLimitGained": gainedMap});
                }
            }
        }
    }
);

// TODO: 惩罚部分，修改玩家背包里的拔刀剑锻刀上限
events.onPlayerRespawn(
    function (event as PlayerRespawnEvent) {
        if (event.endConquered) return;
        var player = event.player;
        if (player.world.remote) return;
        for item in player.getPlayerInventoryItemHandler() {
            if (isNull(item)) return;
            // if (item.definition.id.contains("slashblade")) {
            //     player.sendChat("slashblade");
            // }   
        }
    }
);
