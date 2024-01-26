val proudsoul = <flammpfeil.slashblade:proudsoul> |
<flammpfeil.slashblade:proudsoul:1> |
<flammpfeil.slashblade:proudsoul:2> |
<flammpfeil.slashblade:proudsoul:3>;

// 执行功能的真配方
recipes.addHiddenShaped("soul_devourer_bl_realrecipe", <lastsmith:.slashblade.named>, [
    [<ore:bone>, <minecraft:rotten_flesh>, <lastsmith:blade>],
    [<minecraft:rotten_flesh>, proudsoul, <minecraft:rotten_flesh>],
    [<ore:stickWood>, <minecraft:rotten_flesh>, <ore:bone>]
], function(out,ins,info) {
    return out.withTag({ModelName: "custom/soulservant/model", CurrentItemName: "custom_soulservant", TextureName: "custom/soulservant/texture", baseAttackModifier: 6.0 as float, CustomMaxDamage: 23});
}, null);

// 用来看的假配方
recipes.addShaped("soul_devourer_bl", <lastsmith:.slashblade.named>.withTag({ModelName: "custom/soulservant/model", CurrentItemName: "custom_soulservant", TextureName: "custom/soulservant/texture", baseAttackModifier: 6.0 as float, CustomMaxDamage: 23}), [
    [<ore:bone>, <minecraft:rotten_flesh>, <lastsmith:blade>],
    [<minecraft:rotten_flesh>, proudsoul, <minecraft:rotten_flesh>],
    [<ore:stickWood>, <minecraft:rotten_flesh>, <ore:bone>]
], function(out,ins,info) {
    return null;
}, null);