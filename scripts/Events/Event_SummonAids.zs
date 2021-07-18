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

// For random Teleporting
import crafttweaker.util.Position3f;

// Packages for Potion function
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;

// For send Messages
import crafttweaker.text.ITextComponent;

// Constants claiming
// Silverfish Counter Initial Number
val sfCounterInit as int = 10;
val clearSfCounter as int = 20;
// debuff giving
val debuffMechanismOn as bool = false;
val timeOfDebuff1 as int = 200;
val timeOfDebuff2 as int = 200;
val lvlOfDebuff1 as int = 2;
val lvlOfDebuff2 as int = 2;
val distance as float = 0.5f;
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
        if(!world.remote && truSource instanceof IPlayer)
        {
            // Regardless of the mob type, summon a silverfish when counter reaches 0.
            var truSource as IPlayer = truSource;
            // Initialize a player's position.
            if(isNull(truSource.data.last_attack_xpos)){truSource.update({last_attack_xpos: 0.5f});}
            if(isNull(truSource.data.last_attack_zpos)){truSource.update({last_attack_zpos: 0.5f});}
            var lastAttackXpos as float = truSource.data.last_attack_xpos.asFloat();
            var lastAttackZpos as float = truSource.data.last_attack_zpos.asFloat();
            
            // Test Print
            // truSource.sendMessage("你上次攻击怪物时的坐标为x: "~lastAttackXpos~", z: "~lastAttackZpos);
            
            var playerXCoordNow as float = truSource.position3f.x as float;
            var playerZCoordNow as float = truSource.position3f.z as float;
            
            // Test Print
            // truSource.sendMessage("你本次攻击怪物时的坐标为x: "~playerXCoordNow~", z: "~playerZCoordNow);
            
            // If player's x or z coordinates changed more than const distance,
            // This player is considered "moved".
            var playerMovedFlag as bool = 
                ((playerXCoordNow - lastAttackXpos) > distance) ||
                ((playerZCoordNow - lastAttackZpos) > distance) ||
                ((playerXCoordNow - lastAttackXpos) < (0.0f - distance)) ||
                ((playerZCoordNow - lastAttackZpos) < (0.0f - distance));
            
            // Test Print
            // truSource.sendMessage("你本次攻击时，比起上次攻击移动了："~playerMovedFlag);
            
            // Update player's attack position
            truSource.update({last_attack_xpos: playerXCoordNow, last_attack_zpos: playerZCoordNow});
            if(isNull(truSource.data.silverfishCounter)){truSource.update({silverfishCounter: 0});}
            if(isNull(truSource.data.playerMovedCounter)){truSource.update({playerMovedCounter: 0});}
            else
            {
                var noMoveCounter = truSource.data.silverfishCounter.asInt();
                var movedCounter = truSource.data.playerMovedCounter.asInt();
                // If player is not considered "moved", his silverfish noMoveCounter will add one point.
                (playerMovedFlag) ? (movedCounter += 1) : (noMoveCounter += 1);
                truSource.update({silverfishCounter : noMoveCounter, playerMovedCounter: movedCounter});
                // Test Print
                // truSource.sendMessage("当前蠹虫计数器数值为"~noMoveCounter);
            }
            if(truSource.data.playerMovedCounter.asInt() >= clearSfCounter)
            {
                // Test Print
                // truSource.sendMessage("检测到你没有在挂机，蠹虫计数器归零。");

                truSource.update({silverfishCounter: 0});
                truSource.update({playerMovedCounter: 0});
            }
            if(truSource.data.silverfishCounter.asInt() >= sfCounterInit)
            {
                if(world.random.nextFloat() < probSilverfishSummon)
                {
                    var summonPos3f = crafttweaker.util.Position3f.create(truSource.x, (truSource.y + 1), truSource.z);
                    var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                    <entity:minecraft:silverfish>.spawnEntity(world, summonBlockPos);
                    truSource.update({silverfishCounter: 0});
                    truSource.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.silverfish_summoned"));
                }
                if(debuffMechanismOn && (world.random.nextFloat() < probPotionEffect))
                {
                    var hunger as IPotionEffect = <potion:minecraft:hunger>.makePotionEffect(timeOfDebuff1, lvlOfDebuff1);
                    var weakness as IPotionEffect = <potion:minecraft:weakness>.makePotionEffect(timeOfDebuff2, lvlOfDebuff2);
                    (world.random.nextBoolean()) ? (truSource.addPotionEffect(hunger)) : (truSource.addPotionEffect(weakness));
                    truSource.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.potion_applied"));
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