#loader crafttweaker reloadableevents
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

val antiFood as IItemStack[] = [<abyssalcraft:antiflesh>, <abyssalcraft:antispidereye>, <abyssalcraft:anticorflesh>];
events.onPlayerRightClickItem(
    function(event as PlayerRightClickItemEvent) {
        for food in antiFood {
            if(food has event.item) {
                event.cancel();
            }
        }
        // if(antiFood has event.item){event.cancel();}
        if(<abyssalcraft:anticorbone> has event.item) {
            event.item.mutable().shrink(1);
            event.player.give(<abyssalcraft:antibone>);
            event.cancel();
        }
    }
);