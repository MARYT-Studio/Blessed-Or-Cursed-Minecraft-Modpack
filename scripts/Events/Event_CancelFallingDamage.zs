// This script prevents falling damage.
// TODO: test this and see if it is applicable
#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingHurtEvent;

val enable = true;

if (enable) {
    events.onEntityLivingHurt(
        function(event as EntityLivingHurtEvent) {
            if (event.damageSource.damageType == "fall") event.cancel();
        }
    );
}

