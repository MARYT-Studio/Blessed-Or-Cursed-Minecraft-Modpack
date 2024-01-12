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
                if (debug) player.sendChat("Damage before capped: " ~ event.amount);
                event.amount = capFactor(player.world, event.amount, event.damageSource.isProjectile());
                if (debug) player.sendChat("After capped: " ~ event.amount);
            }
        }
    }
);

// 工具函数：计算减伤比例
function capFactor (world as IWorld, amount as float, projectile as bool) as float {
    if (world.worldInfo.difficulty == "EASY") {
        if (projectile) return 0.75f * amount;
        else return 0.7f * amount;
    } else if (world.worldInfo.difficulty == "NORMAL") {
        if (projectile) return 0.9f * amount;
        else return 0.85f * amount;
    }
    return amount;
}
