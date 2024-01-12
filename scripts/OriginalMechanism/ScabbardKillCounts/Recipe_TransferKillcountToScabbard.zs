import crafttweaker.data.IData;

val qiao = <flammpfeil.slashblade:slashbladewrapper>;
val changxing = <lastsmith:.slashblade.named:*>.withTag({ModelName: "custom/soulservant/model", CurrentItemName: "custom_soulservant", TextureName: "custom/soulservant/texture", baseAttackModifier: 6.0 as float});
val hammer = <sakura:stone_hammer:*> | <sakura:iron_hammer:*> | <sakura:sakura_hammer:*>;

recipes.addShapeless("transfer_killcount", changxing, [
    qiao.transformNew (
        function(item) {
            var tag as IData = item.tag;
            if (isNull(tag)) return item;
            var dTag = D(tag);
            return item.updateTag({killCount : (100 + dTag.getInt("killCount"))});            
        }
    ),
    hammer.transformDamage(1),
    changxing.marked("changxing")            
], function(out,ins,info) {
    var tag = ins.changxing.tag;
    if (isNull(tag)) return null;
    var dTag = D(tag);
    if (dTag.getBool("IsBewitchedActived")) return null;
    var killCount = dTag.getInt("killCount");
    var customMaxDamage = dTag.getInt("CustomMaxDamage");
    customMaxDamage = (customMaxDamage >= 123) ? customMaxDamage : customMaxDamage + 1;
    if (killCount < 100) return null;
    return out.withDamage(0).withTag(ins.changxing.tag + {ModelName: "custom/soulservant/model", CurrentItemName: "custom_soulservant", TextureName: "custom/soulservant/texture", baseAttackModifier: 6.0 as float} + {"killCount": (killCount - 100), "CustomMaxDamage": customMaxDamage});
}, null);