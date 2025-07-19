import mods.touhoulittlemaid.Altar;
// Variables claiming
val fengleijian = <thaumcraft:elemental_sword>.withTag({infench: [{lvl: 2 as short, id: 5 as short}]});
val yaosai_fenglei = <lastsmith:slashblade_wind>.withTag({TextureName: "named/thaum/texture_elemental_update", ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fortress.elemental.update", CustomMaxDamage: 1500, IsBewitchedActived: 1 as byte});
val louguanjian = <lastsmith:.slashblade.named>.withTag({ench: [{lvl: 2 as short, id: 34 as short}, {lvl: 1 as short, id: 19 as short}, {lvl: 4 as short, id: 16 as short}], ModelName: "named/roukan/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.roukan", TextureName: "named/roukan/texture", IsBewitchedActived: 1 as byte});
val yingzhibaozhu = <lastsmith:materials:6>;
val louguan_xuanfeng = <flammpfeil.slashblade:proudsoul:4>.withTag({infench: [{lvl: 3 as short, id: 5 as short}], ench: [{lvl: 4 as short, id: 34 as short}, {lvl: 4 as short, id: 16 as short}], ModelName: "named/roukan/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.roukan_xf", AttackAmplifier: -14.0 as float, TextureName: "named/roukan/texture_xf", CustomMaxDamage: 40, IsBewitchedActived: 1 as byte, baseAttackModifier: 16.0 as float, "SB.SEffect": {extreme_sharpness: 10}, StandbyRenderType: 2});
Altar.addItemCraftRecipe("louguan_xuanfeng", 5.0,
                         louguan_xuanfeng, 
                         fengleijian,
                         fengleijian,
                         yaosai_fenglei,
                         louguanjian,
                         yingzhibaozhu,
                         yingzhibaozhu
                        );
