#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Block;
var huntingAltar = VanillaFactory.createBlock("hunting_altar", <blockmaterial:rock>);

huntingAltar.witherProof = true;
huntingAltar.replaceable = false;

huntingAltar.setLightValue(6);
huntingAltar.setToolLevel(100);
huntingAltar.setBlockSoundType(<soundtype:stone>);
huntingAltar.register();