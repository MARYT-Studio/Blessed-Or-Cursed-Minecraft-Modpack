#loader contenttweaker
 
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.IPotion;
import mods.contenttweaker.Player;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;

val effectDuration = 20 * 20;
 
var potion as IPotion = VanillaFactory.createPotion("tengus_scorn", 0x3E0952);
potion.shouldRender = true;
potion.shouldRenderHUD = true;
potion.badEffectIn = false;

potion.isReady = function(duration, amplifier) {return (duration >= effectDuration - 1);};
potion.performEffect = function(living, amplifier) {
    if !(living instanceof IPlayer) return;
    var player as IPlayer = living;
    var level = amplifier + 1;
    if (level > 1) {
        player.addPotionEffect(<potion:contenttweaker:tengus_scorn>.makePotionEffect(effectDuration, (Math.ceil(level / 2) - 1)));
    }
};

potion.register();
