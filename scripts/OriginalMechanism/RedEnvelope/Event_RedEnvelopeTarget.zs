#loader crafttweaker reloadable
import crafttweaker.event.EntityLivingDamageEvent;
import crafttweaker.event.EntityJoinWorldEvent;
import crafttweaker.event.PlayerTickEvent;
import mods.zenutils.EventPriority;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Position3f;
import mods.contenttweaker.BlockPos;
import crafttweaker.text.ITextComponent;
import crafttweaker.util.Math;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IVector3d;
import mods.zenutils.event.EntityRemoveEvent;
import crafttweaker.entity.IEntityItem;
import crafttweaker.world.IWorld;
import scripts.OriginalMechanism.RedEnvelope.ContentTweaker_Function_RedEnvelope;

static debug as bool = false;

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
        
        // 伤害类型是幻影剑的 Magic 就不算
        if (event.damageSource.damageType.toLowerCase().contains("magic")) return;

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
                // 免费攻击，用完之前脚沾地不会结束游戏
                var freeHit = dTag.getInt("ForgeData.FreeHit");
                if (freeHit > 0) {
                    entity.update({FreeHit: (freeHit - 1)});
                    if (freeHit - 1 > 0) {
                        player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope_freehit", "" ~ (freeHit - 1)));
                    } else {
                        player.sendRichTextMessage(ITextComponent.fromTranslation("contenttweaker.red_envelope_freehit_used"));
                    }
                }
                // 玩家风格评分的获取
                if (!isNull(player.data)) {
                    var playerTag = D(player.data);
                    if (playerTag.check("SBRankPoint")) {
                        var score = playerTag.getInt("SBRankPoint");
                        
                        // 临时的播报，也作为调试信息
                        if (debug) player.sendChat("Rank Point this time: " ~ score);

                        // 抽奖部分
                        
                        if (playerTag.check("RedEnvelopeRewards")) {
                            // 获取苦力怕的颜色
                            var type as int = 0;
                            for index in 0 .. ContentTweaker_Function_RedEnvelope.creeperList.length {
                                if (entity.definition.id == ContentTweaker_Function_RedEnvelope.creeperList[index]) {
                                    type = index;
                                    break;
                                }
                            }
                            player.update({RedEnvelopeRewards: {
                                "type": type,
                                "hitCount": (playerTag.getInt("RedEnvelopeRewards.hitCount") + 1)
                            }});
                            rollReward(player, score);
                        } else {
                            // 获取苦力怕的颜色
                            var type as int = 0;
                            for index in 0 .. ContentTweaker_Function_RedEnvelope.creeperList.length {
                                if (entity.definition.id == ContentTweaker_Function_RedEnvelope.creeperList[index]) {
                                    type = index;
                                    break;
                                }
                            }
                            // 初始化奖池
                            player.update({RedEnvelopeRewards: {
                                "hitCount": 1 as int,
                                "type": type,
                                "smallRate": 0.0f as float,
                                // 大矿石的 roll 采用整数 roll（1-4 <= bigRate）， bigrate == 0 时不出物品
                                "bigRate": 0 as int,
                                "small": 0 as int,
                                "big": 0 as int,
                                // 给予矿石的数量
                                "giveAmount": 1
                            }});
                        }
                        

                        // 累计分数
                        var world = player.world;
                        var worldDataTag = D(world.getCustomWorldData());
                        world.updateCustomWorldData({RedEnvelopeStat: {player.uuid: worldDataTag.getInt("RedEnvelopeStat." ~ player.uuid) + score}});
                    }
                }
            }
            // 靶子的消失由 Catenation 唯一控制，否则游戏会崩溃
            event.cancel();
        }
    }, EventPriority.highest()
);

// 检测玩家脚沾地的状态；游戏结束后报分、发奖励，将游戏置于完成状态 0
events.onPlayerTick(
    function (event as PlayerTickEvent) {
        var player = event.player;
        var world = player.world;
        if (world.remote) return;
        world.updateCustomWorldData({RedEnvelopePlayerOnGround: {event.player.uuid: event.player.onGround()}});
        // 报分和游戏状态置 0
        var worldDataTag = D(world.getCustomWorldData());
        var status = worldDataTag.getInt("RedEnvelopeGameStatus." ~ player.uuid);
        var stat = worldDataTag.getInt("RedEnvelopeStat." ~ player.uuid);
        if (status == 3) {
            player.sendRichTextMessage(
                ITextComponent.fromTranslation("contenttweaker.red_envelope_total_score", "\u00A76\u00A7l" ~ worldDataTag.getInt("RedEnvelopeStat." ~ player.uuid))
            );
            // 拿取靶子苦力怕的位置
            var position = Position3f.create(
                worldDataTag.getFloat("RedEnvelopeTargetPosition." ~ player.uuid ~ ".x"),
                worldDataTag.getFloat("RedEnvelopeTargetPosition." ~ player.uuid ~ ".y"),
                worldDataTag.getFloat("RedEnvelopeTargetPosition." ~ player.uuid ~ ".z")
            );
            sendReward(player, position);
            world.updateCustomWorldData({RedEnvelopeGameStatus: {player.uuid: 0}});
            world.updateCustomWorldData({RedEnvelopeStat: {player.uuid: 0}});
        }
    }
);

// 阻止掉落物结合
events.onEntityRemove(
    function(event as EntityRemoveEvent) {
        if (event.entity instanceof IEntityItem) {
            var entityItem as IEntityItem = event.entity;
            print(entityItem.item.commandString);
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
                broadcastNear(context.getEntity(), ITextComponent.fromString("\u00A76\u00A7l\u2606\u2606\u2606 3!!!"));
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("\u00A76\u00A7l\u2606\u2606 2!!!"));
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("\u00A76\u00A7l\u2606 1!!!"));
            })
            .sleep(20)
            .then(function(world, context) {
                broadcastNear(context.getEntity(), ITextComponent.fromString("\u00A76\u00A7e\u2606\u2606\u2606 GO!!! \u2606\u2606\u2606"));
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
                    broadcastNear(living, ITextComponent.fromString("5!"));
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    living.health = 0.4 * living.maxHealth;
                    broadcastNear(living, ITextComponent.fromString("4!"));
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    broadcastNear(living, ITextComponent.fromString("3!"));
                    living.health = 0.3 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    broadcastNear(living, ITextComponent.fromString("2!"));
                    living.health = 0.2 * living.maxHealth;
                }
                
            })
            .sleep(20)
            .then(function(world, context) {
                if (context.getEntity() instanceof IEntityLivingBase) {
                    var living as IEntityLivingBase = context.getEntity();
                    broadcastNear(living, ITextComponent.fromString("1!"));
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
                if (!(forgeDataTag.check("SummonerUUID")) || !(forgeDataTag.check("FreeHit"))) return true;

                // 以下是正常状态
                var summonerUUID as string = forgeDataTag.getString("SummonerUUID");
                var freeHit as int = forgeDataTag.getInt("FreeHit");
                var worldDataTag = D(world.getCustomWorldData());
                var gameStop as bool = (freeHit == 0) && worldDataTag.getBool("RedEnvelopePlayerOnGround." ~ summonerUUID) && (worldDataTag.getInt("RedEnvelopeGameStatus." ~ summonerUUID) == 1);
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

// 工具函数：抽取随机奖励并写入玩家数据
function rollReward(player as IPlayer, score as int) as void {
    if (isNull(player.data)) return;
    var playerTag = D(player.data);
    if (playerTag.check("RedEnvelopeRewards")) {
        // 根据评分修改爆率
        player.update({RedEnvelopeRewards: {
            "smallRate": (playerTag.getFloat("RedEnvelopeRewards.smallRate") + (pow(
                    score,
                    (1.0f + playerTag.getFloat("RedEnvelopeRewards.hitCount")/100.0f)
                )/30.0f)
            )
        }});
        var smallRate = playerTag.getFloat("RedEnvelopeRewards.smallRate");
        var bigRate = playerTag.getInt("RedEnvelopeRewards.bigRate");
        // 抽取矿石
        if (player.world.random.nextFloat() < smallRate) {
            player.update({RedEnvelopeRewards: {
                "small": (playerTag.getInt("RedEnvelopeRewards.small") + playerTag.getInt("RedEnvelopeRewards.giveAmount")
                )
            }});
        }
        if (player.world.random.nextInt(1, 4) <= bigRate) {
            player.update({RedEnvelopeRewards: {
                "big": (playerTag.getInt("RedEnvelopeRewards.big") + playerTag.getInt("RedEnvelopeRewards.giveAmount")
                )
            }});
        }
        // 后项依赖前项的结算部分
        // 判断小矿石爆率是否达到 90
        if (smallRate >= 0.9f) {
            // 修改大矿石爆率
            player.update({RedEnvelopeRewards: {
                "bigRate": (playerTag.getInt("RedEnvelopeRewards.bigRate") + 1)
            }});
            // 修改小矿石爆率
            player.update({RedEnvelopeRewards: {
                "smallRate": (playerTag.getFloat("RedEnvelopeRewards.smallRate") / 7.0f)
            }});
            // 下一项判断：判断大矿石爆率是否等于100
            bigRate = playerTag.getInt("RedEnvelopeRewards.bigRate");
            if (bigRate == 4) {
                player.update({RedEnvelopeRewards: {
                    "small": Math.round(1.3f * (playerTag.getInt("RedEnvelopeRewards.small") + 5))
                }});
                player.update({RedEnvelopeRewards: {
                    "big": Math.round(1.3f * (playerTag.getInt("RedEnvelopeRewards.big") + 5))
                }});
                player.update({RedEnvelopeRewards: {
                    "bigRate": 0
                }});
                // 增加给予矿石的数量
                player.update({RedEnvelopeRewards: {
                    "giveAmount": (playerTag.getInt("RedEnvelopeRewards.giveAmount") + 1)
                }});
            }
        }
    }
}

// 工具函数：根据玩家数据发放奖励
function sendReward(player as IPlayer, position as Position3f) as void {
    if (debug) player.sendChat("send reward.");
    // "specialmobs:specialcreeper", // 绿色
    // "specialmobs:deathcreeper", // 黑色
    // "specialmobs:gravelcreeper", // 白色
    // "specialmobs:firecreeper", // 红色
    // "specialmobs:drowningcreeper", //蓝色
    // "specialmobs:endercreeper" // 特殊
    // 红绿蓝白黑小大 0-9
    if (isNull(player.data)) return;
    var playerTag = D(player.data);
    if (playerTag.check("RedEnvelopeRewards")) {
        var type = playerTag.getInt("RedEnvelopeRewards.type");
        var smallItem as IItemStack = <minecraft:dirt>;
        var bigItem as IItemStack = <minecraft:grass>;
        if (type == 0) {
            smallItem = <dcs_climate:dcs_ore_stone_new:1> * 1;
            bigItem = <dcs_climate:dcs_ore_stone_new:6> * 1;
        } else if (type == 1) {
            smallItem = <dcs_climate:dcs_ore_stone_new:4> * 1;
            bigItem = <dcs_climate:dcs_ore_stone_new:9> * 1;
        } else if (type == 2) {
            smallItem = <dcs_climate:dcs_ore_stone_new:3> * 1;
            bigItem = <dcs_climate:dcs_ore_stone_new:8> * 1;
        } else if (type == 3) {
            smallItem = <dcs_climate:dcs_ore_stone_new:0> * 1;
            bigItem = <dcs_climate:dcs_ore_stone_new:5> * 1;
        } else if (type == 4) {
            smallItem = <dcs_climate:dcs_ore_stone_new:2> * 1;
            bigItem = <dcs_climate:dcs_ore_stone_new:7> * 1;
        }
        var smallCount = playerTag.getInt("RedEnvelopeRewards.small");
        if (type != 5) {
            if (smallCount > 0) {
                var remains = randomSpread(player.world, position, smallItem, smallCount);
                if (remains > 0) player.give(smallItem * remains);
            }
        } else {
            if (smallCount > 0) {
                var remains = randomSpread(player.world, position, smallItem, (smallCount * 2));
                if (remains > 0) player.give(smallItem * remains);
            }
        }
        var bigCount = playerTag.getInt("RedEnvelopeRewards.big");
        if (type != 5) {
            // 大矿石的物品实体有问题，直接给予玩家
            if (bigCount > 0) player.give(bigItem * bigCount);
        } else {
            if (bigCount > 0) {
                player.give(<dcs_climate:dcs_ore_stone_new:5> * max(1, bigCount/4));
                player.give(<dcs_climate:dcs_ore_stone_new:6> * max(1, bigCount/4));
                player.give(<dcs_climate:dcs_ore_stone_new:7> * max(1, bigCount/4));
                player.give(<dcs_climate:dcs_ore_stone_new:8> * max(1, bigCount/4));
                player.give(<dcs_climate:dcs_ore_stone_new:9> * max(1, bigCount/4));
            }            
        }
        if (debug) player.sendChat("Small ores: " ~ smallCount ~ ", big ores: " ~ bigCount);
        // 清空奖池
        player.update({RedEnvelopeRewards: {
            "hitCount": 0 as int,
            "type": 214738467,
            "smallRate": 0.0f as float,
            // 大矿石的 roll 采用整数 roll（1-4 <= bigRate）， bigrate == 0 时不出物品
            "bigRate": 0 as int,
            "small": 0 as int,
            "big": 0 as int,
            // 给予矿石的数量
            "giveAmount": 1
        }});
    }
}

// 工具函数：散布物品实体
function randomSpread(world as IWorld, position as Position3f, item as IItemStack, count as int) as int {
    
    // 最多用于散布的物品数量
    var maxSpreadItem as int = 32;

    // 每圈的半径，实际半径是这个值的整数倍
    var R as float = 1.5f;

    // 外圈高度
    var deltaY as float = 1.5f;
    
    // 外圈半径
    var rOut as float = 8.0f;

    // 原始坐标的分量
    var x = position.x;
    var y = position.y;
    var z = position.z;

    // 随机散布的物品实体数量，最大为 24
    var spreadCount = min(maxSpreadItem, count);
    
    for index in 0 .. spreadCount {
        var r = R;
        if (index >= 16) r = 3.0f * R;
        if (index >= 8) r = 2.0f * R;
        var h = y;
        if (index >= 16) h = y + 2.0f * deltaY;
        if (index >= 8) h = y + deltaY;
        // 这里的 8 是指 8 个点位
        if (index % 8 == 0) {
            spawnRewardItem(world, item, (x + r), h, z);
        } else if (index % 8 == 1) {
            spawnRewardItem(world, item, (x + r), h, (z + r));
        } else if (index % 8 == 2) {
            spawnRewardItem(world, item, x, h, (z + r));
        } else if (index % 8 == 3) {
            spawnRewardItem(world, item, (x - r), h, (z + r));
        } else if (index % 8 == 4) {
            spawnRewardItem(world, item, (x - r), h, z);
        } else if (index % 8 == 5) {
            spawnRewardItem(world, item, (x - r), h, (z - r));
        } else if (index % 8 == 6) {
            spawnRewardItem(world, item, x, h, (z - r));
        } else if (index % 8 == 7) {
            spawnRewardItem(world, item, (x + r), h, (z - r));
        } else {
            spawnRewardItem(world, item, x, h, z);
        }
    }    

    // 没有发完的部分
    return max(count - maxSpreadItem, 0);
}

// 工具函数：生成物品实体
function spawnRewardItem (world as IWorld, item as IItemStack, x as float, y as float, z as float) as void {
    var entityItem = item.createEntityItem(world, x, y, z);
    var randomVec as IVector3d = IVector3d.create(0.02f * world.random.nextDouble(), Math.abs(0.02f * world.random.nextDouble()), 0.02f * world.random.nextDouble());
    entityItem.setMotionVector(randomVec);
    entityItem.updateNBT({Glowing: 1});
    world.spawnEntity(entityItem);
}
