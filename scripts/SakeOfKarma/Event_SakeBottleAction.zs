#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerInteractBlockEvent;

import crafttweaker.text.ITextComponent;

import crafttweaker.util.IRandom;

import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;

import crafttweaker.data.IData;

// Configurations
val cost as int = 50;

val numberOfNormalMobs as int = 4;
val distanceOfNormalMobs as int = 2;
val distanceOfBosses as int = 3;

val okayStrings as string[] = [
    "crafttweaker.hunting_altar_access_ok_0",
    "crafttweaker.hunting_altar_access_ok_1",
    "crafttweaker.hunting_altar_access_ok_2"
];
val denialStrings as string[] = [
    "crafttweaker.hunting_altar_access_deny_0",
    "crafttweaker.hunting_altar_access_deny_1",
    "crafttweaker.hunting_altar_access_deny_2"
];

events.onPlayerInteractBlock(
    function(event as PlayerInteractBlockEvent) {
        if(!event.player.world.remote) {
            if(event.block.definition.id == "contenttweaker:sake_of_karma") {
                var player = event.player;
                var world = player.world;
                var item = event.item;
                if(!("flammpfeil.slashblade" has item.definition.owner) && !("lastsmith" has item.definition.owner)) {
                    // Get the Sake Bottle's Position
                    var x = event.x;
                    var y = event.y;
                    var z = event.z;
                    // This Particle effect means ritual fails.
                    server.commandManager.executeCommand(server, "particle smoke ~"~x~" ~"~y~" ~"~z~" 0.05 0.1 0.05 0.05 300 normal "~player.name);
                    return;
                } else {
                    var bladeToActivateData as IData = item.tag;
                    if(isNull(bladeToActivateData) || isNull(bladeToActivateData.ProudSoul)) {
                        var x = event.x;
                        var y = event.y;
                        var z = event.z;
                        server.commandManager.executeCommand(server, "particle smoke ~"~x~" ~"~y~" ~"~z~" 0.05 0.1 0.05 0.05 300 normal "~player.name);
                        return;
                    } else {
                        var proudSoul = bladeToActivateData.asInt();
                        if (proudSoul < cost) {
                            var x = event.x;
                            var y = event.y;
                            var z = event.z;
                            server.commandManager.executeCommand(server, "particle smoke ~"~x~" ~"~y~" ~"~z~" 0.05 0.1 0.05 0.05 300 normal "~player.name);
                            return;
                        } else {
                            var x = event.x;
                            var y = event.y;
                            var z = event.z;
                            server.commandManager.executeCommand(server, "particle largesmoke ~"~x~" ~"~y~" ~"~z~" 1 5 1 0.1 300 normal "~player.name);
                            // TODO: Sake of Karma effect
                        }
                    }
                }
            }
        }
    }
);
