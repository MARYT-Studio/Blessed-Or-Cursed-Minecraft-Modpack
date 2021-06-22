#loader contenttweaker
//Pack Imports
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;

// Basic Circuit
val message as string[] = [
    game.localize("contenttweaker.magic_infused_key_message_0.text"),
    game.localize("contenttweaker.magic_infused_key_message_1.text")
];
var twilightKey = mods.contenttweaker.VanillaFactory.createItem("magic_infused_key");
twilightKey.creativeTab = <creativetab:misc>;
twilightKey.rarity = "rare";
twilightKey.glowing = true;
twilightKey.maxStackSize = 1;
twilightKey.onItemUse = function(player, world, pos, hand, facing, blockHit){
    world.random.nextBoolean() ? player.sendMessage(message[0]) : player.sendMessage(message[1]);
    return ActionResult.success();
};
twilightKey.register();