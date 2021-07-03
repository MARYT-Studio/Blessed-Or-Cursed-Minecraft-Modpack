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

// For send Messages
import crafttweaker.text.ITextComponent;

// Variable claiming
val wingPotion = <minecraft:potion>.withTag({Potion: "dcs_climate:dcs.bird"});
val minDamageHearts as int = 5;
val maxDamageHearts as int = 9;
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
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_1"));
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_3"));
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_4"));
                }
                else
                {
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_2"));
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_3"));
                    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_4"));
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
                var randomDamageHearts as int = world.random.nextInt(minDamageHearts, maxDamageHearts);
                var randomDamage as float = 2.0f * randomDamageHearts;
                player.attackEntityFrom(
                    crafttweaker.damage.IDamageSource.MAGIC(),
                    randomDamage
                );
                var displayDamage as string = randomDamageHearts as string;
                player.sendRichTextMessage(
                    ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_5") ~
                    ITextComponent.fromString(displayDamage) ~
                    ITextComponent.fromTranslation("crafttweaker.wing_blessing_before_6")
                );
            }
        }
    }
);