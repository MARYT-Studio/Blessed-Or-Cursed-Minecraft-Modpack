#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntityLivingBase;
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
import mods.zenutils.I18n;

// Constants claiming

// debug
val debug as bool = false;

// Silverfish Counter Initial Number
val noAutoThreshold as int = 7;
// The distance a player should move to avoid being regarded as auto-playing
val distance as float = 3.0f;
// Probability of Randomly Penalty, to prevent players calculate a fixed period of penalty.
static penaltyProbability as float = 0.33f;
// debuff giving
val timeOfDebuff1 as int = 400;
val timeOfDebuff2 as int = 200;
val lvlOfDebuff1 as int = 2;
val lvlOfDebuff2 as int = 2;
// Random teleporting offset
val offset = 2;
// Message
val text as string[] = I18n.format("crafttweaker.camping_penalty").split("<br>");

events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent) {
        var world as IWorld = event.entity.world;
        var dmgsource = event.damageSource.trueSource;
        if (isNull(dmgsource)) return;
        var autoplayingThreshold as int = 15;
        if(dmgsource instanceof IPlayer) {
            var player as IPlayer = dmgsource;

            if (isNull(player.data.last_attack_xpos)) {player.update({last_attack_xpos: 0.0f});}
            if (isNull(player.data.last_attack_zpos)) {player.update({last_attack_zpos: 0.0f});}
            if (!isNull(player.data.PlayerPersisted) && !isNull(player.data.PlayerPersisted.higherAutoPlayingThreshold)) {
                autoplayingThreshold = player.data.PlayerPersisted.higherAutoPlayingThreshold.asInt() == 1 ? 30 : 45;
            }
            var lastAttackXpos as float = player.data.last_attack_xpos.asFloat();
            var lastAttackZpos as float = player.data.last_attack_zpos.asFloat();
            
            var playerXCoordNow as float = player.position3f.x as float;
            var playerZCoordNow as float = player.position3f.z as float;
            
            // If x or z coordinates changed more than const distance,
            // This player is considered "moved".
            var playerMovedFlag as bool = (
                    (pow((playerXCoordNow - lastAttackXpos), 2.0f) + pow((playerZCoordNow - lastAttackZpos), 2.0f)) > pow(distance, 2.0f)
                );
            
            // Update attack position
            player.update({last_attack_xpos: playerXCoordNow, last_attack_zpos: playerZCoordNow});
            if (isNull(player.data.penaltyCounter)) {player.update({penaltyCounter: 0});}
            if (isNull(player.data.playerMovedCounter)) {player.update({playerMovedCounter: 0});}
            else {
                var noMoveCounter = player.data.penaltyCounter.asInt();
                var movedCounter = player.data.playerMovedCounter.asInt();
                // 如果生物被计入反刷怪机制
                if (targetShouldCount(event.entityLivingBase)) {
                    // If player is not considered "moved", penaltyCounter will add one point.
                    (playerMovedFlag) ? (movedCounter += 1) : (noMoveCounter += 1);
                    player.update({penaltyCounter : noMoveCounter, playerMovedCounter: movedCounter});
                    if (debug) player.sendChat("AntiAutoPlaying Counted: true, playerMovedFlag: " ~ playerMovedFlag);
                }
            }
            if (player.data.playerMovedCounter.asInt() >= noAutoThreshold) {
                // Test Print
                player.update({penaltyCounter: 0});
                player.update({playerMovedCounter: 0});
            }
            if(player.data.penaltyCounter.asInt() >= autoplayingThreshold) {
                if(world.random.nextFloat() < penaltyProbability) {
                    if(!world.remote) {
                        // Summoning
                        // var summonPos3f = crafttweaker.util.Position3f.create(player.x, (player.y + 1), player.z);
                        // var summonBlockPos as IBlockPos = summonPos3f.asBlockPos();
                        // <entity:minecraft:endermite>.spawnEntity(world, summonBlockPos);
                                            
                        // Debuff
                        var hunger as IPotionEffect = <potion:minecraft:hunger>.makePotionEffect(timeOfDebuff1, lvlOfDebuff1);
                        var weakness as IPotionEffect = <potion:minecraft:weakness>.makePotionEffect(timeOfDebuff2, lvlOfDebuff2);
                        (world.random.nextBoolean()) ? (player.addPotionEffect(hunger)) : (player.addPotionEffect(weakness));
                        
                        // Random Teleporting
                        var offsetX = (world.random.nextBoolean()) ? offset : (0 - offset);
                        var offsetZ = (world.random.nextBoolean()) ? offset : (0 - offset);
                        server.commandManager.executeCommand(
                            server,
                            "tp "~player.name~" ~"~offsetX~" ~"~offset~" ~"~offsetZ
                        );

                        // Slayer Reward clearing
                        player.update({
                            slayer_rewards :{
                                slayer_counting: 0,
                                reward_world_time: world.getWorldTime()
                            }
                        });

                        // Chat Message
                        player.sendChat(text[0]);
                        player.sendChat(text[1]);
                    }
                    player.update({penaltyCounter: 0});
                }
            }
        }
    }
);

// 工具函数：求击杀怪物是否增加计数器数值
function targetShouldCount(entity as IEntityLivingBase) as bool {
    if (entityTypeMatch("slime", entity.definition)) {
        if (isNull(entity.nbt) || isNull(entity.nbt.Size)) return true;
        else {
            var size as int = entity.nbt.Size.asInt();
            if (size >= 3) return true;
            if (size >= 1) return (entity.world.random.nextFloat() < 0.25f);
            if (size >= 0) return false;
        }
    }
    if (entityTypeMatch("silverfish", entity.definition)) return (entity.world.random.nextFloat() < 0.6f);
    return true;
}

// 工具函数：生物类型匹配
function entityTypeMatch(type as string, definition as IEntityDefinition) as bool {
    return definition.id.toLowerCase().contains(type);
}
