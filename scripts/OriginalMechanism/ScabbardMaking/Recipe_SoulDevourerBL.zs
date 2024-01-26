val petal = <lastsmith:materials:3>;
val proudsoul = <flammpfeil.slashblade:proudsoul> |
<flammpfeil.slashblade:proudsoul:1> |
<flammpfeil.slashblade:proudsoul:2> |
<flammpfeil.slashblade:proudsoul:3>;
val yinzhi_zhuguang = <flammpfeil.slashblade:slashbladesilverbamboolight>;

// 用来执行功能的真配方
recipes.addHiddenShaped("soul_devourer_bl_realrecipe", <lastsmith:.slashblade.named>, [
    [null, petal, null],
    [petal, proudsoul, petal],
    [yinzhi_zhuguang.marked("blade"), petal, null]
], function(out,ins,info) {
    return out.withTag(ins.blade.tag + {TextureName: "custom/souldevourerbamboolight/texture", ModelName: "custom/souldevourerbamboolight/model", CurrentItemName: "custom_souldevourerbamboolight", ench: [{lvl: 1, id: 48}, {lvl: 1, id: 34}, {lvl: 1, id: 16}], CustomMaxDamage: 35, RepairCounter: 4 as int, baseAttackModifier: 2.0 as float});
}, null);

// 用来看的假配方
recipes.addShaped("soul_devourer_bl", <lastsmith:.slashblade.named>.withTag({TextureName: "custom/souldevourerbamboolight/texture", ModelName: "custom/souldevourerbamboolight/model", CurrentItemName: "custom_souldevourerbamboolight", ench: [{lvl: 1, id: 48}, {lvl: 1, id: 34}, {lvl: 1, id: 16}], CustomMaxDamage: 35, RepairCounter: 4 as int, baseAttackModifier: 2.0 as float}), [
    [null, petal, null],
    [petal, proudsoul, petal],
    [yinzhi_zhuguang.marked("blade"), petal, null]
], function(out,ins,info) {
    return null;
}, null);
