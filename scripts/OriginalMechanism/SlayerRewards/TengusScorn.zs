#loader contenttweaker
 
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.IPotion;
import mods.contenttweaker.Player;
 
var potion as IPotion = VanillaFactory.createPotion("tengus_scorn", 0x3E0952);
potion.shouldRender = true;
potion.shouldRenderHUD = true;
potion.badEffectIn = false;

potion.isReady = function(duration, amplifier) {return false;};
potion.performEffect = function(living, amplifier) {};

potion.register();
