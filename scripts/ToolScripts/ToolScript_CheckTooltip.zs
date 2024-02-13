#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

// 脚本是否启用，true 为启用，false 为关闭
val enabled = true;

val SwordTooltip as string = game.localize("item.crafttweaker.newbiesword.name");
val AxeTooltip as string = game.localize("item.crafttweaker.newbieaxe.name");
val BreadTooltip as string = game.localize("item.crafttweaker.newbiebread.name");
val HammerTooltip as string = game.localize("item.crafttweaker.newbiehammer.name");
val NewbieTooltips as string[] = [SwordTooltip, AxeTooltip, BreadTooltip, HammerTooltip];

events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        if (!enabled) {return;}
        var player = event.player;
        if (!player.world.remote) {
            if (!isNull(event.item.tag)) {
                var dTag =  D(event.item.tag);
                if dTag.check("newbie") {
                    for tooltip in NewbieTooltips {
                        player.sendChat(tooltip);
                    }
                }
            }
        }
    }
);

