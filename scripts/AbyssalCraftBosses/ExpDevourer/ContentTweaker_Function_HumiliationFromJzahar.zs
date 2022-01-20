#loader crafttweaker reloadableevents
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

val humiliation = <cotItem:humiliation_from_jzahar>;
humiliation.itemRightClick = function(stack, world, player, hand)
{
    return "SUCCESS";
};
humiliation.onItemUseFinish = function(stack, world, item_user){
    if(!world.remote && item_user instanceof IPlayer)
    {        
        var player as IPlayer = item_user;
        if(!(isNull(player.data)) && !(isNull(player.data.PlayerPersisted)) && !(isNull(player.data.PlayerPersisted.CurrentXP))) {
            player.xp = player.data.PlayerPersisted.CurrentXP.asInt();
            player.update({PlayerPersisted: {CurrentXP: -1}});
            return <item:minecraft:egg>;
        }        
    }
    return stack;
};