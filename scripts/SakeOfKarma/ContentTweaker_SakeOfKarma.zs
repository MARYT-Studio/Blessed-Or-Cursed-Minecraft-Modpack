#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Block;
var huntingAltar = VanillaFactory.createBlock("sake_of_karma", <blockmaterial:glass>);

huntingAltar.witherProof = true;
huntingAltar.replaceable = false;

huntingAltar.setLightValue(15);
huntingAltar.setToolLevel(1);
huntingAltar.setBlockResistance(10000.0);
huntingAltar.setBlockSoundType(<soundtype:glass>);
huntingAltar.register();
