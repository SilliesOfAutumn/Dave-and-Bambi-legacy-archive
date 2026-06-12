import ModManiaHandler;
import Presence;
import funkin.options.Options;

function postCreate(){
    doIconBop = false;

    switch(ModManiaHandler.MODVERSION){ //healthbar shit
        case 'alpha 3', 'alpha 8', 'alpha 9', '1.0', '2.0':
            healthBar.createFilledBar(0xffff0000, 0xff00ff00);
            healthBar.updateBar();
        default:
            Options.colorHealthBar = true;
    
    }

    missesTxt.visible = false;
    accuracyTxt.visible = false;

    Presence.set('Playing ${PlayState.SONG.meta.displayName}', 'version: ${ModManiaHandler.MODVERSION}, difficulty: ${PlayState.difficulty}');
}

function update(elapsed:Float){
    var iconLerp:Float = FlxMath.bound(elapsed * (ModManiaHandler.MODVERSION == '3.0' ? 30 : 70), 0, 1);
    for (icon in [iconP1, iconP2]){
        icon.scale.set(FlxMath.lerp(icon.scale.x, 1, iconLerp), FlxMath.lerp(icon.scale.y, 1, iconLerp));
    }
}

function beatHit(curBeat:Int){
    for (icon in [iconP1, iconP2]){
        var isRight:Bool = icon == iconP1;

        icon.origin.set(isRight ? 0 : icon.width, 0);

        switch(ModManiaHandler.MODVERSION){
            case '2.5', '3.0':
                icon.scale.x = FlxMath.remapToRange(healthBar.value, 2, 0, isRight ? 1.5 : 1.1, isRight ? 1.1 : 1.5);
                icon.scale.y = FlxMath.remapToRange(healthBar.value, 2, 0, isRight ? 0.7 : 0.9, isRight ? 0.9 : 0.7);
            default:
                icon.scale.set(1.3, 0.8);
        }
    }
}