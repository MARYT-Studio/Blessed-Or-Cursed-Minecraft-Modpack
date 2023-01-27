// Package importing
import crafttweaker.data.IData;
import crafttweaker.item.IItemCondition;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

// Configurations
// Needed Killcounts
val techKillCountNumber as int = 10;
val natureKillCountNumber as int = 30;
val magicKillCountNumber as int = 100;

val KillcountArray as int[] = [techKillCountNumber, magicKillCountNumber, natureKillCountNumber];

// Killcount Token Base Item
val techShardBase = <minecraft:gold_ingot>;
val natureShardBase = <minecraft:gold_ingot>;
val magicShardBase = <minecraft:gold_ingot>;

val ShardBaseArray as IIngredient[] = [techShardBase, magicShardBase, natureShardBase];

// Material variables claiming and tooltip adding
// Killcount Tokens
val techShard = <contenttweaker:tech_shard>;
val natureShard = <contenttweaker:nature_shard>;
val magicShard = <contenttweaker:magic_shard>;

val ShardOutputArray as IItemStack[] = [techShard, magicShard, natureShard];

// Forging Hammers variables claiming
val T1Hammer = <sakura:stone_hammer>;
val T2Hammer = <sakura:iron_hammer>;
val T3Hammer = <sakura:sakura_hammer>;
// Now only iron and sakura hammers is allowed,
// If using stone hammer is acceptable, simply add it here.
val allowed_hammers as IItemStack[] = [T2Hammer, T3Hammer];
val hammerDamage as int = 10;

// Blades to extract the shards
val liangzi_taidao as IItemStack = <lastsmith:slashblade_eu>.withTag({ModelName: "named/nanosaber/model", ModelOnName: "named/nanosaber/model", CurrentItemName: "flammpfeil.slashblade.named.quantumsaber", TextureName: "named/nanosaber/texture_1", TextureOnName: "named/nanosaber/texture_1_on", baseAttackModifier: 21.0 as float});
val yaosai_xuehong as IItemStack = <lastsmith:slashblade_crimson>.withTag({TextureName: "named/thaum/texture_crimson_update", ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fortress.crimson.update", IsBewitchedActived: 1 as byte, baseAttackModifier: 12.0 as float});
val yingjian as IItemStack = <lastsmith:.slashblade.named>.withTag({ModelName: "named/bot_roukan/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.roukan_bot", TextureName: "named/bot_roukan/texture", IsBewitchedActived: 1 as byte, baseAttackModifier: 16.0 as float});

val SlashBladeToExtractArray as IIngredient[] = [liangzi_taidao, yaosai_xuehong, yingjian];

// Beginning of SlashBlades attributes extracting
for hammer in allowed_hammers
{
    for RecipeNumber in 0 to 3
    {
        recipes.addShapeless(
        // \u914D\u65B9\u540D\u79F0
        "shard_extracting_"~RecipeNumber~"_"~hammer.name,
        // \u8F93\u51FA\u7269\u54C1
        ShardOutputArray[RecipeNumber],
        // \u8F93\u5165\u6750\u6599
        [
            SlashBladeToExtractArray[RecipeNumber].marked("BladeForShard").transformNew
            (
                function(item)
                {
                    var BladeForShardNBT as IData = item.tag;
                    if(isNull(BladeForShardNBT)||isNull(BladeForShardNBT.killCount))
                    {
                        return item;
                    }
                    else
                    {
                        var KillCountToExtract as int = BladeForShardNBT.killCount.asInt();
                        return item.updateTag({killCount : max(0, KillCountToExtract - KillcountArray[RecipeNumber])});
                    }
                }
            ),
            hammer.anyDamage().transformDamage(hammerDamage),
            ShardBaseArray[RecipeNumber]
        ],
        // \u914D\u65B9\u51FD\u6570
        function(out,ins,info)
        {
            var slashBladeNBT as IData = ins.BladeForShard.tag;
            if(isNull(slashBladeNBT)||isNull(slashBladeNBT.killCount))
            {
                return null;
            }
            else
            {
                var slashBladeKillCount as int = slashBladeNBT.killCount.asInt();
                return slashBladeKillCount >= KillcountArray[RecipeNumber] ? out : null;
            }
        },
        // \u914D\u65B9\u52A8\u4F5C
        null
        );
    }
}


// Adding SlashBlades' Descriptions
// Configurations
// Description values claiming
val descTextTech as string = game.localize("crafttweaker.put_this_blade_with.desc")~techShardBase.displayName~game.localize("crafttweaker.on_the_craftingtable.desc")~game.localize("crafttweaker.strike_with.desc")~game.localize("crafttweaker.shard_allowed_hammers.desc")~game.localize("crafttweaker.english_neednt_this_part.desc")~game.localize("crafttweaker.sacrifice_blade.desc")~techKillCountNumber~game.localize("crafttweaker.points_of_killcount.desc")~game.localize("crafttweaker.obtain.desc")~<contenttweaker:tech_shard>.displayName~game.localize("crafttweaker.dot.desc");
val descTextNature as string = game.localize("crafttweaker.put_this_blade_with.desc")~natureShardBase.displayName~game.localize("crafttweaker.on_the_craftingtable.desc")~game.localize("crafttweaker.strike_with.desc")~game.localize("crafttweaker.shard_allowed_hammers.desc")~game.localize("crafttweaker.english_neednt_this_part.desc")~game.localize("crafttweaker.sacrifice_blade.desc")~natureKillCountNumber~game.localize("crafttweaker.points_of_killcount.desc")~game.localize("crafttweaker.obtain.desc")~<contenttweaker:nature_shard>.displayName~game.localize("crafttweaker.dot.desc");
val descTextMagic as string = game.localize("crafttweaker.put_this_blade_with.desc")~magicShardBase.displayName~game.localize("crafttweaker.on_the_craftingtable.desc")~game.localize("crafttweaker.strike_with.desc")~game.localize("crafttweaker.shard_allowed_hammers.desc")~game.localize("crafttweaker.english_neednt_this_part.desc")~game.localize("crafttweaker.sacrifice_blade.desc")~magicKillCountNumber~game.localize("crafttweaker.points_of_killcount.desc")~game.localize("crafttweaker.obtain.desc")~<contenttweaker:magic_shard>.displayName~game.localize("crafttweaker.dot.desc");

mods.jei.JEI.addDescription(liangzi_taidao, descTextTech);
mods.jei.JEI.addDescription(yaosai_xuehong, descTextMagic);
mods.jei.JEI.addDescription(yingjian, descTextNature);