#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.entity.IEntityMob;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.util.Math;
import scripts.Events.Event_SummonAids;

val debug as bool = false;

// 两种不属于 IEntityMob 但是应当判定为怪物的生物
val slime as string[] = ["slime", "magma_cube"];

events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent) {
        var entity = event.entityLivingBase;
        if (entity instanceof IPlayer) return; // 玩家死了不算
        if (!(entity instanceof IEntityMob) && !(entityMatch(slime, entity.definition))) return; // 非怪物的生物击杀不算
        var world = entity.world;
        var source = event.damageSource.trueSource;
        if (isNull(source)) return;
        if (source instanceof IPlayer) {
            var player as IPlayer = source;
            var reward = calcReward(
                                mobValue(entity.definition),
                                slayerCountingValue(player),
                                difficultyValue(world),
                                championTierValue(entity),
                                maxHealthValue(entity)
                            );
            if (debug) {
                player.sendChat("Calculated reward: " ~ reward);
                player.sendChat(mobValue(entity.definition));
                player.sendChat(slayerCountingValue(player));
                player.sendChat(difficultyValue(world));
                player.sendChat(championTierValue(entity));
                player.sendChat(maxHealthValue(entity));
            }    
            var item as IItemStack = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());   
            // 过滤非拔刀剑物品
            if (isNull(item) || isNull(item.tag)) return;
            var dTag = D(item.tag);
            if (!(dTag.check("SlashBlade"))) return;
            item.mutable().updateTag({"killCount": (dTag.getInt("killCount") + reward)});
        }
    }
);

// 公式：将击杀加成最终折算成整数杀敌数
function calcReward(mobValues as float, slayValues as float, diffValues as float, championValues as float, maxHealthValues as float) as int {
    return Math.round((mobValues + slayValues) * diffValues * championValues * maxHealthValues);
}


// 工具函数：设置生物的价值
function mobValue(mob as IEntityDefinition) as float {
    if (mob.id.toLowerCase().contains("endermite")) {
        return 0.0f;
    }
    if (mob.id.toLowerCase().contains("silverfish")) {
        return 0.2f;
    }
    if (Event_SummonAids.combatMobs has mob || Event_SummonAids.combatElites has mob || Event_SummonAids.rangedMobs has mob || Event_SummonAids.rangedElites has mob || mob.id.toLowerCase().contains("babyspider")) {
        return 0.7f;
    }
    // 正常值
    return 1.5f;
}

// 工具函数：获取连杀计数的加成
function slayerCountingValue(player as IPlayer) as float {
    // 每个连杀的价值
    val value = 0.01f;
    
    if (!isNull(player.data)) {
        var dTag = D(player.data);
        return (value * dTag.getInt("slayer_rewards.slayer_counting"));
    }

    return 0.0f;
}

// 工具函数：设置世界难度的价值
function difficultyValue(world as IWorld) as float {
    if (world.worldInfo.hardcoreModeEnabled) return 2.5f;
    var diff as string = world.worldInfo.difficulty;
    if (diff == "EASY") return 0.8f;
    if (diff == "HARD") return 1.4f;
    return 1.0f;
}

// 工具函数：设置强敌等级的价值
function championTierValue(entity as IEntityLivingBase) as float {
    if (!isNull(entity.nbt)) {
        var dTag = D(entity.nbt);
        if (dTag.getInt("ForgeCaps.champions:championship.tier") > 0) {
            return pow(1.5D, dTag.getInt("ForgeCaps.champions:championship.tier") as double) as float;
        }
    }
    return 1.0f;
}

// 工具函数：临时参数，与最大生命值挂钩的乘数因子
function maxHealthValue (entity as IEntityLivingBase) as float {
    return Math.max(1.0f,
        1.0f + ((entity.maxHealth/20.0f - 1.0f) * 0.5f)
    );
}

function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}
