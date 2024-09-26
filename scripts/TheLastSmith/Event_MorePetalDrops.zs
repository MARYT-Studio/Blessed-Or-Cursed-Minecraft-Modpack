#loader crafttweaker reloadable
// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathDropsEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;
import crafttweaker.util.Math;

// Other needed packages
import crafttweaker.item.IItemStack;

val debug = false;
val petal = <lastsmith:materials:3>;

// TODO: 把 entityMatch() 与 slime 数组提取为全局函数和变量，作为工具使用
// 两种不属于 IEntityMob 但是应当判定为怪物的生物
val slime as string[] = ["slime", "magma_cube"];

events.onEntityLivingDeathDrops(
    function(event as EntityLivingDeathDropsEvent) {
        var entity = event.entityLivingBase;
        if (entity instanceof IPlayer) return; // 杀玩家不算
        if(!entity.world.remote && ((entity instanceof IEntityMob) || entityMatch(slime, entity.definition))) {
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

// 工具函数：实体匹配
function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}
