import flixel.FlxObject;

class ModManiaHandler {
    //what dave and bambi version?
    public static var MODVERSION:String = 'alpha 3';

    //placebo story week, modifiers and dialogue are optional
    public static var playlist:Array<PlaylistTrack> = [];
}

class PlaylistTrack extends FlxObject{
    var songMeta = {
        file: '',
        displayName: '',
        variation: 'none'
    };

    var difficulty:String = '';
    var version:String = '';
    var variation:String = '';

    override function new(songFile:Dynamic, difficulty:String, version:String){
        super();

        this.songMeta = songFile;
        this.difficulty = difficulty;
        this.version = version;
    }
}