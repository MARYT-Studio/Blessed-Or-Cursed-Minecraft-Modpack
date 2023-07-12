#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerInteractBlockEvent;
events.onPlayerInteractBlock(
    function(event as PlayerInteractBlockEvent) {
        if(event.block.definition.id == "futuremc:grindstone") {
            var player = event.player;
            var world = player.world;
            if (!world.remote) {
                // Player will be notified for the first time definitely.
                // From the second time and then on, notification will be reduced for anti-spam.
                if (
                    (!isNull(player.data)) &&
                    (!isNull(player.data.PlayerPersisted)) &&
                    (!isNull(player.data.PlayerPersisted.GrindstoneNotified))
                ) {
                    if (world.random.nextFloat() < 0.25f) {
                        player.sendMessage(game.localize("crafttweaker.grindstone_is_temporarily_banned_1.tooltip"));
                        player.sendMessage(game.localize("crafttweaker.grindstone_is_temporarily_banned_2.tooltip"));
                    }
                } else {
                    player.sendMessage(game.localize("crafttweaker.grindstone_is_temporarily_banned_1.tooltip"));
                    player.sendMessage(game.localize("crafttweaker.grindstone_is_temporarily_banned_2.tooltip"));
                    player.update({PlayerPersisted: {GrindstoneNotified: 1}});
                }
            }
        }
});