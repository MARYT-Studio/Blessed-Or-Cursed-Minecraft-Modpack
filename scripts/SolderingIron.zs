import crafttweaker.data.IData;
recipes.addShaped("soldering_iron",<contenttweaker:soldering_iron>.withTag({PowerLeft:0}),
    [
        [null,null,<ore:dyeYellow>],
        [null,<dcs_climate:dcs_ingot:5>|<sakura:materials:56>,null],
        [<ore:ingotBrass>,null,null]
    ]
);

// 烙铁电量显示模块
<contenttweaker:soldering_iron>.addAdvancedTooltip(
    function(item)
    {   
        var solderingIronNBT as IData = item.tag;
            if(isNull(solderingIronNBT.PowerLeft))
            {
                return game.localize("crafttweaker.soldering_iron_nouse.tooltip");
            }
            else if(solderingIronNBT.PowerLeft.asInt() == 0)
            {
                return game.localize("crafttweaker.soldering_iron_needcharge.tooltip");
            }
            else
            {
                var powerLeft as float = solderingIronNBT.PowerLeft.asFloat();
                var displayPower as float = powerLeft * 6.25;
                return game.localize("crafttweaker.soldering_iron_1.tooltip") ~ displayPower ~ game.localize("crafttweaker.soldering_iron_2.tooltip");
            }
    }
);

// 烙铁充电模块
recipes.addShapeless(
    // 配方名称
    "soldering_iron_charging",
    // 输出物品
    <contenttweaker:soldering_iron>,
    // 输入材料
    [
        <contenttweaker:soldering_iron>.marked("solderingIron"),
        <contenttweaker:lemon_battery>
    ],
    // 配方函数
    function(out,ins,info)
    {
        var solderingIronNBT as IData = ins.solderingIron.tag;
        if(isNull(solderingIronNBT)||isNull(solderingIronNBT.PowerLeft))
        {
            return null;
        }
        else
        {
            var solderingIronPowerLeft as int = solderingIronNBT.PowerLeft.asInt();
            return solderingIronPowerLeft < 16 ? out.updateTag({PowerLeft : solderingIronPowerLeft + 1}) : null;
        }
    },
    // 配方动作
    null
);