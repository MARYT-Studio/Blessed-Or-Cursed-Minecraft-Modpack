// Pack Imports
import crafttweaker.data.IData;
import crafttweaker.item.IItemCondition;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
// IC2 SlashBlades Material Items
val IronPlate = <ic2:plate:12>;
val AdvancedAlloy = <ic2:crafting:3>;

// These two circuit plates is of no use.
// val CircuitPlate = <ic2:crafting:1>;
// val AdvancedCircuit = <ic2:crafting:2>;
// Use 2 custom circuit plates below instead.
val CircuitPlate = <contenttweaker:basic_ic>;
val AdvancedCircuit = <contenttweaker:advanced_ic>;
// There are still 3 IC2 items which is needed for IC2 Blades' recipes.
// Iridium Plate, and 2 crystals.
// They are crafted from TouhouLittleMaid's Altar,
// So their recipes are moved into Altar_IC2BladeMaterials.zs

// TofuCraft CircuitPlate
val tofuCircuitPlate = <tofucraft:material:22>;
val tofuCap = <tofucraft:material:21>;
val tofuInd = <tofucraft:material:23>;
// Recipes
val forgingHammer = <sakura:stone_hammer>|<sakura:iron_hammer>|<sakura:sakura_hammer>;
recipes.addShaped("iron_plate",IronPlate,
[
    [null,forgingHammer,null],
    [<minecraft:iron_ingot>,<minecraft:iron_ingot>,<minecraft:iron_ingot>]
]);
recipes.addShaped("advanced_alloy",AdvancedAlloy,
[
    [null,forgingHammer,null],
    [null,IronPlate,null],
    [<dcs_climate:dcs_ingot:6>,<dcs_climate:dcs_ingot:6>,<dcs_climate:dcs_ingot:6>]
]);
// Soldering recipes
recipes.addShapeless(
    "circuit_plate",
    CircuitPlate,
    // 输入材料
    [
        <contenttweaker:soldering_iron>.marked("solderingIron").transformNew
        (
            function(item)
            {
                var solderingIronNBT as IData = item.tag;
                if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
                {
                    return item;
                }
                else
                {
                    var PowerOfSolderingIron as int = solderingIronNBT.PowerLeft.asInt();
                    return item.updateTag({PowerLeft : max(0, PowerOfSolderingIron - 1)});
                }
            }
        ),
        <contenttweaker:solder_wire>,
        <minecraft:redstone>,
        <minecraft:comparator>,
        <minecraft:repeater>,
        tofuCircuitPlate
    ]
    ,
    // 配方函数
    function(out, ins, info)
    {
        print("recipe function has been called");
        var solderingIronNBT as IData = ins.solderingIron.tag;
        if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
        {
            // Test function
            print("This item does not have such NBTs.");
            return null;
        }
        else
        {
            var solderingIronPower as int = solderingIronNBT.PowerLeft.asInt();
            // Test Function
            print("This item has PowerLeft NBT.");
            print("Powerleft is"~solderingIronPower);
            return solderingIronPower >= 1 ? out : null;
        }
    },
    // 配方动作
    null
);
recipes.addShapeless(
    "advanced_circuit_plate",
    AdvancedCircuit,
    // 输入材料
    [
        <contenttweaker:soldering_iron>.marked("solderingIron").transformNew
        (
            function(item)
            {
                var solderingIronNBT as IData = item.tag;
                if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
                {
                    return item;
                }
                else
                {
                    var PowerOfSolderingIron as int = solderingIronNBT.PowerLeft.asInt();
                    return item.updateTag({PowerLeft : max(0, PowerOfSolderingIron - 1)});
                }
            }
        ),
        <contenttweaker:solder_wire>,
        tofuCap,
        tofuInd,
        CircuitPlate,
        tofuCircuitPlate
    ],
    // 配方函数
    function(out, ins, info)
    {
        var solderingIronNBT as IData = ins.solderingIron.tag;
        if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
        {
            return null;
        }
        else
        {
            var solderingIronPower as int = solderingIronNBT.PowerLeft.asInt();
            return solderingIronPower >= 1 ? out : null;
        }
    },
    // 配方动作
    null
);