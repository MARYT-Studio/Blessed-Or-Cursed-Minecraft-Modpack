#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.damage.IDamageSource;
import crafttweaker.util.Math;

val debug = true;

events.onEntityLivingDamage(
    function(event as EntityLivingDamageEvent) {
        if (!isNull(event.damageSource.trueSource) && event.damageSource.trueSource instanceof IPlayer) {
            var player as IPlayer = event.damageSource.trueSource;
            if (!isNull(player.mainHandHeldItem) && !isNull(player.mainHandHeldItem.tag)) {
                if (debug) player.sendChat("Damage before amplified: " ~ event.amount);
                var dTag = D(player.mainHandHeldItem.tag);
                var refine = dTag.getInt("RepairCounter");
                if (refine > 0) {                    
                    var hakujinDamageFactor = hakujin(event.entityLivingBase, refine);
                    var migiriDamage = migiri(event.entityLivingBase, refine);
                    if (debug) player.sendChat("Hakujin damage factor: " ~ hakujinDamageFactor ~ ", Migiri damage: " ~ migiriDamage);
                    return;
                }
                if (debug) player.sendChat("Blade has no refine. Damage is not amplified");
            }
        }
    }
);

// 剑技1：白刃
function hakujin (entity as IEntityLivingBase, refine as int) as float {
    var damageFactor as float = (Math.atan(1.0D * refine / 100.0D) / 3.141592654D) as float;
    entity.attackEntityFrom(IDamageSource.GENERIC(), damageFactor * entity.health);
    return damageFactor;
}

// 剑技2：见切
function migiri (entity as IEntityLivingBase, refine as int) as float {
    var damage as float = 0.0f;
    if (refine <= 100) {
        damage = (refine/5) as float * 2.0f;
    } else if (refine <= 500) {
        damage = 40.0f + ((refine - 100) / 10) as float * 2.0f;
    } else {
        damage = 120.0f + ((refine - 100) / 10) as float * 1.0f;
    }
    entity.attackEntityFrom(IDamageSource.OUT_OF_WORLD(), damage);
    return damage;
}
