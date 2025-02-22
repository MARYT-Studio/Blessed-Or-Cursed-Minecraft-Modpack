#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.event.PlayerRespawnEvent;
import mods.zenutils.EventPriority;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;
import crafttweaker.item.IItemStack;

// 保留经验的比例，1.0 表示 100% 保留
val keepExpRatio = 0.75f;
// 保留饥饿度的最小值和最大值
val minFoodLevel = 8;
val maxFoodLevel = 14;

// 不扣耐久的物品名单
// 主要为防止某些物品被扣了耐久（即增加 metadata）之后出现 bug，例如 HAC 的碾盘
val noDamageList as IItemStack[] = [
    <dcs_climate:dcs_yagen_stone>,
    <dcs_climate:dcs_yagen_brass>
];

events.register(
    function (event as EntityLivingDeathEvent) {
        if (event.isCanceled()) return;
        if (event.entityLivingBase instanceof IPlayer) {
            var player as IPlayer = event.entityLivingBase;
            // 不没收菜鸡的耐久
            if (!(player.world.getGameRuleHelper().getBoolean("IamAChicken"))) {
                // 耐久没收和低耐久提示
                var toolLowDurability as bool = false;
                var weaponLowDurability as bool = false;
                var armorLowDurability as bool = false;
                var miscLowDurability as bool = false;
                
                for index in 0 .. player.inventorySize {
                    var item = player.getInventoryStack(index);
                    if (isNull(item)) {
                        continue;
                    }
                    // 白名单上的物品免扣耐久
                    if (item.isDamageable && !isNoDamageItem(item, noDamageList)) {
                        // 当前耐久小于 20% 的物品，可免扣耐久
                        // 同时根据该物品的类别，通知玩家
                        if (item.maxDamage - item.damage <= item.maxDamage/5) {
                            if (item.definition.isWeapons(false)) weaponLowDurability = true;
                            else if (item.definition.isTools(true)) toolLowDurability = true;
                            else if (item.definition.isArmor()) armorLowDurability = true;
                            else miscLowDurability = true;
                        } else {
                            // 否则没收该物品当前耐久的 20%
                            item.mutable().damageItem(Math.ceil(0.2f * (item.maxDamage - item.damage)), player);
                        }
                    }
                }
                
                if(toolLowDurability) {
                    player.sendToast("crafttweaker.low_durability.tool", "", "crafttweaker.low_durability.subtitle", "", <minecraft:iron_pickaxe>);
                }
                if(weaponLowDurability) {
                    player.sendToast("crafttweaker.low_durability.weapon", "", "crafttweaker.low_durability.subtitle", "", <minecraft:iron_sword>);
                }
                if(armorLowDurability) {
                    player.sendToast("crafttweaker.low_durability.armor", "", "crafttweaker.low_durability.subtitle", "", <minecraft:iron_chestplate>);
                }
                if(miscLowDurability) {
                    player.sendToast("crafttweaker.low_durability.misc", "", "crafttweaker.low_durability.subtitle", "", <minecraft:flint_and_steel>);
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

            if (player.world.remote) return;

            var dTag = D(player.data);
            
            if (!(player.world.getGameRuleHelper().getBoolean("IamAChicken"))) {
                player.xpPoints = Math.round(keepExpRatio * dTag.getInt("PlayerPersisted.lastDeathXpPoints"));
            } else {
                // 不没收菜鸡的经验
                player.xpPoints = dTag.getInt("PlayerPersisted.lastDeathXpPoints");
            }
            
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

// 工具函数：排除免扣耐久物品名单上的物品
function isNoDamageItem(item as IItemStack, list as IItemStack[]) as bool {
    for noDamage in list {
        if (noDamage.matches(item)) return true;
    } return false;
}