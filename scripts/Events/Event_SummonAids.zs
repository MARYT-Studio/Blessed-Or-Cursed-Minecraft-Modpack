#loader crafttweaker reloadableevents
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingHurtEvent;

// Packages for math utilities
import crafttweaker.util.IRandom;

// Packages for Potion function
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;

// Constants claiming
// Silverfish Counter Initial Number
val sfCounterInit as int = 30;
// debuff giving
val debuffMechanismOn as bool = false;
val timeOfDebuff1 as int = 200;
val timeOfDebuff2 as int = 200;
val lvlOfDebuff1 as int = 2;
val lvlOfDebuff2 as int = 2;
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
// static probEverySingleAttack as float = 0.04f;
// 0.06f is for Mohist Server.
// With further test we found that an enchanted vanilla sword can kill a mob in 3 attacks,
// so we adjust prob to 0.127, and killing every 3 mob will summon 1 aid.
static probEverySingleAttack as float = 0.127f;
static probSilverfishSummon as float = 0.33f;
static probPotionEffect as float = 0.33f;
// Only for test.
// static probEverySingleAttack as float = 1.0f;
// Random Position Offset
static randomOffset as float = 1.5f;

// Event part
events.onEntityLivingHurt(
    function(event as EntityLivingHurtEvent)
    {
        var world as IWorld = event.entity.world;
        var truSource = event.damageSource.trueSource;
        if(truSource instanceof IPlayer)
        {
            // Regardless of the mob type, summon a silverfish when counter reaches 0.
            var truSource as IPlayer = truSource;
            if(isNull(truSource.data.silverfishCounter)){truSource.update({silverfishCounter: 0});}
            else
            {
                var counter = truSource.data.silverfishCounter.asInt();
                counter += 1;
                truSource.update({silverfishCounter : counter});
                truSource.sendMessage("当前蠹虫计数器数值为"~counter);
            }
            if(!world.remote && truSource.data.silverfishCounter.asInt() >= sfCounterInit)
            {
                if(world.random.nextFloat() < probSilverfishSummon)
                {
                    var summonPos3f = crafttweaker.util.Position3f.create(truSource.x, (truSource.y + 1), truSource.z);
                    var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                    <entity:minecraft:silverfish>.spawnEntity(world, summonBlockPos);
                    truSource.update({silverfishCounter: 0});
                    truSource.sendMessage(game.localize("crafttweaker.silverfish_summoned"));
                }
                if(debuffMechanismOn && (world.random.nextFloat() < probPotionEffect))
                {
                    var hunger as IPotionEffect = <potion:minecraft:hunger>.makePotionEffect(timeOfDebuff1, lvlOfDebuff1);
                    var weakness as IPotionEffect = <potion:minecraft:weakness>.makePotionEffect(timeOfDebuff2, lvlOfDebuff2);
                    (world.random.nextBoolean()) ? (truSource.addPotionEffect(hunger)) : (truSource.addPotionEffect(weakness));
                    truSource.sendMessage(game.localize("crafttweaker.potion_applied"));
                }
            }
            // Summon normal aid mobs for specific mob type.
            var mobBeingHurt = event.entityLivingBase; 
            if(!world.remote && mobSummonCombat has mobBeingHurt.definition.name)
            {
                if(world.random.nextFloat() < probEverySingleAttack)
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
            if(!world.remote && mobSummonRanged has mobBeingHurt.definition.name)
            {
                if(world.random.nextFloat() < probEverySingleAttack)
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