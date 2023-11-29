#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.ItemTossEvent;
import mods.zenutils.NetworkHandler;

val enabled = true;

events.onItemToss(
    function(event as ItemTossEvent) {
        if (enabled) {
            var player = event.player;
            if (!player.world.remote) {
                var itemEntity = event.item;
                if (!isNull(itemEntity.item.tag.markdirty)) {
                    NetworkHandler.sendTo("clear_client_hand", player);
                }
            }
        }
    }
);

NetworkHandler.registerServer2ClientMessage("clear_client_hand", function(player, byteBuf) {
    player.setItemToSlot(player.activeHand, null);
});
