import modchart.Manager;
import modchart.Config;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import funkin.options.Options;
import funkin.editors.charter.Charter;
import funkin.backend.system.Logs;

var toggleScript = true; // will not activate if you dont have dev mode enabled!
var toggleScriptInfo = false; // ditto

var noteDebugging = true; // toggles the strumline/modchart debug things
var timeScaleDoubleMultiplier = 5; // dont set this to 0 please

///////////////////    DON'T CHANGE   ///////////////////////
var botplayEnabled = false;
var botplayTxt = null;
var timeTween = null;
var debugEnabled = true;
var speedingUpTime = false;

function postCreate()  { // i kind of want to make this a script where anyone can use it.
    if (!debugEnabled)
        return;
    if (noteDebugging && toggleScriptInfo) {
        debugList = new FunkinText(4, 4, 0, 'Debug Keybind List:\n\nGameplay:\nSpeedup gameplay: 1\nSpeedup gameplay (' + timeScaleDoubleMultiplier + 'x): 2\nBotplay: B' + (noteDebugging ? '\n\nStrumLine & Modchart:\nArrow Paths: P\nSustain Behind Strums: Left Bracket' : '') /*+ '\n\nMisc: \n\nOpen Chart Editor: ' + getFunkinOption('SOLO_DEV_ACCESS')*/);
        debugListBg = new FunkinSprite(debugList.x - 2, debugList.y - 2).makeGraphic(debugList.width + 4, debugList.height + 2, 0x6C000000);

        botplayTxt = new FunkinText(0, 4, 0, 'Botplay: ' + (player.cpu ? 'enabled' : 'disabled'));
        botplayTxt.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        botplayTxt.updateHitbox();

        botplayTxtBg = new FunkinSprite(botplayTxt.x - 2, botplayTxt.y - 2).makeGraphic(botplayTxt.width + 4, botplayTxt.height + 2, 0x6C000000);
        
        debugUiGroup = new FlxGroup();
        debugUiGroup.cameras = [camHUD];
        add(debugUiGroup);

        for (i in [debugListBg, debugList, botplayTxtBg, botplayTxt])
        {
            debugUiGroup.add(i);
            i.cameras = [camHUD];
            if (i != botplayTxt && i != botplayTxtBg)
                FlxTween.tween(i, {x: (i.x - debugListBg.width), alpha: 0}, 6, {startDelay: 5});
        }
    }
    resetDebugShit();
}

function postUpdate() 
{
    if (!debugEnabled)
        return;
    if (noteDebugging) {
        if (FlxG.keys.justPressed.B)
            toggleBotplay(!botplayEnabled);

        if (FlxG.keys.justPressed.ONE && !FlxG.keys.pressed.TWO) {
            speedingUpTime = true;
            player.cpu = true;
            timeTween?.cancel();
            timeTween = FlxTween.tween(FlxG, {timeScale: 2}, 0.15);
        }
        else if (!FlxG.keys.pressed.ONE && FlxG.keys.justPressed.TWO)
        {
            speedingUpTime = true;
            player.cpu = true;
            timeTween?.cancel();
            timeTween = FlxTween.tween(FlxG, {timeScale: 2 * timeScaleDoubleMultiplier}, 0.15);
        }

        if (FlxG.keys.justReleased.ONE || FlxG.keys.justReleased.TWO) {
            speedingUpTime = false;
            player.cpu = botplayEnabled;
            timeTween?.cancel();
            timeTween = FlxTween.tween(FlxG, {timeScale: 1}, 0.15);
        }
        
        if (FlxG.keys.pressed.CONTROL){
            if (FlxG.keys.justPressed.LBRACKET) FlxG.timeScale = FlxMath.roundDecimal(FlxG.timeScale - 0.05, 2);
            if (FlxG.keys.justPressed.RBRACKET) FlxG.timeScale = FlxMath.roundDecimal(FlxG.timeScale + 0.05, 2);
        }
    }
    if (botplayTxt != null && toggleScript) 
    {
        botplayTxt.text = 'Botplay: ' + (player.cpu ? 'enabled' : 'disabled');
        botplayTxt.updateHitbox();
        botplayTxt.x = (FlxG.width - botplayTxt.width) - 4;
        debugUiGroup.remove(botplayTxtBg);
        botplayTxtBg = new FunkinSprite(botplayTxt.x - 2, botplayTxt.y - 2).makeGraphic(botplayTxt.width + 4, botplayTxt.height + 2, 0x6C000000);
        debugUiGroup.add(botplayTxtBg);
    }
}

function onGamePause()
    FlxG.timeScale = 1;

///////////////////////////

function toggleBotplay(bool) {
    if (!debugEnabled)
        return;
    Logs.infos('Botplay ' + (bool ? 'enabled' : 'disabled'), 2, 'Debug');
    player.cpu = bool;
    botplayEnabled = bool;

}

function resetDebugShit() {
    if (!debugEnabled)
        return;
    for (i in [Config.OPTIMIZE_HOLDS, Config.RENDER_ARROW_PATHS, Config.HOLDS_BEHIND_STRUM])
        i = false;
    toggleBotplay(false);
    FlxG.timeScale = 1;
}