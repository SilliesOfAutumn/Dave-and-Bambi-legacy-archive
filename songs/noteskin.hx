import openfl.util.Assets;

function onStrumCreation(e) {
    var char = e.strum.strumLine.characters[0];
        e.sprite = getNoteSkin(char);
}

function onNoteCreation(e) {
    var char = e.note.strumLine.characters[0];
        e.noteSprite = getNoteSkin(char);
}

function getNoteSkin(char:Character):String{
    var preferPath:String = 'ui/notes/';
    var noteskinOverride:String = Reflect.field(PlayState.SONG.meta.customValues, 'noteskinOverride');

    if (Assets.exists(Paths.image(preferPath + noteskinOverride)))
        preferPath += noteskinOverride;
    else if (Assets.exists(Paths.image(preferPath + char.extra['noteSkin'])))
        preferPath += char.extra['noteSkin'];
    else
        preferPath += 'default';

    return preferPath;
}
