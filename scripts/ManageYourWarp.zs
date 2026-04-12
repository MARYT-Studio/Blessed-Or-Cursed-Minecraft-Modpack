import crafttweaker.item.IItemStack;
import crafttweaker.text.ITextComponent;
import crafttweaker.player.IPlayer;

// New recipe for san checker
recipes.remove(<thaumcraft:sanity_checker>);
recipes.addShaped("sanchecker", <thaumcraft:sanity_checker>,
    [
        [<thaumcraft:ingot>, <ore:string>],
        [<thaumcraft:amber>, <ore:string>],
        [<thaumcraft:ingot>, <ore:string>]
    ]
);

// Normal Warp removal ritual
val shoggothFlesh as IItemStack[] = [
    <abyssalcraft:shoggothflesh:0>,
    <abyssalcraft:shoggothflesh:1>,
    <abyssalcraft:shoggothflesh:2>,
    <abyssalcraft:shoggothflesh:3>,
    <abyssalcraft:shoggothflesh:4>
];
for i in 0 .. (shoggothFlesh.length) {
    recipes.addShapeless("wash_your_normal_warp_" ~ i, <minecraft:rotten_flesh>,
    [
        <dcs_climate:dcs_food_antibiotic:7>, shoggothFlesh[i]
    ],
    function(out, ins, info) {return out;},
    function(out,info,player)
    {
        if (!player.world.remote) {
            clearWarp(player, i, false);
        }
    });
    // 简单版仪式，可以用魔法试剂桶代替
    recipes.addShapeless("wash_your_normal_warp_simple_" ~ i, <minecraft:rotten_flesh>,
    [
        <forge:bucketfilled>.withTag({FluidName: "dcs.mazai", Amount: 1000}), shoggothFlesh[i]
    ],
    function(out, ins, info) {return out;},
    function(out,info,player)
    {
        if (!player.world.remote) {
            clearWarp(player, i, true);
        }
    });
}

// 工具函数（配置）：清除扭曲的大小
// warpType 允许的值有且只有三种：
// "" - 代表普通扭曲
// "TEMP" - 代表临时扭曲
// "PERM" - 代表永久扭曲
// easyRecipe 代表是否为简单版仪式，简单版仪式的清除量是正常版的一半
function getWarpClearAmount(easyRecipe as bool, i as int, warpType as string) as int {
    // 在此处修改基础量
    var baseAmount = 5;
    
    var result = easyRecipe ? baseAmount : baseAmount * 2;
    if (warpType == "TEMP") {
        return (i + 1) * result;
    } else if (warpType == "PERM") {
        return 999;
    } else {
        return (i + 1) * result;
    }
}

// 工具函数：调用命令清除扭曲
// warpType 允许的值有且只有三种：
// "" - 代表普通扭曲
// "TEMP" - 代表临时扭曲
// "PERM" - 代表永久扭曲
function clearCommand(player as IPlayer, point as int, warpType as string) as void {
    // point 输入 999 或以上的数值代表直接清零
    server.commandManager.executeCommand(
        server,
        point >= 999 ?
        "thaum warp " ~ player.name ~ " set " ~ 0 ~ " " ~ warpType :
        "thaum warp " ~ player.name ~ " add " ~ (0 - point) ~ " " ~ warpType
    );
}

// 工具函数：扭曲清除
// easyRecipe 代表是否为简单版仪式，简单版仪式的清除量是正常版的一半
function clearWarp(player as IPlayer, i as int, easyRecipe as bool) as void {
    val warpTypes as string[] = ["", "TEMP", "PERM"];    
    for warpType in warpTypes {
        var point = getWarpClearAmount(easyRecipe, i, warpType);
        clearCommand(player, point, warpType);
    }
    player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.warp_removed"));
}
