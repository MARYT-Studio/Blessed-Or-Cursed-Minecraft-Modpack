#loader crafttweaker reloadable
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.item.IItemStack;

val enabled = false;

if (enabled) {
    events.onPlayerRightClickItem(
        function(event as PlayerRightClickItemEvent) {
            var dTag = D(event.item.tag);
            if (!event.player.world.remote) {
                event.player.sendChat("\u5DF2\u8BBE\u7F6E\u4E0A\u9650\uFF1A" ~ dTag.check("RefineLimit") ~ "\uFF0C\u4E0A\u9650\u503C\uFF1A" ~ dTag.getInt("RefineLimit", -1));
                event.player.sendChat("\u5F53\u524D\u7EF4\u5EA6\uFF1ADIM" ~ event.player.world.dimension ~ "\uFF0C\u62D4\u5200\u5251\u5728\u6B64\u7EF4\u5EA6\u6240\u83B7\u953B\u5200\u4E0A\u9650\u5956\u52B1\uFF1A" ~ dTag.getInt("RefineLimitGained.DIM" ~ event.player.world.dimension, -1));
                event.player.sendChat("\u00A7o-1 \u8868\u793A\u672A\u83B7\u53D6\u8FC7\uFF0CNull");
            }
        }
    );
}
