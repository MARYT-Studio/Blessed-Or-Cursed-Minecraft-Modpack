#loader crafttweaker reloadable
import crafttweaker.event.EntityTravelToDimensionEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.text.ITextComponent;

events.onEntityTravelToDimension(
    function(event as EntityTravelToDimensionEvent) {
        // IEntity convert to IPlayer
        if(event.entity instanceof IPlayer)
        {
            var player as IPlayer = event.entity;
            if (
                (!player.world.remote) &&
                (event.dimension == 28885) &&
                (
                    (isNull(player.data)) ||
                    (isNull(player.data.PlayerPersisted)) ||
                    (isNull(player.data.PlayerPersisted.HasCraftedHDPortal))
                )
            )
            {
                event.cancel();
                player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.cannot_go_to_hd"));
            }   
        }
    }
);