#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathEvent;

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
val silverfishSummoningOn as bool = true;
val noAutoThreshold as int = 7;
// The distance a player should move to avoid being regarded as auto-playing
val distance as float = 3.0f;
// Probability of Randomly Penalty, to prevent players calculate a fixed period of penalty.
static penaltyProbability as float = 0.33f;

// debuff giving
val debuffMechanismOn as bool = true;
val timeOfDebuff1 as int = 400;
val timeOfDebuff2 as int = 200;
val lvlOfDebuff1 as int = 2;
val lvlOfDebuff2 as int = 2;

// Random teleporting
val randomTeleportingOn as bool = true;
// Random teleporting offset
val offset as int = 2;

events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent)
    {
        var world as IWorld = event.entity.world;
        var dmgsource = event.damageSource.trueSource;
        if (isNull(dmgsource)) return;
        var autoplayingThreshold as int = 15;
        if(dmgsource instanceof IPlayer) {
            var player as IPlayer = dmgsource;
            // Initialize a player's position.
            if (isNull(player.data.last_attack_xpos)) {player.update({last_attack_xpos: 0.0f});}
            if (isNull(player.data.last_attack_zpos)) {player.update({last_attack_zpos: 0.0f});}
            if (!isNull(player.data.PlayerPersisted) && !isNull(player.data.PlayerPersisted.higherAutoPlayingThreshold)) {
                autoplayingThreshold = player.data.PlayerPersisted.higherAutoPlayingThreshold.asInt() == 1 ? 30 : 45;
            }
            var lastAttackXpos as float = player.data.last_attack_xpos.asFloat();
            var lastAttackZpos as float = player.data.last_attack_zpos.asFloat();
            
            var playerXCoordNow as float = player.position3f.x as float;
            var playerZCoordNow as float = player.position3f.z as float;
            
            // If player's x or z coordinates changed more than const distance,
            // This player is considered "moved".
            var playerMovedFlag as bool = (
                    (pow((playerXCoordNow - lastAttackXpos), 2.0f) + pow((playerZCoordNow - lastAttackZpos), 2.0f)) > pow(distance, 2.0f)
                );
            
            // Update player's attack position
            player.update({last_attack_xpos: playerXCoordNow, last_attack_zpos: playerZCoordNow});
            if (isNull(player.data.silverfishCounter)) {player.update({silverfishCounter: 0});}
            if (isNull(player.data.playerMovedCounter)) {player.update({playerMovedCounter: 0});}
            else {
                var noMoveCounter = player.data.silverfishCounter.asInt();
                var movedCounter = player.data.playerMovedCounter.asInt();
                // If player is not considered "moved", his silverfish noMoveCounter will add one point.
                (playerMovedFlag) ? (movedCounter += 1) : (noMoveCounter += 1);
                player.update({silverfishCounter : noMoveCounter, playerMovedCounter: movedCounter});
            }
            if (player.data.playerMovedCounter.asInt() >= noAutoThreshold) {
                // Test Print
                player.update({silverfishCounter: 0});
                player.update({playerMovedCounter: 0});
            }
            if(player.data.silverfishCounter.asInt() >= autoplayingThreshold) {
                if(world.random.nextFloat() < penaltyProbability) {
                    if(!world.remote && silverfishSummoningOn) {
                        var summonPos3f = crafttweaker.util.Position3f.create(player.x, (player.y + 1), player.z);
                        var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                        <entity:minecraft:endermite>.spawnEntity(world, summonBlockPos);
                        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.silverfish_summoned"));
                    }
                    // Give player debuff
                    if(debuffMechanismOn) {
                        var hunger as IPotionEffect = <potion:minecraft:hunger>.makePotionEffect(timeOfDebuff1, lvlOfDebuff1);
                        var weakness as IPotionEffect = <potion:minecraft:weakness>.makePotionEffect(timeOfDebuff2, lvlOfDebuff2);
                        (world.random.nextBoolean()) ? (player.addPotionEffect(hunger)) : (player.addPotionEffect(weakness));
                        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.potion_applied"));
                    }
                    // Randomly teleporting player
                    if(randomTeleportingOn) {
                        // Test Print
                        var offsetX = world.random.nextBoolean() ? offset : (0 - offset);
                        var offsetZ = world.random.nextBoolean() ? offset : (0 - offset);
                        server.commandManager.executeCommand(
                            server,
                            "tp "~player.name~" ~"~offsetX~" ~"~offset~" ~"~offsetZ
                        );
                    }
                    player.update({silverfishCounter: 0});
                }
            }
        }
    }
);
