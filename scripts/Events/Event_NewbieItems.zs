#loader reloadable

import crafttweaker.event.PlayerLoggedInEvent;

val GiftSword = <flammpfeil.slashblade:slashbladewood>.withTag({AttackAmplifier: 11.0 as float,AttributeModifiers: [{Amount: 15.4, Slot: "mainhand", AttributeName: "generic.attackDamage", Operation: 0, Name: "Weapon modifier"}]});
val GiftAxe = <minecraft:diamond_axe>.withDamage(1429).withTag({newbie: 1});
val GiftBread = <minecraft:bread>.withTag({newbie: 1}) * 32;
val GiftHammer = <sakura:stone_hammer>.withTag({newbie: 1});

events.onPlayerLoggedIn(
    function(event as PlayerLoggedInEvent) {
        var player = event.player;
        var world = player.world;
        if (!(world.remote)) {
            var data = player.data;
            if (isNull(data) || isNull(data.PlayerPersisted) || isNull(data.PlayerPersisted)) {}
        }
    }
);
