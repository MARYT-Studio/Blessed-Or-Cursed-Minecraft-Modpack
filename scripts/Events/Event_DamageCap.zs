#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.world.IWorld;
import crafttweaker.entity.IEntityDefinition;

val debug = false;

// TODO: 把 entityMatch() 与 slime 数组提取为全局函数和变量，作为工具使用
// 两种不属于 IEntityMob 但是应当判定为怪物的生物
val slime as string[] = ["slime", "magma_cube"];

events.onEntityLivingDamage(
    function(event as EntityLivingDamageEvent) {
        if (event.entityLivingBase instanceof IPlayer) {
            var player as IPlayer = event.entityLivingBase;
            var source = event.damageSource.trueSource;
            if (isNull(source) || source instanceof IPlayer) return; // 玩家造成的伤害不减免
            if (source instanceof IEntityMob || entityMatch(slime, source.definition)) {
                if (debug) player.sendChat("Damage before capped: " ~ event.amount ~ ", is projectile: " ~ event.damageSource.isProjectile());
                var capFact = capFactor(player.world, event.amount, event.damageSource.isProjectile());
                event.amount = capFact * event.amount;
                if (debug) player.sendChat("After capped: " ~ event.amount ~ ", cap factor: " ~ capFact);
            }
        }
    }
);

// 工具函数：计算减伤比例
function capFactor (world as IWorld, amount as float, projectile as bool) as float {
    if (world.worldInfo.difficulty == "EASY") {
        if (projectile) return 0.75f;
        else return 0.7f;
    } else if (world.worldInfo.difficulty == "NORMAL") {
        if (projectile) return 0.9f;
        else return 0.85f;
    }
    return 1.0f;
}

// 工具函数：实体匹配
function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}
