#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.event.PlayerLeftClickBlockEvent;

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
                if(!(item.definition.owner == "flammpfeil.slashblade") && !(item.definition.owner == "lastsmith")) {
                    // Get the Sake Bottle's Position
                    var x = event.x;
                    var y = event.y;
                    var z = event.z;
                    // This Particle effect means ritual fails.
                    server.commandManager.executeCommand(server, "particle smoke ~"~x~" ~"~y~" ~"~z~" 0.05 0.1 0.05 0.05 300 normal "~player.name);
                    player.sendRichTextMessage(ITextComponent.fromString("\u4EEA\u5F0F\u5931\u8D25\uFF1A\u975E\u62D4\u5200\u5251\u7269\u54C1"));
                    player;
                    return;
                } else {
                    player.sendRichTextMessage(ITextComponent.fromString("\u662F\u62D4\u5200\u5251\u7269\u54C1"));
                    var bladeToActivateData as IData = item.tag;
                    if(isNull(bladeToActivateData) || isNull(bladeToActivateData.ProudSoul)) {
                        var x = event.x;
                        var y = event.y;
                        var z = event.z;
                        server.commandManager.executeCommand(server, "particle smoke ~"~x~" ~"~y~" ~"~z~" 0.05 0.1 0.05 0.05 300 normal "~player.name);
                        player.sendRichTextMessage(ITextComponent.fromString("\u4EEA\u5F0F\u5931\u8D25\uFF1A\u4E0D\u5177\u6709\u8000\u9B42\u70B9\u6570"));
                        return;
                    } else {
                        player.sendRichTextMessage(ITextComponent.fromString("\u6709\u8000\u9B42\u70B9\u6570"));
                        var proudSoul = bladeToActivateData.ProudSoul.asInt();
                        if (proudSoul < cost) {
                            var x = event.x;
                            var y = event.y;
                            var z = event.z;
                            server.commandManager.executeCommand(server, "particle smoke ~"~x~" ~"~y~" ~"~z~" 0.05 0.1 0.05 0.05 300 normal "~player.name);
                            player.sendRichTextMessage(ITextComponent.fromString("\u4EEA\u5F0F\u5931\u8D25\uFF1A\u8000\u9B42\u70B9\u6570\u4E0D\u8DB3"));
                            return;
                        } else {
                            var x = event.x;
                            var y = event.y;
                            var z = event.z;
                            server.commandManager.executeCommand(server, "particle largesmoke ~"~x~" ~"~y~" ~"~z~" 1 5 1 0.1 300 normal "~player.name);
                            player.sendRichTextMessage(ITextComponent.fromString("\u4EEA\u5F0F\u6210\u529F"));
                            // TODO: Sake of Karma effect
                        }
                    }
                }
            }
        }
    }
);
