import crafttweaker.data.IData;
recipes.addShapeless(
    "infinite_durability",
    <minecraft:dirt>,
    [
        <contenttweaker:infinite_heart_laevatain>, 
        <*>.only(function(item)
        {
            return !<contenttweaker:infinite_heart_laevatain>.matches(item);
        }).marked("inf_item")
    ],
    function(out,ins,info)
    {
        var inputNBT as IData = ins.inf_item.tag;
        return ins.inf_item.withTag(inputNBT+{Unbreakable:1});
    },
    null
);