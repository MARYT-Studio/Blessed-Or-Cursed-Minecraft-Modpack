#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.player.IPlayer;

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
                    event.amount *= (1.0f + 0.01f * refine);
                    if (debug) player.sendChat("Refine bonus is: " ~ 0.01f * refine ~ ", Damage after amplified: " ~ event.amount);
                    return;
                }
                if (debug) player.sendChat("Blade has no refine. Damage is not amplified");
            }
        }
    }
);
