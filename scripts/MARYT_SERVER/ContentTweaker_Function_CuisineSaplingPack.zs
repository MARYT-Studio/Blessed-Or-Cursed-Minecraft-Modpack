#loader crafttweaker reloadableevents
// Packages
import mods.contenttweaker.ActionResult;
import mods.contenttweaker.IItemUseFinish;
import mods.contenttweaker.IItemRightClick;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;

// MutableItemStack Related Packages
import mods.zenutils.cotx.Item;
import crafttweaker.item.IItemStack;
val PackItems = <cuisine:sapling>.definition.subItems;
<cotItem:cuisine_sapling_pack>.itemRightClick = function(stack, world, player, hand)
{
    return "SUCCESS";
};
<cotItem:cuisine_sapling_pack>.onItemUseFinish = function(stack, world, item_user){
    if(!world.remote && item_user instanceof IPlayer)
    {        
        var material as IItemStack = PackItems[world.random.nextInt(PackItems.length)];
        return material * 3;
    }
    return stack;
};