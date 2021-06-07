#loader crafttweaker reloadableevents
// Packages for needed ZenClasses
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingHurtEvent;

// Packages for math utilities
import crafttweaker.util.IRandom;

// Constants claiming
// Mob Names Array
val mobSummonRinnosuke as string[] = ["Zombie", "Skeleton", "Spider", "Creeper"];
// For mobs need 7 attacks to kill, every time it is hurt,
// this is the probability for the mob to summon an aid.
// val prob7time as float = 0.032f;
// Set Prob to 1 for testing
val prob7time as float = 1.0f;
val randomOffset as float = 1.5f;

// Event part
events.onEntityLivingHurt(
    function(event as EntityLivingHurtEvent)
    {
        var world as IWorld = event.entity.world;
        var damageSource = event.damageSource;
        if(damageSource.damageType == "player")
        {
            // print("Some mob is hurt by a Player.");
            var mobBeingHurt = event.entityLivingBase; 
            // print("mob being hurt: "~hurtMobName);
            if(mobSummonRinnosuke has mobBeingHurt.definition.name)
            {
                print("This mob can summon a Rinnosuke as aid.");
                if(world.random.nextFloat() < prob7time)
                {
                    // print("Summoned a Rinnosuke.");
                    // <entity:touhou_little_maid:entity.monster.rinnosuke>.createEntity(world);
                    print("Summoned a test Villager.");
                    var villagerToSummon = <entity:minecraft:villager>.createEntity(world);
                    var summonMobPosX = mobBeingHurt.position3f.x;
                    var summonMobPosZ = mobBeingHurt.position3f.z;
                    // Random Offset: True for +Offset, False for -Offset
                    if(world.random.nextBoolean())
                    {
                        summonMobPosX += randomOffset;
                        summonMobPosZ += world.random.nextBoolean() ? randomOffset : -randomOffset;
                    }
                    else
                    {
                        summonMobPosX += -randomOffset;
                        summonMobPosZ += world.random.nextBoolean() ? randomOffset : -randomOffset;
                    }
                    var summonPos3f = crafttweaker.util.Position3f.create(summonMobPosX, mobBeingHurt.position3f.y, summonMobPosZ);
                    summonPos3f as IBlockPos;
                }
            }
        }
    }
);