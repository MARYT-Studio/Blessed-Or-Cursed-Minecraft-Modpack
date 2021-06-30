#loader crafttweaker reloadableevents
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.IEventCancelable;

val antiFlesh = <abyssalcraft:antiflesh>;
events.onPlayerRightClickItem(function(event as PlayerRightClickItemEvent){if(antiFlesh has event.item){event.cancel();}});