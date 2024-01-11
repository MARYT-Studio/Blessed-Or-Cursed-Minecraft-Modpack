import mods.touhoulittlemaid.Altar;
// Variables claming
val swordZephyr = <thaumcraft:elemental_sword>.withTag({infench: [{lvl: 2 as short, id: 5 as short}]});
// Four Thaumic High-level Blades
val yaosai_shenmi = <lastsmith:.slashblade.named>.withTag({TextureName: "named/thaum/texture_thaumium_update", SlashBlade: {}, ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fortress.thaumium.update", CustomMaxDamage: 600, IsBewitchedActived: 1 as byte, AttackAmplifier: -9.0 as float, baseAttackModifier: 11.0 as float, "SB.SEffect": {}});
val yaosai_fenglei = <lastsmith:slashblade_wind>.withTag({TextureName: "named/thaum/texture_elemental_update", SlashBlade: {}, ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fortress.elemental.update", CustomMaxDamage: 1500, IsBewitchedActived: 1 as byte, AttackAmplifier: -8.0 as float, baseAttackModifier: 10.0 as float, "SB.SEffect": {}});
val yaosai_xuwu = <lastsmith:slashblade_void>.withTag({TextureName: "named/thaum/texture_voidmetal_update", SlashBlade: {}, ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fortress.void.update", CustomMaxDamage: 120, IsBewitchedActived: 1 as byte, AttackAmplifier: -7.0 as float, baseAttackModifier: 9.0 as float, "SB.SEffect": {}});
val yaosai_xuehong = <lastsmith:slashblade_crimson>.withTag({TextureName: "named/thaum/texture_crimson_update", SlashBlade: {}, ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fortress.crimson.update", CustomMaxDamage: 300, IsBewitchedActived: 1 as byte, AttackAmplifier: -10.0 as float, baseAttackModifier: 12.0 as float, "SB.SEffect": {}});

val shenmi = <lastsmith:.slashblade.named>.withTag({TextureName: "named/thaum/texture_thaumium", SlashBlade: {}, ModelName: "named/smith/model", CurrentItemName: "flammpfeil.slashblade.named.fortress.thaumium", CustomMaxDamage: 400, IsFakeBlade: 1 as byte, AttackAmplifier: -8.0 as float, baseAttackModifier: 10.0 as float, "SB.SEffect": {}});
val fenglei = <lastsmith:slashblade_wind>.withTag({TextureName: "named/thaum/texture_elemental", SlashBlade: {}, ModelName: "named/smith/model", CurrentItemName: "flammpfeil.slashblade.named.fortress.elemental", CustomMaxDamage: 1200, IsFakeBlade: 1 as byte, AttackAmplifier: -7.0 as float, baseAttackModifier: 9.0 as float, "SB.SEffect": {}});
val xuwu = <lastsmith:slashblade_void>.withTag({TextureName: "named/thaum/texture_voidmetal", SlashBlade: {}, ModelName: "named/smith/model", CurrentItemName: "flammpfeil.slashblade.named.fortress.void", CustomMaxDamage: 50, IsFakeBlade: 1 as byte, AttackAmplifier: -5.0 as float, baseAttackModifier: 7.0 as float, "SB.SEffect": {}});
val xuehong = <lastsmith:slashblade_crimson>.withTag({TextureName: "named/thaum/texture_crimson", SlashBlade: {}, ModelName: "named/smith/model", CurrentItemName: "flammpfeil.slashblade.named.fortress.crimson", CustomMaxDamage: 120, IsFakeBlade: 1 as byte, AttackAmplifier: -7.0 as float, baseAttackModifier: 9.0 as float, "SB.SEffect": {}});

val longtaidao = <lastsmith:slashblade_wind>.withTag({infench: [{lvl: 3 as short, id: 5 as short}], ModelName: "zephyr/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.windeater", TextureName: "zephyr/tex"});

// Materials part
Altar.addItemCraftRecipe("thaum_ingot", 0.5,
                         <thaumcraft:ingot>, // Thaum Ingot
                         <ore:ingotLead>,
                         <thaumcraft:quicksilver>, 
                         <ore:ingotIron>
                        );
Altar.addItemCraftRecipe("void_ingot", 1.0,
                         <thaumcraft:ingot:1>, // Void Metal Ingot
                         <thaumcraft:ingot>,
                         <thaumcraft:amber>, 
                         <ore:ingotSteel>,
                         <minecraft:ender_eye>
                        );
Altar.addItemCraftRecipe("zephyr_sword", 2.0,
                         swordZephyr, // Sword of the Zephyr
                         <thaumcraft:void_sword>,
                         <thaumcraft:metal_void>, 
                         <thaumcraft:amber_block>,
                         <thaumcraft:quicksilver>, 
                         <minecraft:obsidian>,
                         <contenttweaker:first_proudsoul_bottle>
                        );
Altar.addItemCraftRecipe("crimson_sword", 3.5,
                         <thaumcraft:crimson_blade>, // Crimson Sword
                         swordZephyr,
                         <contenttweaker:second_killcount_token>,
                         <lastsmith:materials:4>,
                         <sakura:sakura_diamond>,
                         <minecraft:red_flower> // This flower may be deleted after further testing.
                        );
// Blades part
Altar.addItemCraftRecipe("thaum_slashblade", 1.5,
                         yaosai_shenmi, 
                         shenmi,
                         <contenttweaker:first_killcount_token>,
                         <contenttweaker:first_killcount_token>,
                         <flammpfeil.slashblade:proudsoul:2>,
                         <minecraft:experience_bottle>,
                         <minecraft:golden_apple>
                        );
Altar.addItemCraftRecipe("void_slashblade", 1.5,
                         yaosai_xuwu, 
                         xuwu,
                         <contenttweaker:first_killcount_token>,
                         <contenttweaker:first_killcount_token>,
                         <flammpfeil.slashblade:proudsoul:2>,
                         <minecraft:experience_bottle>,
                         <minecraft:golden_apple>
                        );
Altar.addItemCraftRecipe("zephyr_slashblade", 1.5,
                         yaosai_fenglei, 
                         fenglei,
                         <contenttweaker:first_killcount_token>,
                         <contenttweaker:first_killcount_token>,
                         <flammpfeil.slashblade:proudsoul:2>,
                         <minecraft:experience_bottle>,
                         <minecraft:golden_apple>
                        );
Altar.addItemCraftRecipe("crimson_slashblade", 1.5,
                         yaosai_xuehong, 
                         xuehong,
                         <contenttweaker:first_killcount_token>,
                         <contenttweaker:first_killcount_token>,
                         <flammpfeil.slashblade:proudsoul:2>,
                         <minecraft:experience_bottle>,
                         <minecraft:golden_apple>
                        );

Altar.addItemCraftRecipe("longtaidao", 1.5,
                         longtaidao, 
                         <thaumcraft:elemental_sword>.withTag({infench: [{lvl: 2 as short, id: 5 as short}]}),
                         <lastsmith:materials:3>,
                         <lastsmith:materials:3>,
                         <sakura:sakura_diamond>,
                         <thaumcraft:ingot:1>,
                         <thaumcraft:ingot:1>
                        );