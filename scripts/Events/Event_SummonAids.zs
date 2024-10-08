#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.data.IData;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingHurtEvent;

import crafttweaker.util.Math;

// Re-added now
val disabled = false;

// debug mode
val debug = false;

// Mob Names Array
static mobSummonCombat as string[] = ["zombie", "skeleton", "creeper"];
static mobSummonRanged as string[] = ["spider", "esnderman"];
// Mobs being summoned
static combatMobs as IEntityDefinition[] = [
    <entity:touhou_little_maid:entity.monster.rinnosuke>,
    <entity:sakura:samuraiillger>
];
static combatElites as IEntityDefinition[] = [
    <entity:touhou_little_maid:entity.monster.rinnosuke>,
    <entity:minecraft:evocation_illager>
];
static rangedMobs as IEntityDefinition[] = [
    <entity:touhou_little_maid:entity.monster.fairy>
];
static rangedElites as IEntityDefinition[] = [
    <entity:touhou_little_maid:entity.monster.fairy>
];
// For mobs need 7 attacks to kill, every time it is hurt,
// this is the probability for the mob to summon an aid.
// should not lower than 0.032f.
// 0.04f is for Forge Server.
// static probEverySingleAttack as float = 0.04f;
// 0.06f is for Mohist Server.
// With further test we found that an enchanted vanilla sword can kill a mob in 3 attacks,
// so we adjust prob to 0.127, and killing every 3 mob will summon 1 aid.

// 20231230 新方案：随伤害从 0-20，召唤概率从 0.13 上升到最大值 0.33
static probEverySingleAttack as float = 0.13f;
// Only for test.
// static probEverySingleAttack as float = 1.0f;
// Random Position Offset
static randomOffset as float = 1.5f;
// Elites potion duration
static duration as int = 400;
static stepSpawnRateGrowth as int = 5;
static stepPotionLevelGrowth as int = 10;

// Event part
events.onEntityLivingHurt(
    function(event as EntityLivingHurtEvent) {

        if (disabled) return;

        // 受伤的是玩家，就不动作
        var mobBeingHurt = event.entityLivingBase;
        if (mobBeingHurt instanceof IPlayer) return;

        // 世界isRemote和维度判断
        var world = mobBeingHurt.world;
        if(world.remote) return;

        // 原版世界和狩猎维度
        if(world.dimension != 0 && world.dimension != (0 - 1) && world.dimension != 1 && world.dimension != 28885) return;
        
        var truSource = event.damageSource.trueSource;
        if (!(truSource instanceof IPlayer)) return;

        var player as IPlayer = truSource;
      
        // 事件逻辑
        if (entityMatch(mobSummonCombat, mobBeingHurt.definition)) {        
            var rand = world.random.nextFloat();
            if (debug) {
                player.sendChat(rand);
                player.sendChat("damage is: " ~ event.amount ~ ", adjusted probability is: " ~ summonProb(event.amount));
            }
            if(rand < summonProb(event.amount)) {
                var summonMobPosX = mobBeingHurt.position3f.x;
                var summonMobPosZ = mobBeingHurt.position3f.z;
                // Random Offset: True for +Offset, False for -Offset
                if(world.random.nextBoolean()) {
                    summonMobPosX += randomOffset;
                    summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                } else {
                    summonMobPosX += (0 - randomOffset);
                    summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                }
                var summonPos3f = crafttweaker.util.Position3f.create(summonMobPosX, mobBeingHurt.position3f.y, summonMobPosZ);
                var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                var typeNumber = world.random.nextInt(combatMobs.length);

                // Aid summoning

                if (isNull(player.data)) {
                    combatMobs[typeNumber].spawnEntity(world, summonBlockPos);
                    return;
                } else {
                    var dTag = D(player.data);
                    var slayCount as int = dTag.getInt("slayer_rewards.slayer_counting");
                    if (slayCount <= 0) {
                        combatMobs[typeNumber].spawnEntity(world, summonBlockPos);
                        return;
                    } else {
                        if (world.random.nextFloat() < (0.05f * (slayCount / stepSpawnRateGrowth))) {
                            var aid as IEntityLivingBase = combatElites[typeNumber].spawnEntity(world, summonBlockPos);
                            if (typeNumber == 0) {
                                aid.addPotionEffect(<potion:minecraft:speed>.makePotionEffect(duration, (slayCount / stepPotionLevelGrowth)));
                            } else if (typeNumber == 1) {
                                aid.addPotionEffect(<potion:minecraft:strength>.makePotionEffect(duration, (slayCount / stepPotionLevelGrowth)));
                            }
                        }
                    }
                }       
            }                        
        }
    
        if (entityMatch(mobSummonRanged, mobBeingHurt.definition)) {
            var rand = world.random.nextFloat();
            if (debug) player.sendChat(rand);    
            if(rand < summonProb(event.amount)) {
                var summonMobPosX = mobBeingHurt.position3f.x;
                var summonMobPosZ = mobBeingHurt.position3f.z;
                // Random Offset: True for +Offset, False for -Offset
                if(world.random.nextBoolean()) {
                    summonMobPosX += randomOffset;
                    summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                } else {
                    summonMobPosX += (0 - randomOffset);
                    summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                }
                var summonPos3f = crafttweaker.util.Position3f.create(summonMobPosX, (mobBeingHurt.position3f.y + 1), summonMobPosZ);
                var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                var typeNumber = world.random.nextInt(rangedMobs.length);
                
                // Aid summoning

                if (isNull(player.data)) {
                    combatMobs[typeNumber].spawnEntity(world, summonBlockPos);
                    return;
                } else {
                    var dTag = D(player.data);
                    var slayCount as int = dTag.getInt("slayer_rewards.slayer_counting");
                    if (slayCount <= 0) {
                        combatMobs[typeNumber].spawnEntity(world, summonBlockPos);
                        return;
                    } else {
                        if (world.random.nextFloat() < (0.05f * (slayCount / stepSpawnRateGrowth))) {
                            var aid as IEntityLivingBase = rangedElites[typeNumber].spawnEntity(world, summonBlockPos);
                            if (typeNumber == 0) {
                                aid.addPotionEffect(<potion:minecraft:speed>.makePotionEffect(duration, (slayCount / stepPotionLevelGrowth)));
                            } else if (typeNumber == 1) {
                                aid.addPotionEffect(<potion:minecraft:strength>.makePotionEffect(duration, (slayCount / stepPotionLevelGrowth)));
                            }
                        }
                    }
                }
            }
        }    
    }
);

// TODO: 把 entityMatch() 提取为全局函数，作为工具使用；
// 召唤援助中出现的怪物数组可暂缓提取。
function entityMatch(types as string[], definition as IEntityDefinition) as bool {
    for type in types {
        if (definition.id.toLowerCase().contains(type)) return true;
    }
    return false;
}

// 使召唤援助概率与伤害挂钩
function summonProb (damage as float) as float {
    return (probEverySingleAttack + 0.01f * min(Math.round(damage), 20));
}