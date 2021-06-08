#loader crafttweaker reloadableevents
// Packages for needed ZenClasses
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityDefinition;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingHurtEvent;

// Packages for math utilities
import crafttweaker.util.IRandom;

// Constants claiming
// Mob Names Array
static mobSummonCombat as string[] = ["Zombie", "Skeleton", "Creeper"];
static mobSummonRanged as string[] = ["Spider", "Enderman"];
// Mobs being summoned
static combatMobs as IEntityDefinition[] = [
    <entity:touhou_little_maid:entity.monster.rinnosuke>,
    <entity:sakura:samuraiillger>
];
static rangedMobs as IEntityDefinition[] = [
    <entity:touhou_little_maid:entity.monster.fairy>
];
// For mobs need 7 attacks to kill, every time it is hurt,
// this is the probability for the mob to summon an aid.
// should not lower than 0.032f.
// 0.04f is for Forge Server.
// static prob7time as float = 0.04f;
// 0.06f is for Mohist Server.
static prob7time as float = 0.06f;
// Only for test.
// static prob7time as float = 1.0f;
// Random Position Offset
static randomOffset as float = 1.5f;

// Event part
events.onEntityLivingHurt(
    function(event as EntityLivingHurtEvent)
    {
        var world as IWorld = event.entity.world;
        var damageSource = event.damageSource;
        if(damageSource.damageType == "player")
        {
            var mobBeingHurt = event.entityLivingBase; 
            if(mobSummonCombat has mobBeingHurt.definition.name)
            {
                if(world.random.nextFloat() < prob7time)
                {
                    var summonMobPosX = mobBeingHurt.position3f.x;
                    var summonMobPosZ = mobBeingHurt.position3f.z;
                    // Random Offset: True for +Offset, False for -Offset
                    if(world.random.nextBoolean())
                    {
                        summonMobPosX += randomOffset;
                        summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                    }
                    else
                    {
                        summonMobPosX += (0 - randomOffset);
                        summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                    }
                    var summonPos3f = crafttweaker.util.Position3f.create(summonMobPosX, mobBeingHurt.position3f.y, summonMobPosZ);
                    var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                    var typeNumber = world.random.nextInt(combatMobs.length);
                    combatMobs[typeNumber].spawnEntity(world, summonBlockPos);
                }
            }
            if(mobSummonRanged has mobBeingHurt.definition.name)
            {
                if(world.random.nextFloat() < prob7time)
                {
                    var summonMobPosX = mobBeingHurt.position3f.x;
                    var summonMobPosZ = mobBeingHurt.position3f.z;
                    // Random Offset: True for +Offset, False for -Offset
                    if(world.random.nextBoolean())
                    {
                        summonMobPosX += randomOffset;
                        summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                    }
                    else
                    {
                        summonMobPosX += (0 - randomOffset);
                        summonMobPosZ += world.random.nextBoolean() ? randomOffset : (0 - randomOffset);
                    }
                    var summonPos3f = crafttweaker.util.Position3f.create(summonMobPosX, (mobBeingHurt.position3f.y + 1), summonMobPosZ);
                    var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                    var typeNumber = world.random.nextInt(rangedMobs.length);
                    rangedMobs[typeNumber].spawnEntity(world, summonBlockPos);
                }
            }
        }
    }
);