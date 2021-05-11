recipes.addShapeless(
    // 配方名称
    "give_a_testing_baiqiao",
    // 输出物品
    <flammpfeil.slashblade:slashbladewhite>.withTag({killCount : 50}).withDamage(10),
    // 输入材料
    [
        <minecraft:diamond_sword>,
        <minecraft:stone>,
        <minecraft:stone>,
        <minecraft:stone>
    ]
);

recipes.addShapeless(
    // 配方名称
    "give_a_testing_baiqiao_2",
    // 输出物品
    <flammpfeil.slashblade:slashbladewhite>.withTag({killCount : 501}),
    // 输入材料
    [
        <minecraft:diamond_sword>,
        <minecraft:dirt>,
        <minecraft:dirt>,
        <minecraft:dirt>
    ]
);
// 锻造锤
val T3Hammer = <sakura:sakura_hammer>;
// T2拔刀声明
// Named Blades
val mingdao_Xiewan = <lastsmith:.slashblade.named>.withTag({TextureName: "named/sekiro/kusabimaru", ModelName: "named/sekiro/kusabimaru", CurrentItemName: "flammpfeil.slashblade.named.kusabimaru", baseAttackModifier: 5.0 as float, "SB.SEffect": {}});
val ziduandao_Yongzhen = <lastsmith:.slashblade.named>.withTag({TextureName: "named/namedblade/texture_nagasada", ModelName: "named/namedblade/model_stright", CurrentItemName: "flammpfeil.slashblade.named.nagasada", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float, "SB.SEffect": {}});
val gangjian_Dongtianguan = <lastsmith:.slashblade.named>.withTag({TextureName: "named/muramasa/doutanuki", SpecialAttackType: 5, ModelName: "named/muramasa/muramasa", CurrentItemName: "flammpfeil.slashblade.named.doutanuki", baseAttackModifier: 6.0 as float, });
val lidao_Wuming_Hongyu = <lastsmith:.slashblade.named>.withTag({TextureName: "BambooKatana", CurrentItemName: "wrap.BambooMod.katana",baseAttackModifier: 4.0 as float, });
val qianhe_Cunzheng = <lastsmith:.slashblade.named>.withTag({TextureName: "named/muramasa/muramasa", SpecialAttackType: 1, ModelName: "named/muramasa/muramasa", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.muramasa", baseAttackModifier: 6.0 as float, });
val shengxingdao_Lvnaiwu = <lastsmith:.slashblade.named>.withTag({ModelName: "named/blademaster/blademaster", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.blademaster.greenmist", TextureName: "named/blademaster/greenmist", SpecialAttackType: 30, baseAttackModifier: 7.0 as float, });
val shiyuedao_Yanshuibozhan = <lastsmith:.slashblade.named>.withTag({ModelName: "named/blademaster/blademaster", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.blademaster.aquablaze", AttackAmplifier: -5.0 as float, TextureName: "named/blademaster/aquablaze", SpecialAttackType: 31, baseAttackModifier: 7.0 as float});
val yueguangying_Chuixueyishan = <lastsmith:.slashblade.named>.withTag({ModelName: "named/blademaster/blademaster", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.blademaster.moonlightcherry", TextureName: "named/blademaster/greenmist", SpecialAttackType: 32, baseAttackModifier: 7.0 as float});
val xingyuedao_Kongzhijingjie = <lastsmith:.slashblade.named>.withTag({TextureName: "named/tboen/texture", SpecialAttackType: 4, ModelName: "named/tboen/model", CurrentItemName: "flammpfeil.slashblade.named.tboen", baseAttackModifier: 7.0 as float,});
val jieyuedao_Yinyuan = <lastsmith:.slashblade.named>.withTag({SpecialAttackType: 8, TextureName: "named/yukari/texture", ModelName: "named/yukari/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yukari", baseAttackModifier: 7.0 as float, });
val yingguang = <lastsmith:.slashblade.named>.withTag({TextureName: "named/fluorescentbar/fluorescentbar", ModelName: "named/fluorescentbar/fluorescentbar", CurrentItemName: "flammpfeil.slashblade.named.fluorescentbar", baseAttackModifier: 2.0 as float});
val fenglaijian = <lastsmith:.slashblade.named>.withTag({TextureName: "named/wanderer/wanderer", SpecialAttackType: 30, ModelName: "named/wanderer/wanderer", CurrentItemName: "flammpfeil.slashblade.named.wanderer", baseAttackModifier: 7.0 as float});
val fenglaizhixieren =  <lastsmith:slashblade_rf>.withTag({ModelName: "named/wanderer/wanderer", ModelOnName: "named/wanderer/wanderer", CurrentItemName: "flammpfeil.slashblade.named.wanderer.rfblade", AttackAmplifier: -5.0 as float, TextureName: "named/wanderer/wanderer", SpecialAttackType: 30, TextureOnName: "named/wanderer/wanderer", baseAttackModifier: 7.0 as float});
val shanying_Shizou = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_shiwasu", ModelName: "named/yamazakura/shimotsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.shiwasu", IsFakeBlade: 1 as byte, baseAttackModifier: 7.0 as float});
val shanying_Shuangyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_shimotsuki", ModelName: "named/yamazakura/shimotsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.shimotsuki", IsFakeBlade: 1 as byte, baseAttackModifier: 7.0 as float});
val shanyingchangyue_Ju = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_nagatsuki_kiku", ModelName: "named/yamazakura/fumizuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.kiku", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanying_Yeyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_hazuki", ModelName: "named/yamazakura/fumizuki_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.hazuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanying_Gaoyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_satsuki", ModelName: "named/yamazakura/satsuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.satsuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanying_Maoyue =  <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_uzuki", ModelName: "named/yamazakura/uzuki", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.uzuki", IsFakeBlade: 1 as byte, baseAttackModifier: 6.0 as float});
val shanyingmisheng_Ying = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_yayoi_sakura", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.sakura", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
val shanyingruyue_Mei = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_kisaragi_ume", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.ume", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
val shanyingmuyue_Song = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yamazakura/yamazakura_mutsuki_kadomatsu", ModelName: "named/yamazakura/model_fake", CurrentItemName: "flammpfeil.slashblade.named.yamazakura.kadomatsu", IsFakeBlade: 1 as byte, baseAttackModifier: 5.0 as float});
val huyuedao_Baihu = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fox.white", TextureName: "named/sange/white", SpecialAttackType: 0, TrueItemName: "flammpfeil.slashblade.named.fox.white", isBroken: 0 as byte, baseAttackModifier: 4.0 as float});
val huyuedao_Heihu = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.fox.black", TextureName: "named/sange/black", SpecialAttackType: 4, TrueItemName: "flammpfeil.slashblade.named.fox.black", isBroken: 0 as byte, baseAttackModifier: 4.0 as float});
val dongyingdao_Xuehuacangyue = <lastsmith:.slashblade.named>.withTag({TextureName: "named/frostwolf/frostwolfa", SpecialAttackType: 30, ModelName: "named/frostwolf/frostwolfa", CurrentItemName: "flammpfeil.slashblade.named.frostwolfa", baseAttackModifier: 7.0 as float});
val mingshoudao_Yangyabinglang = <lastsmith:.slashblade.named>.withTag({TextureName: "named/frostwolf/frostwolfb", SpecialAttackType: 32, ModelName: "named/frostwolf/frostwolfb", CurrentItemName: "flammpfeil.slashblade.named.frostwolfb", baseAttackModifier: 7.0 as float});
val dao = <lastsmith:.slashblade.named>.withTag({TextureName: "wa/waA", ModelName: "wa/model", CurrentItemName: "flammpfeil.slashblade.named.wa.katana", baseAttackModifier: 3.0 as float});
val taidao = <lastsmith:.slashblade.named>.withTag({TextureName: "wa/waB", ModelName: "wa/model", CurrentItemName: "flammpfeil.slashblade.named.wa.tachi", baseAttackModifier: 3.0 as float});
val lidao_Cangmei = <lastsmith:.slashblade.named>.withTag({TextureName: "wa/template", SpecialAttackType: 3, ModelName: "wa/model", CurrentItemName: "SlashBladeTemplate.blue", baseAttackModifier: 7.0 as float});
val doudao_Gudu = <lastsmith:.slashblade.named>.withTag({TextureName: "named/namedblade/texture_super", ModelName: "named/namedblade/model", CurrentItemName: "flammpfeil.slashblade.named.kogawa_super", baseAttackModifier: 7.0 as float});
// All T2 Blades List
val T2_SlashBlades = 
    mingdao_Xiewan|
    ziduandao_Yongzhen|
    gangjian_Dongtianguan|
    lidao_Wuming_Hongyu|
    qianhe_Cunzheng|
    shengxingdao_Lvnaiwu|
    shiyuedao_Yanshuibozhan|
    yueguangying_Chuixueyishan|
    xingyuedao_Kongzhijingjie|
    jieyuedao_Yinyuan|
    yingguang|
    fenglaijian|
    fenglaizhixieren|
    shanying_Shizou|
    shanying_Shuangyue|
    shanyingchangyue_Ju|
    shanying_Yeyue|
    shanying_Gaoyue|
    shanying_Maoyue|
    shanyingmisheng_Ying|
    shanyingruyue_Mei|
    shanyingmuyue_Song|
    huyuedao_Baihu|
    huyuedao_Heihu|
    dongyingdao_Xuehuacangyue|
    mingshoudao_Yangyabinglang|
    dao|
    taidao|
    lidao_Cangmei|
    doudao_Gudu;
// Tier 3 SlashBlades
val mojian_Yanmodao = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yamato", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yamato", TextureName: "named/yamato", SpecialAttackType: 0, IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float, "SB.SEffect": {}, });
val jieyuedao_Fusang = <lastsmith:.slashblade.named>.withTag({TextureName: "named/a_tukumo", ModelName: "named/agito", CurrentItemName: "flammpfeil.slashblade.named.yuzukitukumo",SpecialAttackType: 3, baseAttackModifier: 7.0 as float, "SB.SEffect": {}});
val lanyecha = <lastsmith:.slashblade.named>.withTag({ModelName: "named/yasha/yasha", isDefaultBewitched: 1 as byte, IsNoStandDrop: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yasha", TextureName: "named/yasha/yasha", SpecialAttackType: 4, baseAttackModifier: 6.0 as float, });
val hongyecha = <lastsmith:.slashblade.named>.withTag({TextureName: "named/yasha/yasha", SpecialAttackType: 5, ModelName: "named/yasha/yashaTrue", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.yashatrue", baseAttackModifier: 6.0 as float});
val sanhua = <lastsmith:.slashblade.named>.withTag({ModelName: "named/sange/sange", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.sange", TextureName: "named/sange/sange", SpecialAttackType: 7, IsBewitchedActived: 1 as byte, baseAttackModifier: 6.0 as float});
val kushidadao = <lastsmith:.slashblade.named>.withTag({onClick: 0 as byte, ModelName: "named/dios/dios", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.koseki",TextureName: "named/dios/koseki", SpecialAttackType: 6, isBroken: 0 as byte, baseAttackModifier: 6.0 as float, "SB.SEffect": {WitherEdge: 20}});
val lanemen = <lastsmith:.slashblade.named>.withTag({ModelName: "named/agito", CurrentItemName: "flammpfeil.slashblade.named.agito", TextureName: "named/agito_false", SpecialAttackType: 2, isBroken: 0 as byte, baseAttackModifier: 6.0 as float, });
val dashe_Emen = <lastsmith:.slashblade.named>.withTag({TextureName: "named/orotiagito", SpecialAttackType: 2, ModelName: "named/agito", CurrentItemName: "flammpfeil.slashblade.named.orotiagito", IsBewitchedActived: 1 as byte, baseAttackModifier: 7.0 as float});
//All T3 Blades List
val T3_SlashBlades =
    mojian_Yanmodao|
    jieyuedao_Fusang|
    lanyecha|
    hongyecha|
    sanhua|
    kushidadao|
    lanemen|
    dashe_Emen;
// Tier 4 SlashBlades
val tianyun_Wunian = <lastsmith:.slashblade.named>.withTag({ModelName: "named/smith/model", isDefaultBewitched: 1 as byte, CurrentItemName: "flammpfeil.slashblade.named.smith.final", SpecialAttackType: 263, TextureName: "named/smith/texture_final", IsBewitchedActived: 1 as byte, isBroken: 0 as byte, baseAttackModifier: 31.0 as float, "SB.SEffect": {bewitched_sharpness: 40, sap_slash: 30}});
// All T4 Blades List
val T4_SlashBlades = tianyun_Wunian;

recipes.addShapeless(
    // 配方名称
    "give_a_testing_yongzhen",
    // 输出物品
    ziduandao_Yongzhen.updateTag({killCount : 501, ProudSoul : 501, display: {Name: "一把有斩有魂的永贞"}}),
    // 输入材料
    [
        T2_SlashBlades,
        <minecraft:dirt>,
        <minecraft:dirt>,
        <minecraft:dirt>
    ]
);

recipes.addShapeless(
    // 配方名称
    "give_a_testing_gudu",
    // 输出物品
    doudao_Gudu.updateTag({killCount : 501, ProudSoul : 501, display: {Name: "一把有斩有魂的孤独"}}),
    // 输入材料
    [
        T2_SlashBlades,
        <minecraft:stone>,
        <minecraft:stone>,
        <minecraft:stone>
    ]
);

recipes.addShapeless(
    // 配方名称
    "give_a_testing_dashe_emenn",
    // 输出物品
    dashe_Emen.updateTag({killCount : 910, ProudSoul : 2401, display: {Name: "一把有斩有魂的大蛇鄂门"}}),
    // 输入材料
    [
        T3_SlashBlades,
        <minecraft:stone>,
        <minecraft:stone>,
        <minecraft:stone>
    ]
);

recipes.addShapeless(
    "give_a_damaged_t3hammer",
    T3Hammer.withDamage(1560),
    [
        <minecraft:stone>,<minecraft:stone>,<minecraft:dirt>,<minecraft:dirt>
    ]
);

recipes.addShapeless(
    "give_a_testing_wunian",
    tianyun_Wunian.updateTag({killCount : 1400, ProudSoul : 4900, display: {Name: "一把有斩有魂的天云无念"}}),
    [
        tianyun_Wunian,
        <minecraft:stone>,
        <minecraft:stone>,
        <minecraft:stone>
    ]
);