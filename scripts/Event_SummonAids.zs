#loader crafttweaker reloadableevents
// Packages for needed ZenClasses
import crafttweaker.world.IWorld;

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

// Event part
events.onEntityLivingHurt(
    function(event as EntityLivingHurtEvent)
    {
        var world as IWorld = event.entity.world;
        var damageSource = event.damageSource;
        if(damageSource.damageType == "player")
        {
            print("Some mob is hurt by a Player.");
            var hurtMobName = event.entityLivingBase.definition.name;
            print("mob being hurt: "~hurtMobName);
            if(mobSummonRinnosuke has hurtMobName)
            {
                print("This mob can summon a Rinnosuke as aid.");
                if(world.random.nextFloat() < prob7time)
                {
                    // print("Summoned a Rinnosuke.");
                    // <entity:touhou_little_maid:entity.monster.rinnosuke>.createEntity(world);
                    print("Summoned a test Villager.");
                    <entity:minecraft:villager>.createEntity(world);
                }
            }
        }
    }
);