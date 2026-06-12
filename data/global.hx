import flixel.FlxObject;
import funkin.backend.system.framerate.Framerate;

import funkin.backend.utils.DiscordUtil;
import Presence;

function new(){
    //FlxObject.defaultMoves = false;
    FlxSprite.defaultAntialiasing = true;

    Presence.sessionTimestamp = Date.now();
}

function postStateSwitch(){
    for (i in [Framerate.codenameBuildField])
		i.visible = false;
}

function postUpdate(elapsed){
    //Presence.updatePresence();
}