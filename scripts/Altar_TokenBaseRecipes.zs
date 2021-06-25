// Packages importing
import mods.touhoulittlemaid.Altar;
// Variables claiming
val mengGangBan = <dcs_climate:dcs_rotaryblade:3>;
val qishiJinshuDing = <twilightforest:knightmetal_ingot>;
val hunYingGangDing = <lastsmith:materials:5>;
val gongjuGangDing = <dcs_climate:dcs_ingot:17>;
val fumoZhiPing = <minecraft:experience_bottle>;
val shenQianTieKuai = <twilightforest:block_storage:4>;

Altar.addItemCraftRecipe("third_killcount_token_base", 5.0,
                         <contenttweaker:third_killcount_token_base>,
                         qishiJinshuDing,
                         hunYingGangDing,
                         gongjuGangDing,
                         mengGangBan
                        );
Altar.addItemCraftRecipe("fourth_killcount_token_base", 5.0,
                         <contenttweaker:fourth_killcount_token_base>,
                         <contenttweaker:third_killcount_token_base>,
                         shenQianTieKuai,
                         mengGangBan
                        );
Altar.addItemCraftRecipe("third_proudsoul_bottle_base", 5.0,
                         <contenttweaker:third_proudsoul_bottle_base>, 
                         qishiJinshuDing,
                         hunYingGangDing,
                         gongjuGangDing,
                         mengGangBan,
                         shenQianTieKuai,
                         fumoZhiPing
                        );