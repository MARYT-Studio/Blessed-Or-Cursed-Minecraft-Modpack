#priority 10000
#loader crafttweaker reloadable

import crafttweaker.data.IData;

// 全局调试开关
static debug as bool = false;

// 铁砧更新事件相关
// 预估铁砧一次操作的时间
static anvilActionTime as long = 1L;

// 锻造上限相关
// 基础锻刀上限
static baseRefineLimit as int = 10;
// 键为维度 ID，值为提升的锻刀上限数
static rewardMap as IData = {
    "DIM0": 0,
    "DIM56": 5,
    "DIM-1": 10,
    "DIM1": 15,
    "DIM7": 20,
    "DIM28885": 10,
    "DIM50": 20,
    "DIM51": 30,
    "DIM52": 40,
    "DIM53": 50
} as IData;
// 锻造上限的初始化空白数据
static blankMap as IData = {    
    "DIM0": 0,
    "DIM56": 0,
    "DIM-1": 0,
    "DIM1": 0,
    "DIM7": 0,
    "DIM28885": 0,
    "DIM50": 0,
    "DIM51": 0,
    "DIM52": 0,
    "DIM53": 0
} as IData;
