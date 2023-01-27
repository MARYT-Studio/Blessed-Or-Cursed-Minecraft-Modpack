#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathEvent;

import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import crafttweaker.util.IRandom;
import crafttweaker.text.ITextComponent;

// Second Part: When player or the boss dies
events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent) {
        if(!event.entity.world.remote) {
            if(event.entity instanceof IPlayer) {
                if(!isNull(event.damageSource.trueSource) && !(event.damageSource.trueSource instanceof IPlayer) && event.damageSource.trueSource.definition.id == "abyssalcraft:jzahar") { // If player killed by Jzahar
                    var jzahar = event.damageSource.trueSource;
                    var jzaharData as IData = jzahar.getNBT();
                    if(!isNull(jzaharData.ForgeData) && !isNull(jzaharData.ForgeData.BossType) && jzaharData.ForgeData.BossType.asInt() == 1) { // If it is a Exp devourer
                        var player as IPlayer = event.entity;
                        var playerData as IData = player.data;
                        if(!isNull(playerData.PlayerPersisted) && !isNull(playerData.PlayerPersisted.CurrentXP)) {
                            player.give(<contenttweaker:humiliation_from_jzahar>);
                            player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.exp_devourer_player_killed"));
                        }
                    }
                }
            }
            else {
                if(event.entity.definition.id == "abyssalcraft:jzahar") { // If a Jzahar is killed
                    var jzaharData as IData = event.entity.getNBT();
                    if(!isNull(jzaharData.ForgeData) && !isNull(jzaharData.ForgeData.BossType) && jzaharData.ForgeData.BossType.asInt() == 1) { // If it is a Exp devourer
                        if(!isNull(event.damageSource.trueSource) && (event.damageSource.trueSource instanceof IPlayer)) { // If player kills Jzahar
                            var player as IPlayer = event.damageSource.trueSource;
                            var playerData as IData = player.data;
                            if(!isNull(playerData.PlayerPersisted) && !isNull(playerData.PlayerPersisted.CurrentXP)) {
                                player.xp = playerData.PlayerPersisted.CurrentXP.asInt();
                                player.update({PlayerPersisted: {CurrentXP: -1}});
                                player.give(<abyssalcraft:gatekeeperessence> * (1 + event.entity.world.random.nextInt(4)));
                                player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.exp_devourer_jzahar_killed"));
                            }
                        }
                    }
                }
            }
        }
    }
);
