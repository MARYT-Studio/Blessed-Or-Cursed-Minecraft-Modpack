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
import mods.zenutils.I18n;

// Chat Messages
val prepareMessages as string[] = I18n.format("contenttweaker.red_envelope_prepare.text").split("<br>");

val redEnvelope = <cotItem:red_envelope_lubang>;
redEnvelope.itemRightClick = function(stack, world, player, hand) {
    if (!world.remote) {
        for message in prepareMessages {
            player.sendChat(message);
        }        
    }
    return "SUCCESS";
};
redEnvelope.onItemUseFinish = function(stack, world, item_user){
    return stack;
};