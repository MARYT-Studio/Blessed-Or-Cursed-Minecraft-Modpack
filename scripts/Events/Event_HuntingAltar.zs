#loader crafttweaker reloadableevents
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerInteractBlockEvent;
// Messages
import crafttweaker.text.ITextComponent;
// Random
import crafttweaker.util.IRandom;
// Position calculations
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;

// Configurations
static distanceOfNormalMobs as int = 3;
static distanceOfBosses as int = 7;

static okayStrings as string[] = [
    "crafttweaker.hunting_altar_access_ok_0",
    "crafttweaker.hunting_altar_access_ok_1",
    "crafttweaker.hunting_altar_access_ok_2"
];
static denialStrings as string[] = [
    "crafttweaker.hunting_altar_access_deny_0",
    "crafttweaker.hunting_altar_access_deny_1",
    "crafttweaker.hunting_altar_access_deny_2"
];

events.onPlayerInteractBlock(
    function(event as PlayerInteractBlockEvent) {
        if(!event.player.world.remote) {
            if(event.block.definition.id == "contenttweaker:hunting_altar") {
                var player = event.player;
                var world = player.world;
                var item = event.item;
                // Get the Altar's Position
                var x = event.x;
                var y = event.y;
                var z = event.z;
                // Particle command: /particle flame ~ ~ ~ 3 0 3 0 50 normal
                server.commandManager.executeCommand(server, "particle flame ~"~x~" ~"~y~" ~"~z~" 3 0 3 0 50 normal "~player.name);
                if(<contenttweaker:inner_gem> has item) {                  
                    // Move player to other place
                    server.commandManager.executeCommand(server, "tp "~player.name~" ~ ~10 ~");
                    // Summon mobs
                    if(world.random.nextFloat() < 0.3f) {
                        player.sendRichTextMessage(ITextComponent.fromTranslation(okayStrings[0]));
                        // At least 49 Magma cubes
                        for xOffset in 0 .. 7 {
                            for zOffset in 0 .. 7 {
                                var summonBlockPos as IBlockPos = Position3f.create((x - 3 + xOffset), y + 2, (z - 3 + zOffset)).asBlockPos();
                                <entity:minecraft:magma_cube>.spawnEntity(world, summonBlockPos);
                            }
                        }
                    }
                    else if(world.random.nextFloat() > 0.9f) {
                        player.sendRichTextMessage(ITextComponent.fromTranslation(okayStrings[2]));
                        for xOffset in 0 .. 2 {
                            for zOffset in 0 .. 2 {
                                var summonBlockPos as IBlockPos = Position3f.create(
                                    (x - distanceOfBosses + distanceOfBosses * xOffset),
                                    y + 2,
                                    (z - distanceOfBosses + distanceOfBosses * zOffset)
                                ).asBlockPos();
                                <entity:abyssalcraft:shadowbeast>.spawnEntity(world, summonBlockPos);
                            }
                        }
                    }
                    else {
                        player.sendRichTextMessage(ITextComponent.fromTranslation(okayStrings[1]));
                        for xOffset in 0 .. 3 {
                            for zOffset in 0 .. 3 {
                                var summonBlockPos as IBlockPos = Position3f.create(
                                    (x - distanceOfNormalMobs + distanceOfNormalMobs * xOffset),
                                    y + 2,
                                    (z - distanceOfNormalMobs + distanceOfNormalMobs * zOffset)
                                ).asBlockPos();
                                <entity:sakura:samuraiillger>.spawnEntity(world, summonBlockPos);
                            }
                        }
                    }
                    // Consume one Gem of the player
                    player.currentItem.mutable().shrink(1);
                    // Then turn itself into a stone
                    world.setBlockState(<blockstate:minecraft:cobblestone>, Position3f.create(x, y, z).asBlockPos());
                }
                else {
                    var randomIndex as int = world.random.nextInt(denialStrings.length);
                    player.sendRichTextMessage(ITextComponent.fromTranslation(denialStrings[randomIndex]));
                    server.commandManager.executeCommand(server, "tp "~player.name~" ~5 ~ ~5");
                }
            }
        }
    }
);