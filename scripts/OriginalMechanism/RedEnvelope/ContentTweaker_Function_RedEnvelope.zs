#loader crafttweaker reloadable
// Packages
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import mods.contenttweaker.BlockPos;
import crafttweaker.data.IData;
import crafttweaker.util.IRandom;
import mods.contenttweaker.Facing;

// MutableItemStack Related Packages
import crafttweaker.item.IItemStack;

// For Send Messages
import mods.zenutils.I18n;

static creeperList as string[] = [
    "specialmobs:specialcreeper", // 绿色
    "specialmobs:deathcreeper", // 黑色
    "specialmobs:gravelcreeper", // 白色
    "specialmobs:firecreeper", // 红色
    "specialmobs:drowningcreeper", //蓝色
    "specialmobs:endercreeper" // 特殊
];


// Chat Messages
val prepareMessages as string[] = I18n.format("contenttweaker.red_envelope_prepare.text").split("<br>");
val openedItem = <minecraft:paper>.withTag({display:{Name: I18n.format("contenttweaker.red_envelope_best_wishes.text0"),Lore:[I18n.format("contenttweaker.red_envelope_best_wishes.text1")]}});


val redEnvelope = <cotItem:red_envelope_lubang>;

redEnvelope.itemRightClick = function(stack, world, player, hand) {
    if (!world.remote) {
        for message in prepareMessages {
            player.sendChat(message);
        }
    }
    return "SUCCESS";
};

redEnvelope.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (world.remote) return ActionResult.pass();
    var summonPos = pos.getOffset(Facing.up(), 3); // 这个是头的位置，脚离地两格高
    if (world.getBlock(summonPos).definition.canSpawnInBlock) {
        summonTarget(world, summonPos);
        player.setItemToSlot(player.activeHand, openedItem);
        return ActionResult.success();
    }
    return ActionResult.pass();
};

// 工具函数：随机召唤指定的靶子生物
function summonTarget(world as IWorld, pos as BlockPos) as void {
    var creeper = "";
    var rand = world.random.nextFloat();
    if (rand <= 0.05) {
        creeper = creeperList[5];
    } else if (rand <= 0.24) {
        creeper = creeperList[0];
    } else if (rand <= 0.43) {
        creeper = creeperList[1];
    } else if (rand <= 0.62) {
        creeper = creeperList[2];
    } else if (rand <= 0.81) {
        creeper = creeperList[3];
    } else {
        creeper = creeperList[4];
    }
    server.commandManager.executeCommand(server, "summon " ~ creeper ~ " " ~ pos.x ~" "~  pos.y~" "~ pos.z ~ " {NoAI: 1, NoGravity: 1}");
}
