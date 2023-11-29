#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;

events.onPlayerAnvilUpdate(
    function(event as PlayerAnvilUpdateEvent) {
        var item = event.leftItem;
        if (item.definition.id.contains("slashblade")) {
            print("fired1");
        }
        event.outputItem = null;
    }
);