#loader crafttweaker reloadable
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.text.ITextComponent;

// Items
val giftSword = <lastsmith:.slashblade.named>.withTag({ModelName: "custom/newbie/model", CurrentItemName: "custom_newbie", AttackAmplifier: -4.0 as float, TextureName: "custom/newbie/texture", CustomMaxDamage: 300, baseAttackModifier: 4.0 as float, AttributeModifiers: [{UUIDMost: -3801225194067177672 as long, UUIDLeast: -6586624321849018929 as long, Amount: 2.0, Slot: "mainhand", AttributeName: "generic.attackDamage", Operation: 0, Name: "Weapon modifier"}, {UUIDMost: -422425648963762075 as long, UUIDLeast: -5756800103171642205 as long, Amount: -2.4000000953674316, Slot: "mainhand", AttributeName: "generic.attackSpeed", Operation: 0, Name: "Weapon modifier"}], StandbyRenderType: 2});

val giftAxe = <minecraft:golden_axe>.withTag({newbie: 1});
giftAxe.addEnchantment(<enchantment:minecraft:unbreaking> * 5);

val giftBread = <minecraft:bread>.withTag({newbie: 1}) * 32;
val giftHammer = <sakura:stone_hammer>.withTag({newbie: 1});
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
            // 只执行一次
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
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.1"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.2"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.3"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.4"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.5"));
    }
}
