// Pack Imports
import crafttweaker.data.IData;
// IC2 SlashBlades Material Items
val IronPlate = <ic2:plate:12>;
val AdvancedAlloy = <ic2:crafting:3>;

val CircuitPlate = <ic2:crafting:1>;
val AdvancedCircuit = <ic2:crafting:2>;

val Lapotron = <ic2:lapotron_crystal>.withTag({charge: 1.0E7});
val EnergyCrystal = <ic2:energy_crystal>.withTag({charge: 1000000.0});

val IridiumPlate = <ic2:crafting:4>;
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
// Soldering recipes Plan A
// recipes.addShapeless(
//     "circuit_plate",
//     CircuitPlate,
//     // 输入材料
//     [
//         <minecraft:stone>.marked("solderingIron").transformNew
//         (
//             function(item)
//             {
//                 var solderingIronNBT as IData = item.tag;
//                 if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
//                 {
//                     return item;
//                 }
//                 else
//                 {
//                     var PowerOfSolderingIron as int = solderingIronNBT.PowerLeft.asInt();
//                     return item.updateTag({PowerLeft : max(0, PowerOfSolderingIron - 1)});
//                 }
//             }
//         ),
//         <contenttweaker:solder_wire>,
//         <minecraft:redstone>,
//         <minecraft:comparator>,
//         <minecraft:repeater>,
//         tofuCircuitPlate
//     ]
//     // ,
//     // // 配方函数
//     // function(out, ins, info)
//     // {
//     //     print("recipe function has been called");
//     //     var solderingIronNBT as IData = ins.solderingIron.tag;
//     //     if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
//     //     {
//     //         // Test function
//     //         print("This item does not have such NBTs.");
//     //         return null;
//     //     }
//     //     else
//     //     {
//     //         var solderingIronPower as int = solderingIronNBT.PowerLeft.asInt();
//     //         // Test Function
//     //         print("This item has PowerLeft NBT.");
//     //         print("Powerleft is"~solderingIronPower);
//     //         return solderingIronPower >= 1 ? out : null;
//     //     }
//     // },
//     // // 配方动作
//     // null
// );
// recipes.addShapeless(
//     "advanced_circuit_plate",
//     AdvancedCircuit,
//     // 输入材料
//     [
//         <contenttweaker:soldering_iron>.marked("solderingIron").transformNew
//         (
//             function(item)
//             {
//                 var solderingIronNBT as IData = item.tag;
//                 if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
//                 {
//                     return item;
//                 }
//                 else
//                 {
//                     var PowerOfSolderingIron as int = solderingIronNBT.PowerLeft.asInt();
//                     return item.updateTag({PowerLeft : max(0, PowerOfSolderingIron - 1)});
//                 }
//             }
//         ),
//         <contenttweaker:solder_wire>,
//         tofuCap,
//         tofuInd,
//         CircuitPlate,
//         tofuCircuitPlate
//     ],
//     // 配方函数
//     function(out, ins, info)
//     {
//         var solderingIronNBT as IData = ins.solderingIron.tag;
//         if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
//         {
//             return null;
//         }
//         else
//         {
//             var solderingIronPower as int = solderingIronNBT.PowerLeft.asInt();
//             return solderingIronPower >= 1 ? out : null;
//         }
//     },
//     // 配方动作
//     null
// );

// Soldering recipes Plan B