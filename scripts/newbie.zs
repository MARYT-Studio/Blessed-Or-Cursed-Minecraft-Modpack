import mods.initialinventory.InvHandler;
import crafttweaker.data.IData;

var GiftSword = <minecraft:diamond_sword>.withDamage(1429).withTag({newbie: 1});
var GiftAxe = <minecraft:diamond_axe>.withDamage(1429).withTag({newbie: 1});
val GiftBread = <minecraft:bread>.withTag({newbie: 1});
val GiftHammer = <sakura:stone_hammer>.withTag({newbie: 1});

InvHandler.addStartingItem(GiftSword);
InvHandler.addStartingItem(GiftAxe);
InvHandler.addStartingItem(GiftBread * 32);
InvHandler.addStartingItem(GiftHammer);