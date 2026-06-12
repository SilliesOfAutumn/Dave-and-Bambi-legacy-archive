import funkin.backend.utils.DiscordUtil;

import StringTools;

class Presence {
    public static var topText:String = '';
    public static var bottomText:String = '';
    public static var lastTimestamp:Date;
    public static var sessionTimestamp:Date;

    public static var iconKey:String = 'alpha 3 icon';
    public static var imageKey:String = 'alpha 3 logo';

    public static function set(tt:String, bt:String, ?stamp:String = sessionTimestamp, ?icon:String = 'alpha 3 icon', ?image:String = 'alpha 3 logo'){
        var specialChars:Array<String> = [' ', '.', ','];

        for (txt in [icon, image]){
            for (char in specialChars){
                StringTools.replace(txt, char, '_');
            }
        }

        topText = tt;
        bottomText = bt;
        lastTimestamp = stamp;
        iconKey = icon;
        imageKey = image;

        updatePresence();
        if (DiscordUtil.lastPresence != null) DiscordUtil.lastPresence.largeImageKey = imageKey;
    }

    public static function updatePresence(){
        DiscordUtil.changePresenceSince(topText, bottomText, iconKey, lastTimestamp);
    }
}