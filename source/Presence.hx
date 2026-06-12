import funkin.backend.utils.DiscordUtil;

import StringTools;

//this class has brought me nothing but trouble
class Presence {
    public static var topText:String = '';
    public static var bottomText:String = '';
    public static var lastTimestamp:Date;
    public static var sessionTimestamp:Date;

    public static var iconKey:String = 'alpha 3 icon';
    public static var imageKey:String = 'alpha 3 logo';

    public static function set(tt:String, bt:String, ?stamp:Date = sessionTimestamp, ?icon:String = 'alpha_3_icon', ?image:String = 'alpha_3_logo'){
        //trace('im setting it');
        DiscordUtil.init();

        topText = tt;
        bottomText = bt;
        lastTimestamp = stamp;
        iconKey = icon;
        imageKey = image;

        if (DiscordUtil.lastPresence != null) 
            DiscordUtil.lastPresence.largeImageKey = imageKey;
        else 
            trace('its null');

        //trace(DiscordUtil.lastPresence);
        //updatePresence();
    }

    public static function updatePresence(){
        DiscordUtil.changePresence(topText, bottomText);
    }
}