// Package importing
import crafttweaker.data.IData;
import crafttweaker.item.IItemCondition;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

// Configurations
// Killcount and Proudsoul point number
val firstKillCountNumber as int = 10;
val secondKillCountNumber as int = 150;
val thirdKillCountNumber as int = 450;
val fourthKillCountNumber as int = 1350;

val firstProudsoulNumber as int = 600;
val secondProudsoulNumber as int = 1200;
val thirdProudsoulNumber as int = 2400;

val T3HammerDamage as int = 10;
val T4HammerDamage as int = 100;

// Killcount Token Base Item
val firstKillCountTokenBase = <minecraft:iron_ingot>; // 原版铁锭
val secondKillCountTokenBase = <dcs_climate:dcs_ingot:3>; // HAC 银锭
val thirdKillCountTokenBase = <minecraft:iron_block>; //占位物品，有待修改
val fourthKillCountTokenBase = <minecraft:gold_block>; //占位物品，有待修改

// Proudsoul Bottle Base Item
val firstProudSoulBottleBase = <minecraft:glass_bottle>;
val secondProudSoulBottleBase = <minecraft:experience_bottle>;
val thirdProudSoulBottleBase = <minecraft:diamond_block>; //占位物品，有待修改

// Material variables claiming and tooltip adding
// Killcount Tokens
val firstKillcountToken = <contenttweaker:first_killcount_token>;
firstKillcountToken.addTooltip(game.localize("crafttweaker.first_killcount_token.tooltip"));
firstKillcountToken.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));
val secondKillcountToken = <contenttweaker:second_killcount_token>;
secondKillcountToken.addTooltip(game.localize("crafttweaker.second_killcount_token.tooltip"));
secondKillcountToken.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));
val thirdKillcountToken = <contenttweaker:third_killcount_token>;
thirdKillcountToken.addTooltip(game.localize("crafttweaker.third_killcount_token.tooltip"));
thirdKillcountToken.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));
val fourthKillcountToken = <contenttweaker:fourth_killcount_token>;
fourthKillcountToken.addTooltip(game.localize("crafttweaker.fourth_killcount_token.tooltip"));
fourthKillcountToken.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));

// Proudsoul Bottles
val firstProudsoulBottle = <contenttweaker:first_proudsoul_bottle>;
firstProudsoulBottle.addTooltip(game.localize("crafttweaker.first_proudsoul_bottle.tooltip"));
firstProudsoulBottle.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));
firstProudsoulBottle.addShiftTooltip(game.localize("crafttweaker.general_proudsoul.tooltip"));
firstProudsoulBottle.addShiftTooltip(game.localize("crafttweaker.first_proudsoul_bottle_shift.tooltip"));
val secondProudsoulBottle = <contenttweaker:second_proudsoul_bottle>;
secondProudsoulBottle.addTooltip(game.localize("crafttweaker.second_proudsoul_bottle.tooltip"));
secondProudsoulBottle.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));
secondProudsoulBottle.addShiftTooltip(game.localize("crafttweaker.general_proudsoul.tooltip"));
val thirdProudsoulBottle = <contenttweaker:third_proudsoul_bottle>;
thirdProudsoulBottle.addTooltip(game.localize("crafttweaker.third_proudsoul_bottle_1.tooltip"));
thirdProudsoulBottle.addTooltip(game.localize("crafttweaker.third_proudsoul_bottle_2.tooltip"));
thirdProudsoulBottle.addTooltip(game.localize("crafttweaker.general_tokens.tooltip"));
thirdProudsoulBottle.addShiftTooltip(game.localize("crafttweaker.general_proudsoul.tooltip"));

// Forging Hammers variables claiming
val T1Hammer = <sakura:stone_hammer>;
val T2Hammer = <sakura:iron_hammer>;
val T3Hammer = <sakura:sakura_hammer>;

val T1_allowed_hammers as IItemStack[] = [T1Hammer, T2Hammer, T3Hammer];
val T2_allowed_hammers as IItemStack[] = [T2Hammer, T3Hammer];

// Tier 1 SlashBlades
val T1_SlashBlades = <flammpfeil.slashblade:slashbladewhite>;

// Tier 2 SlashBlades
val mingdao_Xiewan = <lastsmith:.slashblade.named>.withTag({TextureName: "named/sekiro/kusabimaru", ModelName: "named/sekiro/kusabimaru", CurrentItemName: "flammpfeil.slashblade.named.kusabimaru", baseAttackModifier: 5.0 as float, "SB.SEffect": {}});
val ziduandao_Yongzhen = <lastsmith:.slashblade.named>.withTag({TextureName: "named/namedblade/texture_nagasada", ModelName: "named/namedblade/model_stright", CurrentItemName: "flammpfeil.slashblade.named.nagasada", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float, "SB.SEffect": {}});
val gangjian_Dongtianguan = <lastsmith:.slashblade.named>.withTag({TextureName: "named/muramasa/doutanuki", SpecialAttackType: 5, ModelName: "named/muramasa/muramasa", CurrentItemName: "flammpfeil.slashblade.named.doutanuki", baseAttackModifier: 6.0 as float, });
val lidao_Wuming_Hongyu = <lastsmith:.slashblade.named>.withTag({TextureName: "BambooKatana", CurrentItemName: "wrap.BambooMod.katana",baseAttackModifier: 4.0 as float, });
val qianhe_Cunzheng = <lastsmith:.slashblade.named>.withTag({TextureName: "named/muramasa/muramasa", SpecialAttackType: 1, ModelName: "named/muramasa/muramasa", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.muramasa", baseAttackModifier: 6.0 as float, });
val shengxingdao_Lvnaiwu = <lastsmith:.slashblade.named>.withTag({ModelName: "named/blademaster/blademaster", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.blademaster.greenmist", TextureName: "named/blademaster/greenmist", SpecialAttackType: 30, baseAttackModifier: 7.0 as float, });
val shiyuedao_Yanshuibozhan = <lastsmith:.slashblade.named>.withTag({ModelName: "named/blademaster/blademaster", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.blademaster.aquablaze", AttackAmplifier: -5.0 as float, TextureName: "named/blademaster/aquablaze", SpecialAttackType: 31, baseAttackModifier: 7.0 as float});
val yueguangying_Chuixueyishan = <lastsmith:.slashblade.named>.withTag({ModelName: "named/blademaster/blademaster", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.blademaster.moonlightcherry", TextureName: "named/blademaster/greenmist", SpecialAttackType: 32, baseAttackModifier: 7.0 as float});
val xingyuedao_Kongzhijingjie = <lastsmith:.slashblade.named>.withTag({TextureName: "named/tboen/texture", SpecialAttackType: 4, ModelName: "named/tboen/model", CurrentItemName: "flammpfeil.slashblade.named.tboen", baseAttackModifier: 7.0 as float,});
val jieyuedao_Yinyuan = <lastsmith:.slashblade.named>.withTag({SpecialAttackType: 8, TextureName: "named/yukari/texture", ModelName: "named/yukari/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yukari", baseAttackModifier: 7.0 as float, });
val yingguang = <lastsmith:.slashblade.named>.withTag({TextureName: "named/fluorescentbar/fluorescentbar", ModelName: "named/fluorescentbar/fluorescentbar", CurrentItemName: "flammpfeil.slashblade.named.fluorescentbar", baseAttackModifier: 2.0 as float});
val fenglaijian = <lastsmith:.slashblade.named>.withTag({TextureName: "named/wanderer/wanderer", SpecialAttackType: 30, ModelName: "named/wanderer/wanderer", CurrentItemName: "flammpfeil.slashblade.named.wanderer", baseAttackModifier: 7.0 as float});
val fenglaizhixieren =  <lastsmith:slashblade_rf>.withTag({ModelName: "named/wanderer/wanderer", ModelOnName: "named/wanderer/wanderer", CurrentItemName: "flammpfeil.slashblade.named.wanderer.rfblade", AttackAmplifier: -5.0 as float, TextureName: "named/wanderer/wanderer", SpecialAttackType: 30, TextureOnName: "named/wanderer/wanderer", baseAttackModifier: 7.0 as float});
val shanying_Shizou = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_shiwasu", ModelName: "named/yamazakura/shimotsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.shiwasu", IsFakeBlade: 1 as byte, baseAttackModifier: 7.0 as float});
val shanying_Shuangyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_shimotsuki", ModelName: "named/yamazakura/shimotsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.shimotsuki", IsFakeBlade: 1 as byte, baseAttackModifier: 7.0 as float});
val shanyingchangyue_Ju = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_nagatsuki_kiku", ModelName: "named/yamazakura/fumizuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.kiku", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanying_Yeyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_hazuki", ModelName: "named/yamazakura/fumizuki_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.hazuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanying_Gaoyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_satsuki", ModelName: "named/yamazakura/satsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.satsuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanying_Maoyue =  <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_uzuki", ModelName: "named/yamazakura/uzuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.uzuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanyingmisheng_Ying = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_yayoi_sakura", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.sakura", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
val shanyingruyue_Mei = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_kisaragi_ume", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.ume", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
val shanyingmuyue_Song = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_mutsuki_kadomatsu", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.kadomatsu", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
val huyuedao_Baihu = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fox.white", TextureName: "named/sange/white", SpecialAttackType: 0, TrueItemName: "flammpfeil.slashblade.named.fox.white", isBroken: 0 as byte, baseAttackModifier: 4.0 as float});
val huyuedao_Heihu = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fox.black", TextureName: "named/sange/black", SpecialAttackType: 4, TrueItemName: "flammpfeil.slashblade.named.fox.black", isBroken: 0 as byte, baseAttackModifier: 4.0 as float});
val dongyingdao_Xuehuacangyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/frostwolf/frostwolfa", SpecialAttackType: 30, ModelName: "named/frostwolf/frostwolfa", CurrentItemName: "flammpfeil.slashblade.named.frostwolfa", baseAttackModifier: 7.0 as float});
val mingshoudao_Yangyabinglang = <lastsmith:.slashblade.named>.withTag({TextureName: "named/frostwolf/frostwolfb", SpecialAttackType: 32, ModelName: "named/frostwolf/frostwolfb", CurrentItemName: "flammpfeil.slashblade.named.frostwolfb", baseAttackModifier: 7.0 as float});
val dao = <lastsmith:.slashblade.named>.withTag({TextureName: "wa/waA", ModelName: "wa/model", CurrentItemName: "flammpfeil.slashblade.named.wa.katana", baseAttackModifier: 3.0 as float});
val taidao = <lastsmith:.slashblade.named>.withTag({TextureName: "wa/waB", ModelName: "wa/model", CurrentItemName: "flammpfeil.slashblade.named.wa.tachi", baseAttackModifier: 3.0 as float});
val lidao_Cangmei = <lastsmith:.slashblade.named>.withTag({TextureName: "wa/template", SpecialAttackType: 3, ModelName: "wa/model", CurrentItemName: "SlashBladeTemplate.blue", baseAttackModifier: 7.0 as float});
val doudao_Gudu = <lastsmith:.slashblade.named>.withTag({TextureName: "named/namedblade/texture_super", ModelName: "named/namedblade/model", CurrentItemName: "flammpfeil.slashblade.named.kogawa_super", baseAttackModifier: 7.0 as float});
// All T2 Blades List
val T2_SlashBlades = 
    mingdao_Xiewan|
    ziduandao_Yongzhen|
    gangjian_Dongtianguan|
    lidao_Wuming_Hongyu|
    qianhe_Cunzheng|
    shengxingdao_Lvnaiwu|
    shiyuedao_Yanshuibozhan|
    yueguangying_Chuixueyishan|
    xingyuedao_Kongzhijingjie|
    jieyuedao_Yinyuan|
    yingguang|
    fenglaijian|
    fenglaizhixieren|
    shanying_Shizou|
    shanying_Shuangyue|
    shanyingchangyue_Ju|
    shanying_Yeyue|
    shanying_Gaoyue|
    shanying_Maoyue|
    shanyingmisheng_Ying|
    shanyingruyue_Mei|
    shanyingmuyue_Song|
    huyuedao_Baihu|
    huyuedao_Heihu|
    dongyingdao_Xuehuacangyue|
    mingshoudao_Yangyabinglang|
    dao|
    taidao|
    lidao_Cangmei|
    doudao_Gudu;

// Tier 3 SlashBlades
val mojian_Yanmodao = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yamato", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yamato", TextureName: "named/yamato", SpecialAttackType: 0, IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float, "SB.SEffect": {}, });
val jieyuedao_Fusang = <lastsmith:.slashblade.named>.withTag({TextureName: "named/a_tukumo", ModelName: "named/agito", CurrentItemName: "flammpfeil.slashblade.named.yuzukitukumo",SpecialAttackType: 3, baseAttackModifier: 7.0 as float, "SB.SEffect": {}});
val lanyecha = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yasha/yasha", isDefaultBewitched: 1 as byte, IsNoStandDrop: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yasha", TextureName: "named/yasha/yasha", SpecialAttackType: 4, baseAttackModifier: 6.0 as float, });
val hongyecha = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yasha/yasha", SpecialAttackType: 5, ModelName: "named/yasha/yashaTrue", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yashatrue", baseAttackModifier: 6.0 as float});
val sanhua = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.sange", TextureName: "named/sange/sange", SpecialAttackType: 7, IsBewitchedActived: 1 as byte, baseAttackModifier: 6.0 as float});
val kushidadao = <lastsmith:.slashblade.named>.withTag({onClick: 0 as byte, ModelName: "named/dios/dios", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.koseki",TextureName: "named/dios/koseki", SpecialAttackType: 6, isBroken: 0 as byte, baseAttackModifier: 6.0 as float, "SB.SEffect": {WitherEdge: 20}});
val lanemen = <lastsmith:.slashblade.named>.withTag({ModelName: "named/agito", CurrentItemName: "flammpfeil.slashblade.named.agito", TextureName: "named/agito_false", SpecialAttackType: 2, isBroken: 0 as byte, baseAttackModifier: 6.0 as float, });
val dashe_Emen = <lastsmith:.slashblade.named>.withTag({TextureName: "named/orotiagito", SpecialAttackType: 2, ModelName: "named/agito", CurrentItemName: "flammpfeil.slashblade.named.orotiagito", IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float});
//All T3 Blades List
val T3_SlashBlades =
    mojian_Yanmodao|
    jieyuedao_Fusang|
    lanyecha|
    hongyecha|
    sanhua|
    kushidadao|
    lanemen|
    dashe_Emen;

// Tier 4 SlashBlades
val tianyun_Wunian = <lastsmith:.slashblade.named>.withTag({ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.smith.final", SpecialAttackType: 263, TextureName: "named/smith/texture_final", IsBewitchedActived: 1 as byte, isBroken: 0 as byte, baseAttackModifier: 31.0 as float, "SB.SEffect": {bewitched_sharpness: 40, sap_slash: 30}});
// All T4 Blades List
val T4_SlashBlades = tianyun_Wunian;
// End of SlashBlades Tiering

// Make Groups for Every Tier, so that high tier Blades can be used in low tier extracting recipes.
val T1_allowed_SlashBlades as IIngredient[] = [T1_SlashBlades, T2_SlashBlades, T3_SlashBlades, T4_SlashBlades];
val T2_allowed_SlashBlades as IIngredient[] = [T2_SlashBlades, T3_SlashBlades, T4_SlashBlades];
val T3_allowed_SlashBlades as IIngredient[] = [T3_SlashBlades, T4_SlashBlades];
// Beginning of SlashBlades attributes extracting
// Tier 1 extracting
// First Killcount Extracting
var T1recipeNumber as int = 1;
for SlashBladeTier in T1_allowed_SlashBlades
{
    for hammer in T1_allowed_hammers
    {
        recipes.addShapeless(
        // 配方名称
        "T1_killcount_extracting"~T1recipeNumber,
        // 输出物品
        firstKillcountToken,
        // 输入材料
        [
            SlashBladeTier.marked("SlashbladeToExtractKillcount").transformNew
            (
                function(item)
                {
                    var slashBladeToExtractKillcountNBT as IData = item.tag;
                    if(isNull(slashBladeToExtractKillcountNBT)||isNull(slashBladeToExtractKillcountNBT.killCount))
                    {
                        return item;
                    }
                    else
                    {
                        var KillCountToExtract as int = slashBladeToExtractKillcountNBT.killCount.asInt();
                        return item.updateTag({killCount : max(0, KillCountToExtract - firstKillCountNumber)});
                    }
                }
            ),
            hammer.anyDamage().transformDamage(),
            firstKillCountTokenBase
        ],
        // 配方函数
        function(out,ins,info)
        {
            var slashBladeNBT as IData = ins.SlashbladeToExtractKillcount.tag;
            if(isNull(slashBladeNBT)||isNull(slashBladeNBT.killCount))
            {
                return null;
            }
            else
            {
                var slashBladeKillCount as int = slashBladeNBT.killCount.asInt();
                return slashBladeKillCount >= firstKillCountNumber ? out : null;
            }
        },
        // 配方动作
        null
        );
    T1recipeNumber = T1recipeNumber + 1; 
    }
}
// Tier 1 Blades are not able to extract Proudsoul.

// Tier 2 extracting
// Second Killcount Extracting
var T2recipeNumber = 1; 
for SlashBladeTier in T2_allowed_SlashBlades{
for hammer in T2_allowed_hammers
{
    recipes.addShapeless(
    // 配方名称
    "T2_killcount_extracting"~T2recipeNumber,
    // 输出物品
    secondKillcountToken,
    // 输入材料
    [
    SlashBladeTier.marked("SlashbladeToExtractKillcount").transformNew
    (
        function(item)
        {
        var slashBladeToExtractKillcountNBT as IData = item.tag;
        if(isNull(slashBladeToExtractKillcountNBT)||isNull(slashBladeToExtractKillcountNBT.killCount))
        {
            return item;
        }
        else
        {
            var KillCountToExtract as int = slashBladeToExtractKillcountNBT.killCount.asInt();
            return item.updateTag({killCount : max(0, KillCountToExtract - secondKillCountNumber)});
        }
        }
    ),
    hammer.anyDamage().transformDamage(),
    secondKillCountTokenBase
    ],
    // 配方函数
    function(out,ins,info)
    {
    var slashBladeNBT as IData = ins.SlashbladeToExtractKillcount.tag;
    if(isNull(slashBladeNBT)||isNull(slashBladeNBT.killCount))
    {
        return null;
    }
    else
    {
        var slashBladeKillCount as int = slashBladeNBT.killCount.asInt();
        return slashBladeKillCount >= secondKillCountNumber ? out : null;
    }
    },
    // 配方动作
    null
    );

    // First Proudsoul Extracting
    recipes.addShapeless(
    // 配方名称
    "T2_proudsoul_extracting"~T2recipeNumber,
    // 输出物品
    firstProudsoulBottle,
    // 输入材料
    [
    SlashBladeTier.marked("SlashbladeToExtractProudSoul").transformNew
    (
        function(item)
        {
        var slashBladeToExtractProudSoulNBT as IData = item.tag;
        if(isNull(slashBladeToExtractProudSoulNBT)||isNull(slashBladeToExtractProudSoulNBT.ProudSoul))
        {
            return item;
        }
        else
        {
            var ProudSoulToExtract as int = slashBladeToExtractProudSoulNBT.ProudSoul.asInt();
            return item.updateTag({ProudSoul : max(0, ProudSoulToExtract - firstProudsoulNumber)});
        }
        }
    ),
    hammer.anyDamage().transformDamage(),
    firstProudSoulBottleBase
    ],
    // 配方函数
    function(out,ins,info)
    {
    var slashBladeNBT as IData = ins.SlashbladeToExtractProudSoul.tag;
    if(isNull(slashBladeNBT)||isNull(slashBladeNBT.ProudSoul))
    {
        return null;
    }
    else
    {
        var slashBladeProudSoul as int = slashBladeNBT.ProudSoul.asInt();
        return slashBladeProudSoul >= firstProudsoulNumber ? out : null;
    }
    },
    // 配方动作
    null
    );
    T2recipeNumber = T2recipeNumber + 1;
}
}
// Tier 3 extracting
// Third Killcount Extracting
var T3recipeNumber as int = 1;
for SlashBladeTier in T3_allowed_SlashBlades{
recipes.addShapeless(
    // 配方名称
    "T3_killcount_extracting"~T3recipeNumber,
    // 输出物品
    thirdKillcountToken,
    // 输入材料
    [
        SlashBladeTier.marked("SlashbladeToExtractKillcount").transformNew
        (
             function(item)
            {
                var slashBladeToExtractKillcountNBT as IData = item.tag;
                if(isNull(slashBladeToExtractKillcountNBT)||isNull(slashBladeToExtractKillcountNBT.killCount))
                {
                    return item;
                }
                else
                {
                    var KillCountToExtract as int = slashBladeToExtractKillcountNBT.killCount.asInt();
                    return item.updateTag({killCount : max(0, KillCountToExtract - thirdKillCountNumber)});
                }
            }
        ),
        T3Hammer.anyDamage().transformDamage(T3HammerDamage),
        thirdKillCountTokenBase
    ],
    // 配方函数
    function(out,ins,info)
    {
        var slashBladeNBT as IData = ins.SlashbladeToExtractKillcount.tag;
        if(isNull(slashBladeNBT)||isNull(slashBladeNBT.killCount))
        {
            return null;
        }
        else
        {
            var slashBladeKillCount as int = slashBladeNBT.killCount.asInt();
            return slashBladeKillCount >= thirdKillCountNumber ? out : null;
        }
    },
    // 配方动作
    null
);

// Second Proudsoul Extracting
recipes.addShapeless(
    // 配方名称
    "T3_proudsoul_extracting"~T3recipeNumber,
    // 输出物品
    secondProudsoulBottle,
    // 输入材料
    [
        SlashBladeTier.marked("SlashbladeToExtractProudSoul").transformNew
        (
            function(item)
            {
                var slashBladeToExtractProudSoulNBT as IData = item.tag;
                if(isNull(slashBladeToExtractProudSoulNBT)||isNull(slashBladeToExtractProudSoulNBT.ProudSoul))
                {
                    return item;
                }
                else
                {
                    var ProudSoulToExtract as int = slashBladeToExtractProudSoulNBT.ProudSoul.asInt();
                    return item.updateTag({ProudSoul : max(0, ProudSoulToExtract - secondProudsoulNumber)});
                }
            }
        ),
        T3Hammer.anyDamage().transformDamage(T3HammerDamage),
        secondProudSoulBottleBase
    ],
    // 配方函数
    function(out,ins,info)
    {
        var slashBladeNBT as IData = ins.SlashbladeToExtractProudSoul.tag;
        if(isNull(slashBladeNBT)||isNull(slashBladeNBT.ProudSoul))
        {
            return null;
        }
        else
        {
            var slashBladeProudSoul as int = slashBladeNBT.ProudSoul.asInt();
            return slashBladeProudSoul >= secondProudsoulNumber ? out : null;
        }
    },
    // 配方动作
    null
);
T3recipeNumber = T3recipeNumber + 1;
}
// Tier 4 extracting
// Fourth Killcount Extracting
recipes.addShapeless(
    // 配方名称
    "T4_killcount_extracting",
    // 输出物品
    fourthKillcountToken,
    // 输入材料
    [
        T4_SlashBlades.marked("SlashbladeToExtractKillcount").transformNew
        (
             function(item)
            {
                var slashBladeToExtractKillcountNBT as IData = item.tag;
                if(isNull(slashBladeToExtractKillcountNBT)||isNull(slashBladeToExtractKillcountNBT.killCount))
                {
                    return item;
                }
                else
                {
                    var KillCountToExtract as int = slashBladeToExtractKillcountNBT.killCount.asInt();
                    return item.updateTag({killCount : max(0, KillCountToExtract - fourthKillCountNumber)});
                }
            }
        ),
        T3Hammer.anyDamage().transformDamage(T4HammerDamage),
        fourthKillCountTokenBase
    ],
    // 配方函数
    function(out,ins,info)
    {
        var slashBladeNBT as IData = ins.SlashbladeToExtractKillcount.tag;
        if(isNull(slashBladeNBT)||isNull(slashBladeNBT.killCount))
        {
            return null;
        }
        else
        {
            var slashBladeKillCount as int = slashBladeNBT.killCount.asInt();
            return slashBladeKillCount >= fourthKillCountNumber ? out : null;
        }
    },
    // 配方动作
    null
);

// Third Proudsoul Extracting
recipes.addShapeless(
    // 配方名称
    "T4_proudsoul_extracting",
    // 输出物品
    thirdProudsoulBottle,
    // 输入材料
    [
        T4_SlashBlades.marked("SlashbladeToExtractProudSoul").transformNew
        (
            function(item)
            {
                var slashBladeToExtractProudSoulNBT as IData = item.tag;
                if(isNull(slashBladeToExtractProudSoulNBT)||isNull(slashBladeToExtractProudSoulNBT.ProudSoul))
                {
                    return item;
                }
                else
                {
                    var ProudSoulToExtract as int = slashBladeToExtractProudSoulNBT.ProudSoul.asInt();
                    return item.updateTag({ProudSoul : max(0, ProudSoulToExtract - thirdProudsoulNumber)});
                }
            }
        ),
        T3Hammer.anyDamage().transformDamage(T4HammerDamage),
        thirdProudSoulBottleBase
    ],
    // 配方函数
    function(out,ins,info)
    {
        var slashBladeNBT as IData = ins.SlashbladeToExtractProudSoul.tag;
        if(isNull(slashBladeNBT)||isNull(slashBladeNBT.ProudSoul))
        {
            return null;
        }
        else
        {
            var slashBladeProudSoul as int = slashBladeNBT.ProudSoul.asInt();
            return slashBladeProudSoul >= thirdProudsoulNumber ? out : null;
        }
    },
    // 配方动作
    null
);

// SlashBlade Tiering Descriptions
for SlashBladeIngredientOR in T1_allowed_SlashBlades
{
    mods.jei.JEI.addDescription(SlashBladeIngredientOR.items,
    [
        "将此拔刀与铁锭置于工作台上，",
        "用石锻造锤击打，",
        "即可献上拔刀的"~firstKillCountNumber~"点斩杀数，",
        "获取一阶斩杀之证。"
    ]);
}
for SlashBladeIngredientOR in T2_allowed_SlashBlades
{
    mods.jei.JEI.addDescription(SlashBladeIngredientOR.items,
    [
        "将此拔刀与铁锭置于工作台上，",
        "用铁锻造锤击打，",
        "即可献上拔刀的"~secondKillCountNumber~"点斩杀数，",
        "获取二阶斩杀之证。",
        "若将铁锭换成玻璃瓶，",
        "即可献上拔刀的"~firstProudsoulNumber~"点耀魂数，",
        "获取初阶耀魂之瓶。"
    ]);
}
for SlashBladeIngredientOR in T3_allowed_SlashBlades
{
    mods.jei.JEI.addDescription(SlashBladeIngredientOR.items,
    [
        "将此拔刀与铁锭置于工作台上，",
        "用樱锻造锤击打，",
        "即可献上拔刀的"~thirdKillCountNumber~"点斩杀数，",
        "获取三阶斩杀之证。",
        "若将铁锭换成玻璃瓶，",
        "即可献上拔刀的"~secondProudsoulNumber~"点耀魂数，",
        "获取中阶耀魂之瓶。"
    ]);
}
for SlashBladeIngredientOR in T4_SlashBlades
{
    mods.jei.JEI.addDescription(SlashBladeIngredientOR.items,
    [
        "将此拔刀与铁锭置于工作台上，",
        "用樱锻造锤击打，",
        "即可献上拔刀的"~fourthKillCountNumber~"点斩杀数，",
        "获取四阶斩杀之证。",
        "若将铁锭换成玻璃瓶，",
        "即可献上拔刀的"~thirdProudsoulNumber~"点耀魂数，",
        "获取高阶耀魂之瓶。"
    ]);
}