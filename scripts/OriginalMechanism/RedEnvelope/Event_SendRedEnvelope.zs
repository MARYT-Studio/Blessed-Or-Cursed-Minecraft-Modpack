#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.event.EntityJoinWorldEvent;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.text.ITextComponent;

// 发红包时刻
static redEnvelopeTimes as long[] = [8000, 10000, 12000];

// 到时间了就发红包
events.onPlayerTick(
    function (event as PlayerTickEvent) {
        if (event.phase == "END") return;
        var player = event.player;
        var world = player.world;
        if (world.remote) return;
        if onTime(world.provider.worldTime) {
            if (world.random.nextBoolean()) {
                player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope_best_wishes.text1"));
            } else {
                player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope_best_wishes.text2"));
            }
            player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope_sent"));
            player.give(<contenttweaker:red_envelope_lubang>);
        }
    }
);

// 工具函数：判断是否到时间
function onTime(worldTime as long) as bool {
    for time in redEnvelopeTimes {
        if (worldTime % 24000 == time) return true;
    }
    return false;
}
