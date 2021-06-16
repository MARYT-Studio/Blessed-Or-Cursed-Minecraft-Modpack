#loader crafttweaker reloadableevents
// Package importing
// Event base
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingUseItemEvent.Start;
import crafttweaker.event.EntityLivingUseItemEvent.Finish;
// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;

// Variable claiming
val wingPotion = <minecraft:potion>.withTag({Potion: "dcs_climate:dcs.bird"});
val minDamageHearts as int = 5;
val maxDamageHearts as int = 9;
val textsBeforeUse as string[] = [
    game.localize("crafttweaker.wing_blessing_before_1"), 
    game.localize("crafttweaker.wing_blessing_before_2"),
    game.localize("crafttweaker.wing_blessing_before_3"),
    game.localize("crafttweaker.wing_blessing_before_4"),
    game.localize("crafttweaker.wing_blessing_before_5"),
    game.localize("crafttweaker.wing_blessing_before_6")
];
// Test mark
print("Here is reloading start.");
// Event part
events.onEntityLivingUseItemStart(
    function(event as Start)
    {
        if(event.item has wingPotion)
        {
            var world as IWorld = event.player.world;
            if(!world.remote)
            {
                var player as IPlayer = event.player;
                if(world.random.nextBoolean())
                {
                    player.sendMessage(textsBeforeUse[0]);
                    player.sendMessage(textsBeforeUse[2]);
                    player.sendMessage(textsBeforeUse[3]);
                }
                else
                {
                    player.sendMessage(textsBeforeUse[1]);
                    player.sendMessage(textsBeforeUse[2]);
                    player.sendMessage(textsBeforeUse[3]);
                }
            }
        }
    }
);
events.onEntityLivingUseItemFinish(
    function(event as Finish)
    {
        if(event.item has wingPotion)
        {
            var player as IPlayer = event.player;
            var world as IWorld = event.player.world;
            if(!world.remote)
            {
                var randomDamageHearts = world.random.nextInt(minDamageHearts, maxDamageHearts);
                var randomDamage as float = 2.0f * randomDamageHearts;
                player.attackEntityFrom(
                    crafttweaker.damage.IDamageSource.MAGIC(),
                    randomDamage
                );
                player.sendMessage(textsBeforeUse[4]~randomDamageHearts~textsBeforeUse[5]);
            }
        }
    }
);