#loader crafttweaker reloadable
// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathDropsEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.data.IData;
import crafttweaker.util.Math;

// Other needed packages
import crafttweaker.item.IItemStack;

val debug = false;
val petal = <lastsmith:materials:3>;

events.onEntityLivingDeathDrops(
    function(event as EntityLivingDeathDropsEvent) {
        if(!event.entity.world.remote && (event.entityLivingBase instanceof IEntityMob)) {
            if (event.damageSource.trueSource instanceof IPlayer) {
                var player as IPlayer = event.damageSource.trueSource;
                var data as IData = player.data;
                if (!isNull(player.data)) {
                    var dTag = D(player.data);
                    var rankPoints = dTag.getInt("SBRankPoint");
                    var dropAmount = 0;
                    // 100-199 D 200-299 C 300-399 B 400-499 A 500-533 S 534-566 SS 567-599 SSS
                    if (rankPoints >= 567) {
                        // Rank SSS
                        dropAmount = 8;
                    } else if (rankPoints >= 534) {
                        // Rank SS
                        dropAmount = 3;
                    } else if (rankPoints >= 500) {
                        // Rank S
                        dropAmount = 2;
                    } else if (rankPoints >= 400) {
                        // Rank A
                        dropAmount = 1;
                    }
                    if (debug) player.sendChat("Petal drop amount: " ~ dropAmount);
                    if (dropAmount > 0) {
                        var rand = event.entity.world.random.nextFloat();
                        var prob = Math.max(event.entityLivingBase.maxHealth/100.0f, 1.0f) as float;
                        if (rand < prob) {
                            event.addItem(petal * dropAmount);
                        } else {
                            if (debug) {player.sendChat("rand: " ~ rand ~ ", prob: " ~ prob ~ ", do not drop petals.");}
                        }
                    }
                }
            }
        }
    }
);
