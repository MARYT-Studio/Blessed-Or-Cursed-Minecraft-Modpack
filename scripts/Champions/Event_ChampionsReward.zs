#loader crafttweaker reloadable
import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityLivingDeathDropsEvent;

import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLivingBase;

import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.world.IWorld;

import crafttweaker.potions.IPotionEffect;

val proudSoulItems as IItemStack[float] = {
    0.05f: <flammpfeil.slashblade:proudsoul:2>,  // Proudsoul Sphere
    0.1f: <flammpfeil.slashblade:proudsoul:1>, // Proudsoul Ingot
    0.2f: <flammpfeil.slashblade:proudsoul>,   // Proudsoul
    0.65f: <flammpfeil.slashblade:proudsoul:3> // Tiny Proudsoul
};
 
val buffProbability as float = 0.5f;
val longBuffProbability as float = 0.3f;

// val weakAbsorption as IPotionEffect = <potion:dcs_climate:dcs.potion.absorption_exp>.makePotionEffect(300, 0);
// val strongAbsorption as IPotionEffect = <potion:dcs_climate:dcs.potion.absorption_exp>.makePotionEffect(300, 1);
// val longAbsorption as IPotionEffect = <potion:dcs_climate:dcs.potion.absorption_exp>.makePotionEffect(600, 1);

events.onEntityLivingDeathDrops(
    function(event as EntityLivingDeathDropsEvent) {
        var target as IEntityLivingBase = event.entityLivingBase;
        var world as IWorld = target.world;
        var random = world.random;
        if (!world.remote) {
            var source = event.damageSource.trueSource;
            if(source instanceof IPlayer) {
                var player as IPlayer = source;
                var data as IData = target.nbt;
                if (!isNull(data) && !isNull(data.ForgeCaps)) {
                    var championInfo as IData = data.ForgeCaps.memberGet("champions:championship");
                    if (!isNull(championInfo)) {
                        var tier as int = championInfo.memberGet("tier").asInt();
                        if (tier != 0) {
                            // Reward Exp absorption buff
                            // if (tier == 1) {
                            //     if (random.nextFloat() < buffProbability) {
                            //         player.addPotionEffect(weakAbsorption);   
                            //     }
                            // } else if (tier == 2) {
                            //     player.addPotionEffect(strongAbsorption);
                            // } else if (tier == 3) {
                            //     if (random.nextFloat() < longBuffProbability) {
                            //         player.addPotionEffect(longAbsorption);
                            //     } else {
                            //         player.addPotionEffect(strongAbsorption);
                            //     }
                            // }
                            // Reward proud soul items
                            for itemEntity in event.drops {
                            var item = itemEntity.item;
                            if (<minecraft:enchanted_book> has item) {
                                if (!isNull(item.tag)) {
                                    var bookEnchant as IData = item.tag.memberGet("StoredEnchantments");
                                        if (!isNull(bookEnchant)) {
                                            var enchantForProudsoul as IData = {ench: bookEnchant};
                                            var roll as float = random.nextFloat();
                                            for prob, item in proudSoulItems {
                                                if (roll < prob) {
                                                    event.addItem(proudSoulItems[prob].withTag(enchantForProudsoul));
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }   
                        }
                    }
                }
            }
        }
    }
);
