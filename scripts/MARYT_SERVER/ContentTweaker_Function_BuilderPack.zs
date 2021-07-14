#loader crafttweaker reloadableevents
// Packages
import mods.contenttweaker.ActionResult;
import mods.contenttweaker.IItemUseFinish;
import mods.contenttweaker.IItemRightClick;

// Necessary classes
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import crafttweaker.util.IRandom;

// MutableItemStack Related Packages
import mods.zenutils.cotx.Item;
import crafttweaker.item.IItemStack;

// Variables claiming
val woodPack as Item = <cotItem:builderpack_wood>;
val woolPack as Item = <cotItem:builderpack_wool>;
val stonePack as Item = <cotItem:builderpack_stone>;
val concretePack as Item = <cotItem:builderpack_concrete>;
val builderPack as Item = <cotItem:builderpack_all>;
val Packs as Item[] = [woodPack, woolPack, stonePack, concretePack, builderPack];
val PackItems as IItemStack[][] = [
    [
        <minecraft:log:0>,
        <minecraft:log:1>,
        <minecraft:log:2>,
        <minecraft:log:3>,
        <minecraft:log2:0>,
        <minecraft:log2:1>,
        <futuremc:stripped_acacia_log>,
        <futuremc:stripped_jungle_log>,
        <futuremc:stripped_birch_log>,
        <futuremc:stripped_oak_log>,
        <futuremc:stripped_spruce_log>,
        <futuremc:stripped_dark_oak_log>,
        <futuremc:stripped_acacia_wood>,
        <futuremc:stripped_jungle_wood>,
        <futuremc:stripped_birch_wood>,
        <futuremc:stripped_oak_wood>,
        <futuremc:stripped_spruce_wood>,
        <futuremc:stripped_dark_oak_wood>,
        <futuremc:acacia_wood>,
        <futuremc:jungle_wood>,
        <futuremc:birch_wood>,
        <futuremc:oak_wood>,
        <futuremc:spruce_wood>,
        <futuremc:dark_oak_wood>
    ],
    [
        <minecraft:wool:0>,
        <minecraft:wool:1>,
        <minecraft:wool:2>,
        <minecraft:wool:3>,
        <minecraft:wool:4>,
        <minecraft:wool:5>,
        <minecraft:wool:6>,
        <minecraft:wool:7>,
        <minecraft:wool:8>,
        <minecraft:wool:9>,
        <minecraft:wool:10>,
        <minecraft:wool:11>,
        <minecraft:wool:12>,
        <minecraft:wool:13>,
        <minecraft:wool:14>,
        <minecraft:wool:15>
    ],
    [
        <minecraft:hardened_clay>,
        <minecraft:cobblestone>,
        <minecraft:stone>,
        <minecraft:stonebrick:3>,
        <minecraft:brick_block>,
        <minecraft:stonebrick>,
        <minecraft:nether_brick>,
        <minecraft:glowstone>,
        <minecraft:sandstone>,
        <minecraft:red_sandstone>,
    ],
    [
        <minecraft:concrete>,
        <minecraft:concrete:1>,
        <minecraft:concrete:2>,
        <minecraft:concrete:3>,
        <minecraft:concrete:4>,
        <minecraft:concrete:5>,
        <minecraft:concrete:6>,
        <minecraft:concrete:7>,
        <minecraft:concrete:8>,
        <minecraft:concrete:9>,
        <minecraft:concrete:10>,
        <minecraft:concrete:11>,
        <minecraft:concrete:12>,
        <minecraft:concrete:14>,
        <minecraft:concrete:13>,
        <minecraft:concrete:15>
    ],
    [
        <contenttweaker:builderpack_wood>,
        <contenttweaker:builderpack_wool>,
        <contenttweaker:builderpack_stone>,
        <contenttweaker:builderpack_concrete>,
    ]
];
for index in 0 .. Packs.length
{
    // Everytime when you call onItemUseFinish events, you should let itemRightClick event to return SUCCESS first.
    Packs[index].itemRightClick = function(stack, world, player, hand)
    {
        return "SUCCESS";
    };
    Packs[index].onItemUseFinish = function(stack, world, item_user){
        if(!world.remote && item_user instanceof IPlayer)
        {        
            var material as IItemStack = PackItems[index][world.random.nextInt(PackItems[index].length)];
            return (index == 4) ? material : material * 64;
        }
        return stack;
    };
}