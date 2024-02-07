#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.server.IServer;
import mods.zenutils.EventPriority;

// 测试的结果：
// 拔刀剑的平砍伤害可能是 player 或 mob 二者之一
// 幻影剑伤害很有可能是 directMagic

val enabled = false;

if (enabled) {
    events.register(
        function(event as EntityLivingDamageEvent) {
            var source = event.damageSource;
            if (isNull(source.trueSource)) {
                print(1);
                return;
            }
            if (!(source.trueSource instanceof IPlayer)) {
                print(2);
                return;
            }
            var player as IPlayer= source.trueSource;
            if (player.world.remote) {
                print(3);
                return;
            }
            player.sendChat(source.damageType);
            if (!(event.entityLivingBase instanceof IPlayer)) {
                player.sendChat(event.entityLivingBase.definition.id);
            }
        }, EventPriority.highest()
    );
}
