#loader crafttweaker reloadable
// Packages
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import crafttweaker.util.IRandom;
import mods.contenttweaker.IItemRightClick;

// MutableItemStack Related Packages
import crafttweaker.item.IItemStack;

// For Send Messages
import crafttweaker.text.ITextComponent;

// Variables claiming
// Items only for Infinite Heart
val InfiniteHeartItem as IItemStack[] = [
    // 5 Badges
    <item:dcs_climate:dcs_color_badge>,
    <item:dcs_climate:dcs_color_badge:1>,
    <item:dcs_climate:dcs_color_badge:2>,
    <item:dcs_climate:dcs_color_badge:3>,
    <item:dcs_climate:dcs_color_badge:4>,
    // HAC Other final items
    <item:dcs_climate:dcs_sword_toolsteel>
];
// if set this to 3, open the 4th Infinite Heart will get the badge:2.
val maxFailureTimes = 3;
val infHeart = <cotItem:infinite_heart_laevatain>;
infHeart.itemRightClick = function(stack, world, player, hand)
{
    (world.random.nextBoolean()) ? 
    (player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.infinite_heart_laevatain_message_0.text"))) :
    (player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.infinite_heart_laevatain_message_1.text")));
    return "SUCCESS";
};
infHeart.onItemUseFinish = function(stack, world, item_user){
    if(!world.remote && item_user instanceof IPlayer)
    {        
        var randomIndex = world.random.nextInt(InfiniteHeartItem.length);
        var player as IPlayer = item_user;
        if(!(<item:dcs_climate:dcs_color_badge:1>.matches(InfiniteHeartItem[randomIndex])))
        {
            player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.infinite_heart_laevatain_message_3.text"));
            if(isNull(player.data.PlayerPersisted) || isNull(player.data.PlayerPersisted.infHeartFail))
            {
                player.update({PlayerPersisted: {infHeartFail: 1}});
            }
            else
            {
                var failedTime = player.data.PlayerPersisted.infHeartFail;
                player.update({PlayerPersisted: {infHeartFail: failedTime + 1}});
                if(failedTime >= maxFailureTimes)
                {
                    player.update({PlayerPersisted: {infHeartFail: 0}});
                    player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.infinite_heart_laevatain_message_2.text"));
                    return <item:dcs_climate:dcs_color_badge:1>;
                }
            }
        }
        else
        {
            player.update({PlayerPersisted: {infHeartFail: 0}});
            player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.infinite_heart_laevatain_message_2.text"));
        }
        return InfiniteHeartItem[randomIndex];
    }
    return stack;
};