#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.ActionResult;
import mods.contenttweaker.IItemRightClick;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;

// Variables claming
// Messages
val message as string[] = [
    game.localize("contenttweaker.magic_infused_key_message_0.text"),
    game.localize("contenttweaker.magic_infused_key_message_1.text")
];

// Item Function part
var twilightKey = mods.contenttweaker.VanillaFactory.createItem("magic_infused_key");
twilightKey.creativeTab = <creativetab:misc>;
twilightKey.rarity = "rare";
twilightKey.glowing = true;
twilightKey.maxStackSize = 1;
twilightKey.itemRightClick = function(stack, world, player, hand){
    if(!world.remote)
    {
        world.random.nextBoolean() ? player.sendMessage(message[0]) : player.sendMessage(message[1]);
        return "SUCCESS";
    }
    return "PASS";
};
twilightKey.register();