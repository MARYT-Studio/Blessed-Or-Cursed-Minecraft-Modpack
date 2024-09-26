#loader crafttweaker reloadable
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;

val potion as IPotion = <potion:contenttweaker:spirit_of_muramasa>;
val effect as IPotionEffect = potion.makePotionEffect(8 * 20, 0);

events.onPlayerTick(
    function (event as PlayerTickEvent) {
        var player = event.player;
        var world = player.world;
        if (world.remote) return;
        if (event.side == "SERVER" && event.phase == "END") {
            if (world.provider.getWorldTime() % 20 == 0) {
                if (player.foodStats.foodLevel <= 6) {
                    if (isNull(player.getActivePotionEffect(potion))) {
                        player.addPotionEffect(<potion:contenttweaker:spirit_of_muramasa>.makePotionEffect(8 * 20, 0));
                    }
                }
            }
        }
    }
);