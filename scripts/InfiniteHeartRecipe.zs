import crafttweaker.data.IData;
val infHeartEnergy = 50000;
// Unused AC Ritual
// mods.abyssalcraft.CreationRitual.addRitual(
//     "infinite_heart",
//     4, 53, 50000, true,
//     <contenttweaker:infinite_heart_laevatain>,
//     [
//         <abyssalcraft:abyssalnomicon>,
//         <contenttweaker:third_proudsoul_bottle>,
//         <contenttweaker:third_proudsoul_bottle>,
//         <abyssalcraft:staff>,
//         <contenttweaker:abyssal_ingot>,
//         <contenttweaker:abyssal_ingot>,
//         <abyssalcraft:ingotblock:3>,
//         <abyssalcraft:ingotblock:3>, 
//         <contenttweaker:fourth_killcount_token>
//     ],
//     false
// );
recipes.addShapeless(
    // 配方名称
    "infinite_heart",
    // 输出物品
    <contenttweaker:infinite_heart_laevatain>,
    // 输入材料
    [
        <abyssalcraft:abyssalnomicon:*>.marked("book").transformNew
        (
            function(item)
            {
                var bookNBT as IData = item.tag;
                if(isNull(bookNBT)||isNull(bookNBT.PotEnergy))
                {
                    return item;
                }
                else
                {
                    var bookEnergy as int = bookNBT.PotEnergy.asInt();
                    return item.updateTag({PotEnergy : max(0, bookEnergy - infHeartEnergy)});
                }
            }
        ),
        <contenttweaker:third_proudsoul_bottle>,
        <contenttweaker:third_proudsoul_bottle>,
        <abyssalcraft:staff>,
        <contenttweaker:abyssal_ingot>,
        <contenttweaker:abyssal_ingot>,
        <abyssalcraft:ingotblock:3>,
        <abyssalcraft:ingotblock:3>, 
        <contenttweaker:fourth_killcount_token>
    ],
    // 配方函数
    function(out,ins,info)
    {
        var bookNBT as IData = ins.book.tag;
        if(isNull(bookNBT)||isNull(bookNBT.PotEnergy))
        {
            return null;
        }
        else if(info.player.world.dimension != 53)
        {
            info.player.sendMessage(game.localize("crafttweaker.dim_is_incorrect")~game.localize("crafttweaker.dim53"));
            return null;
        }
        else
        {
            var bookPotEnergy as int = bookNBT.PotEnergy.asInt();
            if(bookPotEnergy >= infHeartEnergy)
            {
                return out;
            }
            else
            {
                info.player.sendMessage(game.localize("crafttweaker.energy_not_enough_0")~ins.book.displayName~game.localize("crafttweaker.energy_not_enough_1")~infHeartEnergy~game.localize("crafttweaker.energy_not_enough_2"));
                return null;
            }
        }
    },
    // 配方动作
    null
    );