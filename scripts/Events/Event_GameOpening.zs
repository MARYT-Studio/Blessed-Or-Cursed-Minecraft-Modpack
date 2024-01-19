#loader crafttweaker reloadable
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;

// Items
val giftAxeName as string = game.localize("item.crafttweaker.newbieaxe.name");
val giftBreadName as string = game.localize("item.crafttweaker.newbiebread.name");
val giftHammerName as string = game.localize("item.crafttweaker.newbiehammer.name");

val giftSword = <lastsmith:.slashblade.named>.withTag({ModelName: "custom/newbie/model", CurrentItemName: "custom_newbie", AttackAmplifier: -4.0 as float, TextureName: "custom/newbie/texture", CustomMaxDamage: 300, baseAttackModifier: 4.0 as float, AttributeModifiers: [{UUIDMost: -3801225194067177672 as long, UUIDLeast: -6586624321849018929 as long, Amount: 2.0, Slot: "mainhand", AttributeName: "generic.attackDamage", Operation: 0, Name: "Weapon modifier"}, {UUIDMost: -422425648963762075 as long, UUIDLeast: -5756800103171642205 as long, Amount: -2.4000000953674316, Slot: "mainhand", AttributeName: "generic.attackSpeed", Operation: 0, Name: "Weapon modifier"}], StandbyRenderType: 2});

val giftAxe = <minecraft:golden_axe>.withTag({display: {Name: giftAxeName}, ench: [{lvl: 5 as short, id: 34 as short}], newbie: 1});
val giftBread = <minecraft:bread>.withTag({display: {Name: giftBreadName}, newbie: 1}) * 32;
val giftHammer = <sakura:stone_hammer>.withTag({display: {Name: giftHammerName}, newbie: 1});
val newbieItems as IItemStack[] = [giftSword, giftAxe, giftBread, giftHammer, <contenttweaker:feadog>];

// Event
events.onPlayerLoggedIn(
    function(event as PlayerLoggedInEvent) {
        var player = event.player;
        // 锻刀上限消息计数器初始化
        player.update({"refine_limit_message_sent": 3});
        opening(player);
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

function opening(player as IPlayer) {
    for i in 0 .. 10 {
        player.sendChat("");
    }
    if (player.world.worldInfo.hardcoreModeEnabled) {
        for text in game.localize("crafttweaker.hardcore").split("<br>") {
            player.sendChat(text);
        }
    }
}
