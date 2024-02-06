#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.event.EntityJoinWorldEvent;
import crafttweaker.event.PlayerTickEvent;
import mods.zenutils.EventPriority;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Position3f;
import crafttweaker.text.ITextComponent;

val debug = true;

events.onEntityJoinWorld(
    function (event as EntityJoinWorldEvent) {
        if (event.entity instanceof IPlayer) return;
        var entity = event.entity;
        if (!(entity.definition.id.toLowerCase().contains("creeper"))) return;
        if (isNull(entity.nbt)) return;
        var dTag = D(entity.nbt);
        // 启动 Catenation 时要检查是否已经启动过，否则会启动两个 Catenation 导致不想要的结果
        if (dTag.check("ForgeData.RedEnvelope") && !dTag.check("ForgeData.GameStarted")) {
            var world = event.world;
            if (!world.remote) {
                mods.zenutils.CatenationPersistence.startPersistedCatenation("RedEnvelopeOpening", world)
                .withEntity(entity)
                .start();
            }
        }
    }
);

// 屏蔽和统计靶子受到的伤害
events.register(
    function(event as EntityLivingDamageEvent) {
        if (event.entityLivingBase instanceof IPlayer) return;
        var entity = event.entityLivingBase;
        if (!(entity.definition.id.toLowerCase().contains("creeper"))) return;
        if (isNull(entity.nbt)) return;
        var dTag = D(entity.nbt);
        if (dTag.check("ForgeData.RedEnvelope")) {
            if (!isNull(event.damageSource.trueSource) && event.damageSource.trueSource instanceof IPlayer) {
                var player as IPlayer = event.damageSource.trueSource;
                // 只有召唤者的攻击有效
                if (dTag.getString("ForgeData.SummonerUUID", "") != player.uuid) {
                    player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope.summoner_warning"));
                    event.cancel();
                    return;
                }                
                // 玩家风格评分的获取
                if (!isNull(player.data)) {
                    var playerTag = D(player.data);
                    if (playerTag.check("SBRankPoint")) {
                        // 临时的播报，也作为调试信息
                        var score = playerTag.getInt("SBRankPoint");
                        if (debug) player.sendChat("本次攻击评分：" ~ score);
                        // 累计分数
                        var world = player.world;
                        var worldDataTag = D(world.getCustomWorldData());
                        if (worldDataTag.check("RedEnvelopeStat")) {
                            world.updateCustomWorldData({RedEnvelopeStat: {player.uuid: worldDataTag.getInt("RedEnvelopeStat." ~ player.uuid) + score}});   
                        }
                    }
                }
            }
            // 靶子的消失由 Catenation 唯一控制，否则游戏会崩溃
            event.cancel();
        }
    }, EventPriority.highest()
);

// 检测玩家脚沾地的状态；游戏结束后报分，将游戏置于完成状态 0
events.onPlayerTick(
    function (event as PlayerTickEvent) {
        var player = event.player;
        var world = player.world;
        world.updateCustomWorldData({RedEnvelopePlayerOnGround: {event.player.uuid: event.player.onGround()}});
        // 报分和游戏状态置 0
        var worldDataTag = D(world.getCustomWorldData());
        if (worldDataTag.getInt("RedEnvelopeGameStatus." ~ player.uuid) == 3 && worldDataTag.getInt("RedEnvelopeStat." ~ player.uuid) != 0) {
            // TODO: 需要替换成 ITextComponent
            player.sendChat("本次游戏总分：" ~ worldDataTag.getInt("RedEnvelopeStat." ~ player.uuid));
            world.updateCustomWorldData({RedEnvelopeStat: {player.uuid: 0}});   
        }
    }
);

// Catenation: 启动后倒计时三秒
mods.zenutils.CatenationPersistence.registerPersistedCatenation("RedEnvelopeOpening")
    .setCatenationFactory(function(world) {
        return world.catenation()
            .run(function(world, context) {
                context.getEntity().update({GameStarted: 1});
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("3"));
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("2"));
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("1"));
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("GO"));
                // 游戏开始状态，记为 1
                if (!isNull(context.getEntity().nbt)) {
                    var dTag = D(context.getEntity().nbt);
                    if (dTag.check("ForgeData.SummonerUUID")) {
                        world.updateCustomWorldData({RedEnvelopeGameStatus: {dTag.getString("ForgeData.SummonerUUID"): 1}});
                    }
                }
                context.getEntity().updateNBT({Invulnerable: 0, powered: 0});
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.9 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.8 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.7 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.6 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.5 * living.maxHealth;
                    broadcastNear(living, ITextComponent.fromString("Half!"));
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.4 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    broadcastNear(living, ITextComponent.fromString("Three!"));
                    living.health = 0.3 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    broadcastNear(living, ITextComponent.fromString("Two!"));
                    living.health = 0.2 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    broadcastNear(living, ITextComponent.fromString("One!"));
                    living.health = 0.1 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                context.getEntity().update({ShouldDie: 1});
            })
            .stopWhen(function(world, context) {
                // 判断异常状态。一旦这些异常发生，终止 Catenation
                // Catenation 中的实体没有 ForgeData 标签
                if (isNull(context.getEntity().nbt) || isNull(context.getEntity().nbt.ForgeData)) return true;
                // 标签中没有红包靶子的信息
                var forgeDataTag = D(context.getEntity().nbt.ForgeData);
                if (!(forgeDataTag.check("SummonerUUID"))) return true;

                // 以下是正常状态
                var summonerUUID as string = forgeDataTag.getString("SummonerUUID");
                var worldDataTag = D(world.getCustomWorldData());
                var gameStop as bool = worldDataTag.getBool("RedEnvelopePlayerOnGround." ~ summonerUUID) && (worldDataTag.getInt("RedEnvelopeGameStatus." ~ summonerUUID) == 1);
                return gameStop || !isNull(context.getEntity().nbt.ForgeData.ShouldDie);
            })
            .onStop(function(world, context) {
                // 游戏刚刚结束，等待报分的状态，记为 3
                if (!isNull(context.getEntity().nbt)) {
                    var dTag = D(context.getEntity().nbt);
                    if (dTag.check("ForgeData.SummonerUUID")) {
                        world.updateCustomWorldData({RedEnvelopeGameStatus: {dTag.getString("ForgeData.SummonerUUID"): 3}});
                    }
                }
                // /particle fireworksSpark ~ ~ ~ 3 3 3 0.1 1200 normal
                server.commandManager.executeCommand(server, "particle fireworksSpark ~"~ context.getEntity().position.x ~" ~" ~ context.getEntity().position.y ~ " ~" ~ context.getEntity().position.z ~ " 3 3 3 0.1 1200 normal");
                broadcastNear(context.getEntity(), ITextComponent.fromTranslation("contenttweaker.red_envelope_game_over"));
                broadcastNear(context.getEntity(), ITextComponent.fromTranslation("contenttweaker.red_envelope_best_wishes.text1"));
                broadcastNear(context.getEntity(), ITextComponent.fromTranslation("contenttweaker.red_envelope_best_wishes.text2"));
                context.getEntity().setDead();
            })
            .start();
    })
    .addEntityHolder()
    .register();

// 工具函数：向临近的玩家广播消息
function broadcastNear(target as IEntity, message as ITextComponent) as void {
    var x = target.position3f.x;
    var y = target.position3f.y;
    var z = target.position3f.z;

    // 临近范围的起始点坐标
    var startX = x - 6;
    var startY = y - 1;
    var startZ = z - 6;
    // 临近范围的终止点坐标
    var endX = x + 6;
    var endY = y + 7;
    var endZ = z + 6;
    
    var start = Position3f.create(startX, startY, startZ);
    var end = Position3f.create(endX, endY, endZ);
    for entity in (target.world.getEntitiesInArea(start, end)) {
        if (entity instanceof IPlayer) {
            var player as IPlayer = entity;
            player.sendRichTextMessage(message);
        }
    }
}