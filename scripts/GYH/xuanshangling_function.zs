#loader crafttweaker reloadable
// Packages
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import mods.contenttweaker.IItemRightClick;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityDefinition;

// MutableItemStack Related Packages
import crafttweaker.item.IItemStack;

// For Send Messages
import crafttweaker.text.ITextComponent;

// FTBQ
import mods.zenutils.ftbq.CustomTaskEvent;

val xuanshangling = <cotItem:xuanshangling>;
xuanshangling.itemRightClick = function(stack, world, player, hand) {
    if (!world.remote) {
        player.sendChat("1");
    }
    return "SUCCESS";
};

val RandomType as IItemStack[] = [
    <contenttweaker:xuanshangling1>,
    <contenttweaker:xuanshangling2>,
    <contenttweaker:xuanshangling3>,
    <contenttweaker:xuanshangling4>,
    <contenttweaker:xuanshangling5>,
    ];
xuanshangling.onItemUseFinish = function(stack, world, item_user) {
    if(!world.remote && item_user instanceof IPlayer) {        
        var player as IPlayer = item_user;
        var item as IItemStack = player.currentItem;
        var randomIndex = world.random.nextInt(RandomType.length);
        if(item.displayName=="1"){
            player.sendChat("21");
            return <contenttweaker:xuanshangling1>;
        }
        else if(item.displayName=="2"){
            player.sendChat("22");
            return <contenttweaker:xuanshangling2>;
        }
        else if(item.displayName=="3"){
            player.sendChat("23");
            return <contenttweaker:xuanshangling3>;
        }
        else if(item.displayName=="4"){
            player.sendChat("24");
            return <contenttweaker:xuanshangling4>;
        }
        else if(item.displayName=="5"){
            player.sendChat("25");
            return <contenttweaker:xuanshangling5>;
        }
        else{
            server.commandManager.executeCommand(server, "summon horse " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " {Variant: 1029}");
            server.commandManager.executeCommand(server, "playsound asmc:block.beacon.activate player " ~ player.name ~ " " ~ player.posX ~" "~  player.posY~" "~ player.posZ ~ " 1.0 2.0 0.0");
            player.sendChat("20");
            return RandomType[randomIndex];
        }
    }
    return stack;
};

val xuanshangling1 = <cotItem:xuanshangling1>;
xuanshangling1.itemRightClick = function(stack, world, player, hand) {
    if (!world.remote) {
        var item as IItemStack = player.currentItem;
        player.sendChat("\u5F53\u524D\u8FDB\u5EA6(\u7B49\u4F1A\u6413\u7F62)");
        if (!isNull(item.tag.complete)&&item.tag.complete >= 10 && item.tag.complete < 20) {
            player.sendChat("SUCCESS");
        }
    }
    return "SUCCESS";
};

xuanshangling1.onItemUseFinish = function(stack, world, item_user) {
    if(!world.remote && item_user instanceof IPlayer) {
        var player as IPlayer = item_user;
        // 这后面的任务没有做完，这条 wdnmd 就代表事件肯定触发了
        player.sendChat("wdnmd");
        var item as IItemStack = player.currentItem;
        if (!isNull(item.tag.complete)) {
            player.update({PlayerPersisted: {xuanshang: item.tag.complete}});
            player.setItemToSlot(player.activeHand,null);
            player.sendChat("FINISH");
        }
    }
    return stack;
};

events.onCustomTask(function(event as CustomTaskEvent) {
    if (event.task.hasTag("1")) {
        event.maxProgress = 10;
        event.checkTimer = 200;
        event.enableButton = false;
        event.checker = function(player, currentProgress) {
            if (player.data has "PlayerPersisted" && player.data.PlayerPersisted has "xuanshang" && player.data.PlayerPersisted.xuanshang != 0) {
                return player.data.PlayerPersisted.xuanshang.asInt();
                player.update({PlayerPersisted: {xuanshang: 0}});
            } else {
                return 0;
            }
        };
    }
});




