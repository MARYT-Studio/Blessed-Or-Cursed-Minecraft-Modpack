#loader contenttweaker
 
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.IPotion;
import crafttweaker.player.IPlayer;

// 名称暂定
var saverEffectFirst as IPotion = VanillaFactory.createPotion("struggle_in_danger", 0xA21919);
saverEffectFirst.shouldRender = true;
saverEffectFirst.shouldRenderHUD = true;
saverEffectFirst.beneficial = true;
saverEffectFirst.badEffectIn = false;

saverEffectFirst.isReady = function(duration, amplifier) {return false;};
saverEffectFirst.performEffect = function(living, amplifier) {};

saverEffectFirst.register();

var saverEffectSecond as IPotion = VanillaFactory.createPotion("struggle_in_desperate", 0xD80606);
saverEffectSecond.shouldRender = true;
saverEffectSecond.shouldRenderHUD = true;
saverEffectSecond.beneficial = true;
saverEffectSecond.badEffectIn = false;

saverEffectSecond.isReady = function(duration, amplifier) {return false;};
saverEffectSecond.performEffect = function(living, amplifier) {};

saverEffectSecond.register();
