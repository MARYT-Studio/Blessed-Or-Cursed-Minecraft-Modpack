#loader crafttweaker reloadableevents
import crafttweaker.event.PlayerPickupItemEvent;
import crafttweaker.event.EntityTravelToDimensionEvent;

import crafttweaker.player.IPlayer;
import crafttweaker.text.ITextComponent;
// Gain access by picking up the Infused Key
events.onPlayerPickupItem(function(event as PlayerPickupItemEvent){
    if(event.item.item.definition.id == "huntingdim:frame")
    {
        event.player.update({PlayerPersisted: {HasCraftedHDPortal: 1}});
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.has_access_to_hd"));
    }
});
// Access Checker
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