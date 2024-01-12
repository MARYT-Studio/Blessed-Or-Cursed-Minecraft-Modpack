val petal = <lastsmith:materials:3>;
val proudsoul = <flammpfeil.slashblade:proudsoul> |
<flammpfeil.slashblade:proudsoul:1> |
<flammpfeil.slashblade:proudsoul:2> |
<flammpfeil.slashblade:proudsoul:3>;
val yinzhi_zhuguang = <flammpfeil.slashblade:slashbladesilverbamboolight>;

recipes.addShaped("soul_devourer_bl", <lastsmith:.slashblade.named>, [
    [null, petal, null],
    [petal, proudsoul, petal],
    [yinzhi_zhuguang.marked("blade"), petal, null]
], function(out,ins,info) {
    return out.withTag(ins.blade.tag + {TextureName: "custom/souldevourerbamboolight/texture", ModelName: "custom/souldevourerbamboolight/model", CurrentItemName: "custom_souldevourerbamboolight", CustomMaxDamage: 20, RepairCounter: 4 as int, baseAttackModifier: 2.0 as float});
}, null);