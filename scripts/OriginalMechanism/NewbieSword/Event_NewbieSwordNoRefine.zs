#loader crafttweaker reloadable
import crafttweaker.event.PlayerAnvilUpdateEvent;
import mods.zenutils.EventPriority;

events.register(function (event as PlayerAnvilUpdateEvent) {
    if (event.leftItem.hasTag && !isNull(event.leftItem.tag.CurrentItemName) && event.leftItem.tag.CurrentItemName.asString() == "custom_newbie") {
        event.cancel();
    }
}, EventPriority.highest(), true);
