import flixel.util.FlxAxes;

class SpriteUtil {
    public static function quickSprite(path:String, raw:Bool = true, params:Array<Dynamic>):FunkinSprite{
        var newspr:FunkinSprite = new FunkinSprite().loadGraphic(raw ? Paths.image(path) : path);
        applyParams(newspr, params);
        return newspr;
    }

    public static function applyParams(thing:FlxObject, params:Array<Dynamic>){
        for (field in Reflect.fields(params)){
            Reflect.setProperty(thing, field, Reflect.field(params, field));
        }
    }

    public static function centerTo(object1:FlxObject, object2:FlxObject, ?axis:String = 'XY'){
        if (axis == 'XY' || axis == 'X') object1.x = (object2.x + object2.width/2) - (object1.width/2);
        if (axis == 'XY' || axis == 'Y') object1.y = (object2.y + object2.height/2) - (object1.height/2);
    }
}