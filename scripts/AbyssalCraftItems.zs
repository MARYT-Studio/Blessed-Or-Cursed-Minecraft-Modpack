import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
// For send Messages
import crafttweaker.text.ITextComponent;

val AbyssalIngotEnergy = 300;

val abyssBooks as IItemStack[] = [
    <abyssalcraft:necronomicon>,
    <abyssalcraft:necronomicon_cor>,
    <abyssalcraft:necronomicon_dre>,
    <abyssalcraft:necronomicon_omt>,
    <abyssalcraft:abyssalnomicon>
];
val inputBooks as IItemStack[] = [
    <minecraft:book>, abyssBooks[0], abyssBooks[1], abyssBooks[2]
];
val inputSkins as IItemStack[] = [
    <contenttweaker:inner_gem>, <abyssalcraft:skin>, <abyssalcraft:skin:1>, <abyssalcraft:skin:2>
];
val AbyssalIngot = <contenttweaker:abyssal_ingot>;
// Book Recipes
for book in abyssBooks {
    recipes.remove(book);
}
var index as int = 0;
for book in abyssBooks {
    if (index == 4) {
        recipes.addShaped("final_ac_book", book,
        [
            [<abyssalcraft:gatekeeperessence>, <abyssalcraft:eldritchscale>, <abyssalcraft:gatekeeperessence>],
            [<abyssalcraft:eldritchscale>, abyssBooks[3], <abyssalcraft:eldritchscale>],
            [AbyssalIngot, <abyssalcraft:ingotblock:3>, AbyssalIngot] // Ethanxium Block
        ]);
    } else {
        var bookMaterial = (index == 0 ? <twilightforest:giant_obsidian> : AbyssalIngot);
        recipes.addShaped("ac_book_recipe_"~index, book,
        [
            [inputSkins[index], inputSkins[index], <contenttweaker:fourth_killcount_token>],
            [inputSkins[index], inputBooks[index], bookMaterial],
            [<contenttweaker:third_proudsoul_bottle>, bookMaterial, bookMaterial]
        ],
        function (out, ins, info) {return out;},
        function (out, info, player) {
            if(abyssBooks[0].matches(book)) {
                if(!player.world.remote) {
                    player.update({PlayerPersisted: {higherAutoPlayingThreshold : 2}});
                }
            }
        });
    }
    index += 1;
}

// Abyssal Ingot Ritual Recipe
val HACCubesArray as IItemStack[] = [
    <dcs_climate:dcs_color_cube:5>,
    <dcs_climate:dcs_color_cube:6>,
    <dcs_climate:dcs_color_cube:7>,
    <dcs_climate:dcs_color_cube:8>,
    <dcs_climate:dcs_color_cube:9>
];
val TwilightTrophysArray as IItemStack[] = [
    <twilightforest:trophy:2>,
    <twilightforest:trophy:3>,
    <twilightforest:trophy:5>
];
val HACCubes = <dcs_climate:dcs_color_cube:5>|
    <dcs_climate:dcs_color_cube:6>|
    <dcs_climate:dcs_color_cube:7>|
    <dcs_climate:dcs_color_cube:8>|
    <dcs_climate:dcs_color_cube:9>;
val TwilightTrophys = <twilightforest:trophy:2>|
    <twilightforest:trophy:3>|
    <twilightforest:trophy:5>;

var bookType as int = 0;
for book in abyssBooks {
    recipes.addShapeless(
        // 配方名称
        "abyssal_ingot"~bookType,
        // 输出物品
        AbyssalIngot,
        // 输入材料
        [
            book.marked("book").transformNew(
                function(item) {
                    var bookNBT as IData = item.tag;
                    if (isNull(bookNBT) || isNull(bookNBT.PotEnergy)) {
                        return item;
                    } else {
                        var bookEnergy as int = bookNBT.PotEnergy.asInt();
                        return item.updateTag({PotEnergy : max(0, bookEnergy - AbyssalIngotEnergy)});
                    }
                }
            ),
            <dcs_climate:dcs_ingot:18>,
            <twilightforest:fiery_ingot>,
            <twilightforest:fiery_ingot>,
            <twilightforest:fiery_ingot>,
            <thaumcraft:ingot:1>,
            <thaumcraft:ingot:1>,
            TwilightTrophys,
            HACCubes

        ],
        // 配方函数
        function(out,ins,info) {
            var bookNBT as IData = ins.book.tag;
            if (isNull(bookNBT)||isNull(bookNBT.PotEnergy)) {
                // debug
                if (isNull(bookNBT)) {print("bookNBT is null");}
                if (isNull(bookNBT.PotEnergy)) {print("PotEnergy is null");}
                return null;
            } else {
                var bookPotEnergy as int = bookNBT.PotEnergy.asInt();
                if (bookPotEnergy >= AbyssalIngotEnergy) {return out;}
                else {
                    info.player.sendRichTextMessage(
                        ITextComponent.fromTranslation("crafttweaker.energy_not_enough_0") ~
                        ITextComponent.fromTranslation("item.necronomicon.name") ~
                        ITextComponent.fromTranslation("crafttweaker.energy_not_enough_1") ~
                        ITextComponent.fromString(AbyssalIngotEnergy as string) ~
                        ITextComponent.fromTranslation("crafttweaker.energy_not_enough_2")
                    );
                    return null;
                }
            }
        },
        // 配方动作
        null
    );
    bookType += 1;
}