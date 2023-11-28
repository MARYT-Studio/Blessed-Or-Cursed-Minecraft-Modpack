#loader crafttweaker reloadable

import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.item.IItemStack;

val giftSwordName as string = game.localize("item.crafttweaker.newbiesword.name");
val giftAxeName as string = game.localize("item.crafttweaker.newbieaxe.name");
val giftBreadName as string = game.localize("item.crafttweaker.newbiebread.name");
val giftHammerName as string = game.localize("item.crafttweaker.newbiehammer.name");

val giftSword = <flammpfeil.slashblade:slashbladewood>.withTag({
    newbie: 1,
    ench: [
        {
            lvl: 8 as short, id: 34 as short
        }
    ],
    display: {Name: giftSwordName},
    AttributeModifiers:[
        {AttributeName:"generic.armor",Amount:4,Slot:"mainhand",Name:"generic.armor",UUIDLeast:328254300,UUIDMost:99},
        {AttributeName:"generic.armorToughness",Amount:2,Slot:"mainhand",Name:"generic.armorToughness",UUIDLeast:328254400,UUIDMost:99},
        {AttributeName:"generic.attackDamage",Amount:4,Slot:"mainhand",Name:"generic.attackDamage",UUIDLeast:328254500,UUIDMost:99}
    ]
});
val giftAxe = <minecraft:golden_axe>.withTag({display: {Name: giftAxeName}, ench: [{lvl: 3 as short, id: 34 as short}], newbie: 1});
val giftBread = <minecraft:bread>.withTag({display: {Name: giftBreadName}, newbie: 1}) * 32;
val giftHammer = <sakura:stone_hammer>.withTag({display: {Name: giftHammerName}, newbie: 1});
val newbieItems as IItemStack[] = [giftSword, giftAxe, giftBread, giftHammer];

events.onPlayerLoggedIn(
    function(event as PlayerLoggedInEvent) {
        var player = event.player;
        var world = player.world;
        if (!(world.remote)) {
            var data = player.data;
            if (isNull(data) ||
                isNull(data.PlayerPersisted) ||
                isNull(data.PlayerPersisted.initialinventory_given_items)) {
                player.update(
                    {
                        PlayerPersisted: {
                            initialinventory_given_items: 1
                        }
                    });
                for item in newbieItems {
                    player.give(item);
                }
            }            
        }
    }
);
