import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
// For send Messages
import crafttweaker.text.ITextComponent;

val AbyssalIngotEnergy = 300;

val firstAbyssBook = <abyssalcraft:necronomicon>.withTag({PotEnergy: 0.0 as float});
val secondAbyssBook = <abyssalcraft:necronomicon_cor>.withTag({PotEnergy: 0.0 as float});
val thirdAbyssBook = <abyssalcraft:necronomicon_dre>.withTag({PotEnergy: 0.0 as float});
val fourthAbyssBook = <abyssalcraft:necronomicon_omt>.withTag({PotEnergy: 0.0 as float});
val finalAbyssBook = <abyssalcraft:abyssalnomicon>.withTag({PotEnergy: 0.0 as float});
val allAbyssBooksWithoutNBT as IItemStack[] = [
    <abyssalcraft:necronomicon>,
    <abyssalcraft:necronomicon_cor>,
    <abyssalcraft:necronomicon_dre>,
    <abyssalcraft:necronomicon_omt>,
    <abyssalcraft:abyssalnomicon>
];
val allAbyssBooks as IItemStack[] = [
    firstAbyssBook, secondAbyssBook, thirdAbyssBook, fourthAbyssBook, finalAbyssBook
];
val inputBooks as IItemStack[] = [
    <minecraft:book>, firstAbyssBook, secondAbyssBook, thirdAbyssBook
];
val inputSkins as IItemStack[] = [
    <contenttweaker:inner_gem>, <abyssalcraft:skin>, <abyssalcraft:skin:1>, <abyssalcraft:skin:2>
];
val AbyssalIngot = <contenttweaker:abyssal_ingot>;
// Book Recipes
for book in allAbyssBooksWithoutNBT
{
    recipes.remove(book);
}
var index as int = 0;
for book in allAbyssBooks
{
    if(finalAbyssBook.matches(book))
    {
        recipes.addShaped("final_ac_book", book,
        [
            [<abyssalcraft:gatekeeperessence>, <abyssalcraft:eldritchscale>, <abyssalcraft:gatekeeperessence>],
            [<abyssalcraft:eldritchscale>, fourthAbyssBook, <abyssalcraft:eldritchscale>],
            [AbyssalIngot, <abyssalcraft:ingotblock:3>, AbyssalIngot] // Ethanxium Block
        ]);
    }
    else
    {
        var bookMaterial = (firstAbyssBook.matches(book)) ? <twilightforest:giant_obsidian> : AbyssalIngot;
        recipes.addShaped("ac_book_recipe_"~index, book,
        [
            [inputSkins[index], inputSkins[index], <contenttweaker:fourth_killcount_token>],
            [inputSkins[index], inputBooks[index], bookMaterial],
            [<contenttweaker:third_proudsoul_bottle>, bookMaterial, bookMaterial]
        ],
        function (out, ins, info) {return out;},
        function (out, info, player)
        {
            if(firstAbyssBook.matches(book))
            {
                if(!player.world.remote)
                {
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
index = 0;
var bookType as int = 0;
for abyssbook in allAbyssBooksWithoutNBT
{
    recipes.addShapeless(
        // \u914D\u65B9\u540D\u79F0
        "abyssal_ingot"~bookType,
        // \u8F93\u51FA\u7269\u54C1
        AbyssalIngot,
        // \u8F93\u5165\u6750\u6599
        [
            abyssbook.marked("book").transformNew
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
        // \u914D\u65B9\u51FD\u6570
        function(out,ins,info)
        {
            var bookNBT as IData = ins.book.tag;
            if(isNull(bookNBT)||isNull(bookNBT.PotEnergy))
            {
                return null;
            }
            else
            {
                var bookPotEnergy as int = bookNBT.PotEnergy.asInt();
                if(bookPotEnergy >= AbyssalIngotEnergy){return out;}
                else
                {
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
        // \u914D\u65B9\u52A8\u4F5C
        null
    );
    bookType += 1;
}