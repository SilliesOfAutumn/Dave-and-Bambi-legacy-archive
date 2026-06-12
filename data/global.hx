import flixel.FlxObject;
import funkin.backend.system.framerate.Framerate;

import Presence;

function new(){
    //FlxObject.defaultMoves = false;
    FlxSprite.defaultAntialiasing = true;

    Presence.sessionTimestamp = Date.now();
    Presence.set('loading up', 'Title screen');
}

function postStateSwitch(){
    for (i in [Framerate.codenameBuildField])
		i.visible = false;
}