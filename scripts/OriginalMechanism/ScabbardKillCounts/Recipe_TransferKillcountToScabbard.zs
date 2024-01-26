import crafttweaker.data.IData;

val qiao = <flammpfeil.slashblade:slashbladewrapper>;
val changxing = <lastsmith:.slashblade.named>.withTag({ModelName: "custom/soulservant/model", CurrentItemName: "custom_soulservant", TextureName: "custom/soulservant/texture", baseAttackModifier: 6.0 as float});
val hammer = <sakura:stone_hammer:*> | <sakura:iron_hammer:*> | <sakura:sakura_hammer:*>;

// 执行功能的真配方
recipes.addHiddenShapeless("transfer_killcount_realrecipe", <lastsmith:.slashblade.named>, [
    qiao.transformNew (
        function(item) {
            var tag as IData = item.tag;
            if (isNull(tag)) return item;
            var dTag = D(tag);
            return item.updateTag({killCount : (100 + dTag.getInt("killCount"))});            
        }
    ),
    hammer.transformDamage(1),
    <lastsmith:.slashblade.named>.marked("changxing")            
], function(out,ins,info) {
    if (isNull(ins.changxing.tag)) return null;    
    var dTag = D(ins.changxing.tag);
    if (dTag.getString("CurrentItemName", "") != "custom_soulservant") return null;
    if (dTag.getBool("IsBewitchedActived")) return null;
    var killCount = dTag.getInt("killCount");
    var customMaxDamage = dTag.getInt("CustomMaxDamage");
    customMaxDamage = (customMaxDamage >= 123) ? customMaxDamage : customMaxDamage + 1;
    if (killCount < 100) return null;
    return out.withTag(ins.changxing.tag + {ModelName: "custom/soulservant/model", CurrentItemName: "custom_soulservant", TextureName: "custom/soulservant/texture", baseAttackModifier: 6.0 as float} + {"killCount": (killCount - 100), "CustomMaxDamage": customMaxDamage});
}, null);

// 用来看的假配方
recipes.addShapeless("transfer_killcount", changxing, [
    qiao.transformNew (
        function(item) {
            var tag as IData = item.tag;
            if (isNull(tag)) return item;
            var dTag = D(tag);
            return item.updateTag({killCount : (100 + dTag.getInt("killCount"))});            
        }
    ),
    hammer,
    changxing
], function(out,ins,info) {
    return null;
}, null);