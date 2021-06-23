#loader crafttweaker reloadableevents
// Packages
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;
import mods.contenttweaker.IItemRightClick;

// MutableItemStack Related Packages
import crafttweaker.item.IItemStack;

// Variables claiming
// Messages
val message as string[] = [
    game.localize("contenttweaker.infinite_heart_laevatain_message_0.text"),
    game.localize("contenttweaker.infinite_heart_laevatain_message_1.text"),
    game.localize("contenttweaker.infinite_heart_laevatain_message_2.text"), // Green Badge Meessage
    game.localize("contenttweaker.infinite_heart_laevatain_message_3.text") // Non Green Badge Meessage
];
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
val infHeart = <cotItem:infinite_heart_laevatain>;
// infHeart.itemRightClick = function(stack, world, player, hand){
//     if(!world.remote)
//     {
//         (world.random.nextBoolean()) ? (player.sendMessage(message[0])) : (player.sendMessage(message[1]));
//         return "SUCCESS";
//     }
//     return "PASS";
// };
infHeart.onItemUseFinish = function(stack, world, player){
    if(!world.remote)
    {
        (world.random.nextBoolean()) ? (player.sendMessage(message[2])) : (player.sendMessage(message[3]));
        stack.shrink(1);
        return stack;
    }
    return stack;
};