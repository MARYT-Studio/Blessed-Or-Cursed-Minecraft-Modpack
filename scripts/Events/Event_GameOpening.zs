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

// 更新礼包
// 由于今后可能还会在某次更新的时候发放礼品，统一安排在这个脚本当中：
// 礼物的名称变量为 updateGift + 版本号去点，礼物的 NBT 标签名为 updateGift_v + 版本号去点
// 发礼物的版本结束后，将旧的礼物变量注释掉

var updateGift1197 = <contenttweaker:red_envelope_lubang> * 3;

// Event
events.onPlayerLoggedIn(
    function(event as PlayerLoggedInEvent) {
        var player = event.player;
        // 锻刀上限消息计数器初始化
        player.update({"refine_limit_message_sent": 3});
        
        // 将发送聊天消息功能转移到模组中
        // TODO: 用模组替代完毕后，将发送聊天消息有关代码删去
        opening(player);


        var world = player.world;
        if (!(world.remote)) {
            var data = D(player.data);
            // 新手礼包
            if(!(data.check("PlayerPersisted.initialinventory_given_items"))) {
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
            // 更新礼物
            if(!(data.check("PlayerPersisted.updateGift_v1197"))) {
                player.update(
                    {
                        PlayerPersisted: {
                            updateGift_v1197: 1
                        }
                    });
                player.give(updateGift1197);                
            }
        }
    }
);

// TODO: 用模组替代完毕后，将发送聊天消息有关代码删去
function opening(player as IPlayer) {
    // for i in 0 .. 10 {
    //     player.sendChat("");
    // }
    if (player.world.worldInfo.hardcoreModeEnabled) {
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.1"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.2"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.3"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.4"));
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.hardcore.5"));
    }
}
