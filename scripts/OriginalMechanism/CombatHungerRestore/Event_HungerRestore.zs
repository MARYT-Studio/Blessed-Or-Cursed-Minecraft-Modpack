#loader crafttweaker reloadable
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.event.EntityLivingDeathEvent;

import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;

import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.entity.IEntityDefinition;

// 药水效果
val potion as IPotion = <potion:contenttweaker:spirit_of_muramasa>;
val effect as IPotionEffect = potion.makePotionEffect(8 * 20, 0);

// TODO: 把 entityMatch() 与 slime 数组提取为全局函数和变量，作为工具使用
// 两种不属于 IEntityMob 但是应当判定为怪物的生物
val slime as string[] = ["slime", "magma_cube"];

// Buff 给予和重置的饥饿值要求
val giveBuffThreshold as int = 6;
val refreshBuffThreshold as int = 8;
// 当玩家饥饿值达到此值时，不再给予玩家杀敌回复
val giveRestoreThreshold as int = 15;

// 每秒钟检测一次，如果玩家处于无法疾跑的饥饿状态，给玩家上这个 buff
events.onPlayerTick(
    function (event as PlayerTickEvent) {
        var player = event.player;
        var world = player.world;
        if (world.remote) return;
        if (event.side == "SERVER" && event.phase == "END") {
            if (world.provider.getWorldTime() % 20 == 0) {
                if (player.foodStats.foodLevel <= giveBuffThreshold) {
                    
                    // 在玩家的一条命之内，玩家在获得了此 Buff 之后，直到其将饥饿值回复到重置门限值之上，否则不予重置此 Buff
                    
                    // 初始化
                    var data = D(player.data);
                    if (!(data.check("shouldHungerRestoreRefresh"))) player.update({shouldHungerRestoreRefresh: true});
                    
                    if (data.getBool("shouldHungerRestoreRefresh", true) && isNull(player.getActivePotionEffect(potion))) {
                        player.addPotionEffect(<potion:contenttweaker:spirit_of_muramasa>.makePotionEffect(8 * 20, 0));
                        player.update({shouldHungerRestoreRefresh: false});
                    }
                } else if (player.foodStats.foodLevel >= refreshBuffThreshold) player.update({shouldHungerRestoreRefresh: true});
            }
        }
    }
);

// 玩家造成击杀时，若处于此 Buff 状态下，且饥饿值未达到停止回复门限，使其回复饥饿值，每个击杀回复 1 点
events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent)
    {
        var entity = event.entity;
        if (entity instanceof IPlayer) return;  // 玩家死了不算
        if (!(entity instanceof IEntityMob) && !(entityMatch(slime, entity.definition))) return; // 非怪物的生物击杀不算
        var world = entity.world;
        var source = event.damageSource.trueSource;
        
        if (isNull(source)) return;
        if (source instanceof IPlayer) {
            var player as IPlayer = source;
            // 这里门限值是小于而非小于等于，是因为“等于”的情况下还会回复 1 点，那就会超过门限 1 点
            if (!(isNull(player.getActivePotionEffect(potion))) && player.foodStats.foodLevel < giveRestoreThreshold) player.foodStats.addStats(1, 0);
        }
    }
);

function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}
