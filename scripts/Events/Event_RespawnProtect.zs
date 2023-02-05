#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;

// Packages for CraftTweaker Events
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRespawnEvent;

// Packages for Potion function
import crafttweaker.potions.IPotionEffect;

// For send Messages
import crafttweaker.text.ITextComponent;

events.onPlayerRespawn(
    function(event as PlayerRespawnEvent)
    {
        var player as IPlayer = event.player;
        if(!event.endConquered)
        {
            var absorption as IPotionEffect = <potion:minecraft:absorption>.makePotionEffect(300, 3);
            var weakness as IPotionEffect = <potion:minecraft:weakness>.makePotionEffect(300, 2);
            var invisibility as IPotionEffect =<potion:minecraft:invisibility>.makePotionEffect(300, 0);
            player.addPotionEffect(absorption);
            player.addPotionEffect(weakness);
            player.addPotionEffect(invisibility);
        }
    }
);