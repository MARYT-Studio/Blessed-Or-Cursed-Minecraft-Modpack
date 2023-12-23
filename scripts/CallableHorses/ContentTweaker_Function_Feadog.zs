#loader crafttweaker reloadable
// Packages
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import mods.contenttweaker.IItemRightClick;
import crafttweaker.entity.IEntity;

// MutableItemStack Related Packages
import crafttweaker.item.IItemStack;

// For Send Messages
import crafttweaker.text.ITextComponent;

val feadog = <cotItem:feadog>;
feadog.itemRightClick = function(stack, world, player, hand) {
    if (!world.remote) {
        player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.feadog_message_1.text"));
    }
    return "SUCCESS";
};
feadog.onItemUseFinish = function(stack, world, item_user) {
    if(!world.remote && item_user instanceof IPlayer) {        
        var player as IPlayer = item_user;
        server.commandManager.executeCommand(server, "summon horse " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " {Variant: 1029}");
        server.commandManager.executeCommand(server, "playsound asmc:block.beacon.activate player " ~ player.name ~ " " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " 1.0 2.0 0.0");
        player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.feadog_message_2.text"));
        return <minecraft:saddle>;
    }
    return stack;
};
