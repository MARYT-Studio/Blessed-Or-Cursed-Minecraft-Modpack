#loader crafttweaker reloadable
// Packages
import mods.contenttweaker.ActionResult;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import mods.contenttweaker.BlockPos;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;
import crafttweaker.util.IRandom;
import mods.contenttweaker.Facing;
import crafttweaker.text.ITextComponent;

// MutableItemStack Related Packages
import crafttweaker.item.IItemStack;

static debug as bool = false;

static creeperList as string[] = [
    "specialmobs:specialcreeper", // 绿色
    "specialmobs:deathcreeper", // 黑色
    "specialmobs:gravelcreeper", // 白色
    "specialmobs:firecreeper", // 红色
    "specialmobs:drowningcreeper", //蓝色
    "specialmobs:endercreeper" // 特殊
];


// Chat Messages
val openedItem = <minecraft:paper>.withTag({display:{Name: ITextComponent.fromTranslation("contenttweaker.red_envelope_best_wishes.text1").formattedText,Lore:[ITextComponent.fromTranslation("contenttweaker.red_envelope_best_wishes.text2").formattedText]}});


val redEnvelope = <cotItem:red_envelope_lubang>;

redEnvelope.itemRightClick = function(stack, world, player, hand) {
    return "SUCCESS";
};

redEnvelope.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (world.remote) return ActionResult.pass();
    var summonPos = pos.getOffset(Facing.up(), 3); // 这个是头的位置，脚离地两格高
    if (world.getBlock(summonPos).definition.canSpawnInBlock) {
        summonTarget(player, world, summonPos);
        player.getHeldItem(hand).mutable().shrink(1);
        return ActionResult.success();
    }
    return ActionResult.pass();
};

// 工具函数：随机召唤指定的靶子生物
function summonTarget(player as IPlayer, world as IWorld, pos as BlockPos) as void {
    var creeper = "";
    var rand = world.random.nextFloat();
    if (rand <= 0.05) {
        creeper = creeperList[5];
        player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope_lucky"));
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
    var time = world.provider.getWorldTime() + 20L;
    if (debug) player.sendChat(time);
    server.commandManager.executeCommand(server, "summon " ~ creeper ~ " " ~ pos.x ~" "~  pos.y~" "~ pos.z ~ " {NoAI: 1, NoGravity: 1, Invulnerable: 1, Glowing: 1, powered: 1, ForgeData: {RedEnvelope: 1, FreeHit: 2, SummonerUUID: "~ player.uuid ~ ", Timer:" ~ time ~"}}");
    world.updateCustomWorldData({RedEnvelopeGameStatus: {player.uuid: 2}});
    world.updateCustomWorldData({RedEnvelopeTargetPosition: {player.uuid: {x: pos.x, y: pos.y, z: pos.z}}});
}
