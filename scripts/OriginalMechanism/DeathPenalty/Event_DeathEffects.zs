#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.event.PlayerRespawnEvent;
import mods.zenutils.EventPriority;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;

// 保留经验的比例，1.0 表示 100% 保留
val keepExpRatio = 0.75f;
// 保留饥饿度的最小值和最大值
val minFoodLevel = 8;
val maxFoodLevel = 14;

events.register(
    function (event as EntityLivingDeathEvent) {
        if (event.isCanceled()) return;
        if (event.entityLivingBase instanceof IPlayer) {
            var player as IPlayer = event.entityLivingBase;
            // 耐久没收
            for index in 0 .. player.inventorySize {
                var item = player.getInventoryStack(index);
                if (isNull(item)) {
                    continue;
                }
                if (item.isDamageable) {
                    // 改为没收该物品当前耐久的 20%
                    item.mutable().damageItem(Math.ceil(0.2f * (item.maxDamage - item.damage)), player);
                }
            }

            // 经验折损
            player.update({PlayerPersisted: {lastDeathXpPoints : player.xpPoints}});

            // 饥饿度保持
            player.update({PlayerPersisted: {lastDeathFoodLevel : player.foodStats.foodLevel}});
        }
    }, EventPriority.lowest(), true
);

events.onPlayerRespawn(
    function (event as PlayerRespawnEvent) {
        if (!(event.endConquered)) {
            var player = event.player;
            var dTag = D(player.data);
            player.xpPoints = Math.round(keepExpRatio * dTag.getInt("PlayerPersisted.lastDeathXpPoints"));
            var lastDeathFoodLevel = dTag.getInt("PlayerPersisted.lastDeathFoodLevel");
            if (lastDeathFoodLevel <= minFoodLevel) {
                player.foodStats.foodLevel = minFoodLevel;
            } else if (lastDeathFoodLevel >= maxFoodLevel) {
                player.foodStats.foodLevel = maxFoodLevel;
            } else {
                player.foodStats.foodLevel = lastDeathFoodLevel;
            }
        }
    }
);