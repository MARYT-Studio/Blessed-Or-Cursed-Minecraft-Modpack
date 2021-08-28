import crafttweaker.data.IData;
import crafttweaker.text.ITextComponent;
import crafttweaker.item.IItemStack;

recipes.remove(<huntingdim:frame>);
val huntingDimPortalFrame as IItemStack = <huntingdim:frame>.withTag({BaseBlock: {id: "abyssalcraft:dltlog", Count: 1 as byte, Damage: 0 as short}});
val material = <twilightforest:castle_rune_brick:0> |
               <twilightforest:castle_rune_brick:1> |
               <twilightforest:castle_rune_brick:2> |
               <twilightforest:castle_rune_brick:3>;
recipes.addShaped("hunting_dim_portal_frame", huntingDimPortalFrame,
    [
        [null, material, null],
        [material, null, material],
        [null, material, null]
    ],
    function (out,ins,info) { return out; },
    function (out,info,player)
    {
        if(!player.world.remote)
        {
            player.update({PlayerPersisted: {HasCraftedHDPortal: 1}});
            player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.has_access_to_hd"));
        }
    }
);