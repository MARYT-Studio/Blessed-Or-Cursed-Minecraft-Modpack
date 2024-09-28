#loader contenttweaker
 
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.IPotion;

// 名称暂定
var potion as IPotion = VanillaFactory.createPotion("spirit_of_muramasa", 0xFF9F00);
potion.shouldRender = true;
potion.shouldRenderHUD = true;
potion.beneficial = true;
potion.badEffectIn = false;

potion.isReady = function(duration, amplifier) {return false;};
potion.performEffect = function(living, amplifier) {};

potion.register();
