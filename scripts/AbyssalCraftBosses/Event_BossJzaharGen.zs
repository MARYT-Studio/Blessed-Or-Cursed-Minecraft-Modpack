#loader crafttweaker reloadableevents
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityJoinWorldEvent;

import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.AttributeInstance;
import crafttweaker.text.ITextComponent;

events.onEntityJoinWorld(
    function(event as EntityJoinWorldEvent) {
        if(!event.world.remote) {
            if(!event.entity instanceof IPlayer && event.entity.definition.id == "abyssalcraft:jzahar") { // if a Jzahar is generated
                if(true || event.world.random.nextInt(3) == 0) { // 1/3 Jzahar is boss
                    var jzahar as IEntityLivingBase = event.entity;

                    jzahar.getAttribute("generic.maxHealth").setBaseValue(600.0f); // Set its HP higher
                    jzahar.health = 600.0f;

                    // var bosstype as int =  1 + event.world.random.nextInt(3); // Maybe there will be 3 types of Jzahar
                    var bosstype as int =  1; // Now there is just one type
                    jzahar.setNBT({BossType: bosstype});

                    // Server title warning
                    server.commandManager.executeCommand (
                        server,
                        "title @a title {\"text\": \"" + ITextComponent.fromTranslation("crafttweaker.jzahar_boss_warning").unformattedComponentText + "\", \"color\": \"red\"}"
                    );
                    if(bosstype == 1) { // Exp devourer
                        server.commandManager.executeCommand (
                            server,
                            "title @a subtitle {\"text\": \"" + ITextComponent.fromTranslation("crafttweaker.jzahar_boss_type_1").unformattedComponentText + "\", \"color\": \"gold\"}"
                        );
                    }
                }
            }
        }
    }
);
