import mods.ingameinfo.gui.IgiGuiManager;
import mods.ingameinfo.event.IgiGuiInitEvent;

events.onIgiGuiInit(function(event as IgiGuiInitEvent)
{
    IgiGuiManager.openGui("test");
});