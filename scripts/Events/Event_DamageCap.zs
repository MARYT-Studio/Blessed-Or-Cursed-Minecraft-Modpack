#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.world.IWorld;

val debug = false;

events.onEntityLivingDamage(
    function(event as EntityLivingDamageEvent) {
        if (event.entityLivingBase instanceof IPlayer) {
            var player as IPlayer = event.entityLivingBase;
            if (event.damageSource.trueSource instanceof IEntityMob) {
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
