import flixel.FlxObject;
import funkin.backend.system.framerate.Framerate;

function new(){
    //FlxObject.defaultMoves = false;
    FlxSprite.defaultAntialiasing = true;
}

function postStateSwitch(){
    for (i in [Framerate.codenameBuildField])
		i.visible = false;
}