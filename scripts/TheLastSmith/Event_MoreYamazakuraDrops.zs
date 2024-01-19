#loader crafttweaker reloadable
import crafttweaker.item.IItemStack;
import crafttweaker.event.EntityLivingDeathDropsEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityMob;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.IEntityDefinition;

static shanyingmuyue_Song as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_mutsuki_kadomatsu", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.kadomatsu", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
static shanyingruyue_Mei as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_kisaragi_ume", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.ume", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
static shanyingmisheng_Ying as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_yayoi_sakura", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.sakura", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
static shanying_Maoyue as IItemStack =  <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_uzuki", ModelName: "named/yamazakura/uzuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.uzuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
static shanying_Gaoyue as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_satsuki", ModelName: "named/yamazakura/satsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.satsuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
static shanying_Yeyue as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_hazuki", ModelName: "named/yamazakura/fumizuki_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.hazuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
static shanyingchangyue_Ju as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_nagatsuki_kiku", ModelName: "named/yamazakura/fumizuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.kiku", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
static shanying_Shizou as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_shiwasu", ModelName: "named/yamazakura/shimotsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.shiwasu", IsFakeBlade: 1 as byte, baseAttackModifier: 7.0 as float});
static shanying_Shuangyue as IItemStack = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_shimotsuki", ModelName: "named/yamazakura/shimotsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.shimotsuki", IsFakeBlade: 1 as byte, baseAttackModifier: 7.0 as float});

static yamazakuraBlades as IItemStack[string] = {
    "spider": shanyingmuyue_Song,
    "skeleton": shanyingruyue_Mei,
    "creeper": shanyingmisheng_Ying,
    "ghast": shanying_Maoyue,
    "enderman": shanying_Gaoyue,
    "blaze": shanying_Yeyue,
    "guardian": shanyingchangyue_Ju,
    "vex": shanying_Shizou,
    // 有两种岩浆怪 ID
    "lavaslime": shanying_Shuangyue,
    "magma_cube": shanying_Shuangyue
};

val debug = false;

events.onEntityLivingDeathDrops(
    function(event as EntityLivingDeathDropsEvent) {
        if(!event.entityLivingBase.world.remote) {
            if (event.damageSource.trueSource instanceof IPlayer) {
                var player as IPlayer = event.damageSource.trueSource;
                var entity = event.entityLivingBase;
                var matchResult = yamazakuraDrop(entity);
                if (debug) player.sendChat(matchResult.commandString);
                if (<minecraft:dirt>.matches(matchResult)) return;
                else if (player.world.random.nextFloat() <= 0.05f) event.addItem(matchResult);
            }
        }
    }
);

// 工具函数：根据掉落物品对应表生成掉落物
function yamazakuraDrop(entity as IEntityLivingBase) as IItemStack {
    for key in yamazakuraBlades {
        if (entityTypeMatch(key, entity.definition)) return yamazakuraBlades[key];
    }
    return <minecraft:dirt>;
}

// 工具函数：生物类型匹配
function entityTypeMatch(type as string, definition as IEntityDefinition) as bool {
    return definition.id.toLowerCase().contains(type);
}
