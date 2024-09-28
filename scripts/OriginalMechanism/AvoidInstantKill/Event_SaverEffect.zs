#loader crafttweaker reloadable
// Packages for needed ZenClasses
import crafttweaker.player.IPlayer;

// Packages for CraftTweaker Events
import crafttweaker.event.EntityLivingHurtEvent;

import crafttweaker.event.PlayerRightClickItemEvent;

import mods.zenutils.EventPriority;

val debug = false;

// 每秒 tick 数，常量
static seconds as long = 20L;

// 难度数组
static DIFFICULTIES as string[] = ["EASY", "NORMAL", "HARD"];

// 配置选项
// 以下数值均根据难度数组的顺序排序

// 第一层效果
// 触发效果的最低血量门槛
static FIRST_EFFECT_THRESHOLD as float[] = [0.4f, 0.5f, 0.6f];
// 触发效果后保留的血量点数
static SAVED_HEALTH_POINTS as float[] = [1.0f, 2.0f, 3.0f];
// 触发效果后给予无敌的秒数，数字为秒数，乘以单位 seconds (20) 即换算成 tick 数
// 无敌时间内会给予等长的速度 buff
static INVULNERABLE_SECONDS as long[] = [3 * seconds, 2 * seconds, 2 * seconds];
// 速度 Buff 的等级，0 代表一级，1 代表二级，以此类推
static SPEED_LEVEL as int = 1;
// 给予伤害吸收 Buff 的时间
static ABSORPTION_SECONDS as long[] = [5 * seconds, 5 * seconds, 5 * seconds];
// 冷却用时，冷却条件为脱战
static FIRST_EFFECT_COOLDOWN as long = 120L * seconds;



// 事件部分
events.register(
    function (event as EntityLivingHurtEvent) {
        // 如果伤害事件已经被处理，则避免进入此事件
        if (event.isCanceled()) return;
        
        var entityLiving = event.entityLivingBase;
        if (entityLiving instanceof IPlayer) {
            var player as IPlayer = entityLiving;
            var world = player.world;
            if (world.remote) return;                         
            
            // 若玩家受到致命伤害
            if (event.amount > player.health) {
                
                // 执行第一层 Buff
                // 按照难度取对应数值
                var difficulty as string = world.worldInfo.difficulty;
                var savedHealth as float = getSavedHealthPoints(difficulty);
                var invulnerableSecs as long = getInvulnerableSecs(difficulty);
                var absorptionSecs as long = getAbsorptionSecs(difficulty);

                player.health = savedHealth;
                
            }
        }
    },EventPriority.lowest(), true
);

// 工具函数
function getSavedHealthPoints(difficulty as string) as float {
    for i, value in DIFFICULTIES {
        if (value.equalsIgnoreCase(difficulty)) {
            return SAVED_HEALTH_POINTS[i];
        }
    }
}

function getInvulnerableSecs(difficulty as string) as long {
    for i, value in DIFFICULTIES {
        if (value.equalsIgnoreCase(difficulty)) {
            return INVULNERABLE_SECONDS[i];
        }
    }
}

function getAbsorptionSecs(difficulty as string) as long {
    for i, value in DIFFICULTIES {
        if (value.equalsIgnoreCase(difficulty)) {
            return ABSORPTION_SECONDS[i];
        }
    }
}

function applyFirstEffects(player as IPlayer, invulnerableSecs as long, absorptionSecs as long) {
    val firstEffect = <potion:contenttweaker:struggle_in_danger>.makePotionEffect(invulnerableSecs, 0);
    val speedEffect = <potion:minecraft:speed>.makePotionEffect(invulnerableSecs, SPEED_LEVEL);
    val absorptionEffect = <potion:minecraft:absorption>.makePotionEffect(absorptionEffect, 0);
}
