// Package importing
import crafttweaker.data.IData;
import crafttweaker.item.IItemCondition;

// Variables claiming
val killCountForTwilightKey as int = 300;

// Two Shard Materials
val natureShard = <contenttweaker:nature_shard>;
val magicShard = <contenttweaker:magic_shard>;

// Two Blade Materials
val mojian_Yanmodao = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yamato", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yamato", TextureName: "named/yamato", SpecialAttackType: 0, IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float, "SB.SEffect": {}, });
val sanhua = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.sange", TextureName: "named/sange/sange", SpecialAttackType: 7, IsBewitchedActived: 1 as byte, baseAttackModifier: 6.0 as float});

// The Output
val twilightKey = <contenttweaker:magic_infused_key>;
recipes.addShapeless(
// 配方名称
"twilightforest_key_recipe",
// 输出物品
twilightKey,
// 输入材料
[
    mojian_Yanmodao.marked("yanmodaoToExtractKillCount").transformNew
    (
        function(item)
        {
            var yanmodaoNBT as IData = item.tag;
            if(isNull(yanmodaoNBT)||isNull(yanmodaoNBT.killCount))
            {
                return item;
            }
            else
            {
                var KillCountToExtract as int = yanmodaoNBT.killCount.asInt();
                return item.updateTag({killCount : max(0, KillCountToExtract - killCountForTwilightKey)});
            }
        }
    ),
    sanhua.marked("sanhuaToExtractKillCount").transformNew
    (
        function(item)
        {
            var sanhuaNBT as IData = item.tag;
            if(isNull(sanhuaNBT)||isNull(sanhuaNBT.killCount))
            {
                return item;
            }
            else
            {
                var KillCountToExtract as int = sanhuaNBT.killCount.asInt();
                return item.updateTag({killCount : max(0, KillCountToExtract - killCountForTwilightKey)});
            }
        }
    ),
    natureShard,
    magicShard
],
// 配方函数
function(out,ins,info)
{
    var yanmodaoNBT as IData = ins.yanmodaoToExtractKillCount.tag;
    var sanhuaNBT as IData = ins.sanhuaToExtractKillCount.tag;
    if(isNull(yanmodaoNBT)||isNull(sanhuaNBT)||isNull(yanmodaoNBT.killCount)||isNull(sanhuaNBT.killCount))
    {
        return null;
    }
    else
    {
        var yanmodaoKillCount as int = yanmodaoNBT.killCount.asInt();
        var sanhuaKillCount as int = sanhuaNBT.killCount.asInt();
        return ((yanmodaoKillCount >= killCountForTwilightKey) && (sanhuaKillCount >= killCountForTwilightKey)) ? out : null;
    }
},
// 配方动作
function(out,info,player)
{
    if(!player.world.remote)
    {
        player.update({PlayerPersisted: {HasCraftedInfusedKey: 1}});
        player.update({PlayerPersisted: {higherAutoPlayingThreshold : 1}});
        player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.has_access_to_tf"));
    }
});