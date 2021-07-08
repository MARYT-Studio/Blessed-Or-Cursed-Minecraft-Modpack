import mods.touhoulittlemaid.Altar;
val anya = <lastsmith:.slashblade.named>.withTag({ModelName: "named/darkraven/darkraven", CurrentItemName: "flammpfeil.slashblade.named.darkraven", TextureName: "named/darkraven/darkraven", SpecialAttackType: 2, });
val ziduandao_Yongzhen = <lastsmith:.slashblade.named>.withTag({TextureName: "named/namedblade/texture_nagasada", ModelName: "named/namedblade/model_stright", CurrentItemName: "flammpfeil.slashblade.named.nagasada", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float, "SB.SEffect": {}});
Altar.addItemCraftRecipe("twilight_anya", 2.0,
                         anya, 
                         ziduandao_Yongzhen,
                         <minecraft:skull:1>,
                         <minecraft:skull:1>,
                         <dcs_climate:dcs_cont_misc:4>,
                         <lastsmith:materials:3>
                        );