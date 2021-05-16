import mods.initialinventory.InvHandler;

// Newbie Manual
// game.setLocalization("zh_cn", "item.akashictome:tome.name", "MARYT冬季生存指南");
// game.setLocalization("zh_cn", "akashictome.sudo_name", "MARYT冬季生存指南(%s)");
// val AkashicTome = <patchouli:guide_book>.withTag({"akashictome:displayName": "MARYT冬季生存指南", "akashictome:definedMod": "patchouli", "akashictome:is_morphing": 1 as byte, "patchouli:book": "patchouli:maryt_qanda", "akashictome:data": {mysticalworld: {id: "patchouli:guide_book", Count: 1 as byte, tag: {"akashictome:definedMod": "mysticalworld", "patchouli:book": "mysticalworld:world_guide"}, Damage: 0 as short}, cuisine: {id: "cuisine:manual", Count: 1 as byte, tag: {"akashictome:definedMod": "cuisine"}, Damage: 0 as short}, embers: {id: "embers:codex", Count: 1 as byte, tag: {"akashictome:definedMod": "embers"}, Damage: 0 as short}, forestry: {id: "forestry:book_forester", Count: 1 as byte, tag: {"akashictome:displayName": "林务员手册", "akashictome:definedMod": "forestry", "akashictome:is_morphing": 1 as byte, display: {Name: "阿卡什宝典（林务员手册）"}}, Damage: 0 as short}}});
// InvHandler.addStartingItem(AkashicTome);
// recipes.remove(<akashictome:tome>);
// recipes.addShapeless(AkashicTome,
// [
//     <ore:dirt>,<ore:dirt>,<ore:dirt>,<ore:dirt>
// ]
// );

var GiftSword = <minecraft:diamond_sword>.withDamage(1429).withTag({display: {Name: game.localize("item.crafttweaker.newbiesword.name")}});
var GiftAxe = <minecraft:diamond_axe>.withDamage(1429).withTag({display: {Name: game.localize("item.crafttweaker.newbieaxe.name")}});
val GiftBread = <minecraft:bread>.withTag({display: {Name: game.localize("item.crafttweaker.newbiebread.name")}});

InvHandler.addStartingItem(GiftSword);
InvHandler.addStartingItem(GiftAxe);
InvHandler.addStartingItem(GiftBread*32);