#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.damage.IDamageSource;
import crafttweaker.util.Math;

val debug = false;

events.onEntityLivingDamage(
    function(event as EntityLivingDamageEvent) {
        if (!isNull(event.damageSource.trueSource) && event.damageSource.trueSource instanceof IPlayer) {
            var player as IPlayer = event.damageSource.trueSource;
            if (!isNull(player.mainHandHeldItem) && !isNull(player.mainHandHeldItem.tag)) {
                if (debug) player.sendChat("Damage before amplified: " ~ event.amount);
                var dTag = D(player.mainHandHeldItem.tag);
                var refine = dTag.getInt("RepairCounter");
                if (refine > 0) {                    
                    var entity = event.entityLivingBase;
                    var hakujinDamageFactor = hakujin(refine);
                    var migiriDamage = migiri(refine);
                    event.amount += hakujinDamageFactor * entity.health + migiriDamage;
                    if (debug) player.sendChat("\u767D\u5203\u4F24\u5BB3\u7CFB\u6570\uFF1A" ~ hakujinDamageFactor ~ "\uFF0C\u89C1\u5207\u4F24\u5BB3\u6570\u503C\uFF1A" ~ migiriDamage);
                    if (debug) player.sendChat("Amplified damage: " ~ event.amount);
                    return;
                }
                if (debug) player.sendChat("Blade has no refine. Damage is not amplified");
            }
        }
    }
);

// 剑技1：白刃
function hakujin (refine as int) as float {
    return (Math.atan(1.0D * refine / 100.0D) / 3.141592654D) as float;
}

// 剑技2：见切
function migiri (refine as int) as float {
    var damage as float = 0.0f;
    if (refine <= 100) {
        damage = (refine/5) as float * 2.0f;
    } else if (refine <= 500) {
        damage = 40.0f + ((refine - 100) / 10) as float * 2.0f;
    } else {
        damage = 120.0f + ((refine - 100) / 10) as float * 1.0f;
    }
    return damage;
}
