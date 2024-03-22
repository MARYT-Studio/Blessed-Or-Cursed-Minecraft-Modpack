#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.zenutils.cotx.Item;

var redEnvelope = mods.contenttweaker.VanillaFactory.createExpandItem("red_envelope_lubang");
redEnvelope.creativeTab = <creativetab:misc>;
redEnvelope.rarity = "epic";
redEnvelope.glowing = false;
redEnvelope.maxStackSize = 64;
redEnvelope.itemUseAction = "BOW";
redEnvelope.register();