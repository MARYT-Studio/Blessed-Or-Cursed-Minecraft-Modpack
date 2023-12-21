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

// 键为维度 ID，值为提升的锻刀上限数
val rewardMap = {
    0: 0,
    56: 5,
    -1: 10,
    1: 15,
    7: 20,
    28885: 10,
    50: 20,
    51: 30,
    52: 40,
    53: 50
} as IData;

events.onEntityLivingDeath(
    function (event as EntityLivingDeathEvent) {
        if !(event.entityLivingBase instanceof IEntityMob) return;
        var world = event.entityLivingBase.world;
        if (world.remote) return;
        if (event.damageSource.trueSource instanceof IPlayer) {
            var player as IPlayer = event.damageSource.trueSource;
            var item as IItemStack = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
            var dimension = world.dimension;
            if (isNull(item.tag) || isNull(item.tag.RefineLimitGained)) {
                // 初始化
                item.mutable().updateTag({
                    RefineLimitGained: {
                        0: 0,
                        56: 0,
                        -1: 0,
                        1: 0,
                        7: 0,
                        28885: 0,
                        50: 0,
                        51: 0,
                        52: 0,
                        53: 0
                    }
                });
                // 改值
                // 重新取手中物品
                var initializedItem as IItemStack = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
                var gained = initializedItem.tag.RefineLimitGained["" ~ dimension];
                initializedItem.mutable().updateTag({
                    RefineLimitGained: {
                        ("" ~ dimension): gained + 1
                    }
                });
            } else {
                // 无需初始化，直接改值
                var gained = item.tag.RefineLimitGained["" ~ dimension];
                item.mutable().updateTag({
                    RefineLimitGained: {
                        ("" ~ dimension): gained + 1
                    }
                });
            }
        }
    }
);

events.onPlayerRespawn(
    function (event as PlayerRespawnEvent) {
        if (event.endConquered) return;
        var player = event.player;
        if (player.world.remote) return;
        for item in player.getPlayerInventoryItemHandler() {
            if (isNull(item)) return;
            if (item.definition.id.contains("slashblade")) {
                player.sendChat("slashblade");
            }   
        }
    }
);
