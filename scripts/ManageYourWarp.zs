import crafttweaker.item.IItemStack;
import crafttweaker.text.ITextComponent;

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
for i in 0 .. (shoggothFlesh.length)
{
    recipes.addShapeless("wash_your_normal_warp" ~ i, <minecraft:rotten_flesh>,
    [
        <dcs_climate:dcs_food_antibiotic:7>, shoggothFlesh[i]
    ],
    function(out, ins, info){return out;},
    function(out,info,player)
    {
        if(!player.world.remote)
        {
            server.commandManager.executeCommand(
                server,
                "thaum warp "~player.name~" add "~ (0 - (i + 1) * 10)
            );
            player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.warp_removed"));
        }
    });
}