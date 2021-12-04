#loader crafttweaker reloadableevents
// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathEvent;
import crafttweaker.player.IPlayer;

// Other needed packages
import crafttweaker.item.IItemStack;

// Two Vanilla Boss Blades
var sanhua = <lastsmith:.slashblade.named>.withTag({SlashBlade: {}, ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.sange", AttackAmplifier: -4.0 as float, TextureName: "named/sange/sange", SpecialAttackType: 7, CustomMaxDamage: 70, IsBewitchedActived: 1 as byte, baseAttackModifier: 6.0 as float, StandbyRenderType: 2});
var yanmodao = <lastsmith:.slashblade.named>.withTag({isSealed: 1 as byte, SlashBlade: {}, ModelName: "named/yamato", isNoScabbard: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yamato.broken", AttackAmplifier: -5.0 as float, TextureName: "named/yamato", SpecialAttackType: 0, TrueItemName: "flammpfeil.slashblade.named.yamato", CustomMaxDamage: 40, isBroken: 1 as byte, baseAttackModifier: 7.0 as float, "SB.SEffect": {Limitter: 30}, StandbyRenderType: 1});

events.onEntityLivingDeath(
    function(event as EntityLivingDeathEvent) {
        if(!event.entity.world.remote && (event.damageSource.trueSource instanceof IPlayer)) {
            var player as IPlayer = event.damageSource.trueSource;
            if(!(event.entity instanceof IPlayer)) {
                if("WitherBoss" has event.entity.definition.name) {
                    player.give(sanhua);   
                }
                else if("EnderDragon" has event.entity.definition.name) {
                    player.give(yanmodao);
                }
            }
        }
    }
);
