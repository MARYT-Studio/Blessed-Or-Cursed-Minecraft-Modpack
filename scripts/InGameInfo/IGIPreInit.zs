#loader preinit

import mods.ingameinfo.mvvm.ViewModel;
import mods.ingameinfo.mvvm.View;
import mods.ingameinfo.mvvm.Mvvm;
import mods.ingameinfo.Types;
import mods.ingameinfo.igievent.EventCenter;

Mvvm.define("test");

View.setIxmlFileName("test");

var myUidText = ViewModel.registerReactiveObject("myUidText", Types.String, "myUid", "text", true);

ViewModel.setStartAction(function()
{
    EventCenter.addGameFpsEventListener(function(fps as int)
    {
        myUidText.set("Current FPS: " ~ fps);
    });
});