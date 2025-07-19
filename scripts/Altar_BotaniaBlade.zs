import mods.touhoulittlemaid.Altar;
// Variables claiming
val ziduandao_Yongzhen = <lastsmith:.slashblade.named>.withTag({TextureName: "named/namedblade/texture_nagasada", ModelName: "named/namedblade/model_stright", CurrentItemName: "flammpfeil.slashblade.named.nagasada", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float, "SB.SEffect": {}});
val dadizhiren = <flammpfeil.slashblade:proudsoul:4>.withTag({ModelName: "named/terra/terra", CurrentItemName: "flammpfeil.slashblade.named.terra", SummonedSwordColor: 3524113, TextureName: "named/terra/terra"});
val yingjian = <flammpfeil.slashblade:proudsoul:4>.withTag({ench: [{lvl: 4 as short, id: 34 as short}, {lvl: 4 as short, id: 16 as short}], ModelName: "named/bot_roukan/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.roukan_bot", TextureName: "named/bot_roukan/texture",SpecialAttackType:266, IsBewitchedActived: 1 as byte, baseAttackModifier: 16.0 as float});
Altar.addItemCraftRecipe("botania_slashblade", 2.0,
                         yingjian, 
                         ziduandao_Yongzhen,
                         <contenttweaker:first_proudsoul_bottle>,
                         <lastsmith:materials:4>,
                         <sakura:sakura_katana>,
                         <minecraft:vine>
                        );
Altar.addItemCraftRecipe("dadizhiren", 2.0,
                         dadizhiren, 
                         ziduandao_Yongzhen,
                         <contenttweaker:first_proudsoul_bottle>,
                         <lastsmith:materials:3>,
                         <sakura:sakura_diamond>,
                         <minecraft:vine>,
                         <minecraft:vine>
                        );
