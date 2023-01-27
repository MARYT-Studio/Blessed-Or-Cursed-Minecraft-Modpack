#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDamageEvent;

import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import crafttweaker.util.IRandom;
import crafttweaker.text.ITextComponent;

val threshold as int = 1000;
val levelPlayerHurtHigh as int = 1000;
val levelJzaharHurtHigh as int = 200;
val levelPlayerHurtLow as int = 10;
val levelJzaharHurtLow as int = 2;


// First part: Exp devourer's attacking and hurt behavior
events.onEntityLivingDamage(
    function(event as EntityLivingDamageEvent) {
        if(!event.entity.world.remote) {
            if(!(event.damageSource.trueSource instanceof IPlayer)) {
                if(!isNull(event.damageSource.trueSource) && event.damageSource.trueSource.definition.id == "abyssalcraft:jzahar") { // If Jzahar attacks an entity
                    var jzahar = event.damageSource.trueSource;
                    var jzaharData as IData = jzahar.getNBT();
                    if(!isNull(jzaharData.ForgeData) && !isNull(jzaharData.ForgeData.BossType) && jzaharData.ForgeData.BossType.asInt() == 1) { // If it is a Exp devourer
                        if (event.entity instanceof IPlayer) {
                            var jzahar as IEntityLivingBase = event.damageSource.trueSource;
                            var player as IPlayer = event.entity;
                            var currentXP = player.xp;
                            var playerData as IData = player.data;
                            // Save player's xp before battle, so that when battle is end, it can be restored
                            if(isNull(playerData.PlayerPersisted.CurrentXP) || 
                                ((!isNull(playerData.PlayerPersisted.CurrentXP)) && playerData.PlayerPersisted.CurrentXP.asInt() <= currentXP)) {
                                player.update({PlayerPersisted: {CurrentXP: currentXP}});
                            }
                            // Set the level lost now
                            var levelLostWhenPlayerHurt as int = (currentXP >= threshold) ? levelPlayerHurtHigh : levelPlayerHurtLow;
                            // Exp devouring
                            if(currentXP >= levelLostWhenPlayerHurt) {
                                player.xp = currentXP - levelLostWhenPlayerHurt;
                                if(event.entity.world.random.nextBoolean()) {jzahar.heal(6.0f);}
                                player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.exp_devourer_attacking"));
                            }
                            else {
                                player.xp = 0;
                                event.entity.world.removeEntity(jzahar as IEntity);
                                event.entity.world.removeEntity(player as IEntity);
                                player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.exp_devourer_attacking_not_enough"));
                            }
                        }
                    }  
                }
            }
            else { // If a player attacks
                if(event.entity.definition.id == "abyssalcraft:jzahar") { // And a Jzahar is attacked
                    var jzaharData as IData = event.entity.getNBT();
                    if(!isNull(jzaharData.ForgeData) && !isNull(jzaharData.ForgeData.BossType) && jzaharData.ForgeData.BossType.asInt() == 1) { // If it is a Exp devourer
                        var jzahar as IEntityLivingBase = event.entity;
                        var player as IPlayer = event.damageSource.trueSource;
                        var currentXP = player.xp;
                        var playerData as IData = player.data;
                        // Save player's xp before battle, so that when battle is end, it can be restored
                        if(isNull(playerData.PlayerPersisted.CurrentXP) || 
                            ((!isNull(playerData.PlayerPersisted.CurrentXP)) && playerData.PlayerPersisted.CurrentXP.asInt() <= currentXP)) {
                            player.update({PlayerPersisted: {CurrentXP: currentXP}});
                        }
                        // Set the level lost now
                        var levelLostWhenJzaharHurt as int = (currentXP >= threshold) ? levelJzaharHurtHigh : levelJzaharHurtLow;
                        // Exp devouring
                        if(currentXP >= levelLostWhenJzaharHurt) {
                            player.xp = currentXP - levelLostWhenJzaharHurt;
                            if(event.entity.world.random.nextBoolean()) {jzahar.heal(2.0f);}
                            player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.exp_devourer_hurt"));
                        }
                        else {
                            player.xp = 0;
                            event.entity.world.removeEntity(jzahar as IEntity);
                            event.entity.world.removeEntity(player as IEntity);
                            player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.exp_devourer_hurt_not_enough"));
                        }
                    }
                }
            }
        }
    }
);