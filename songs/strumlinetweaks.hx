import ModManiaHandler;

function postCreate(){
    for (strumline in strumLines.members){
        switch (ModManiaHandler.MODVERSION){ //this is for the receptor positions being offset like in the base game before being centered in 2.5 i think
            case 'alpha 3', 'alpha 8', 'alpha 9', '1.0':
                strumline.onHit.add((hitEvent:NoteHitEvent) -> {
                    var targetNote = hitEvent.note;
                    var receptor = targetNote.__strum;

                    if (strumline.cpu) hitEvent.preventStrumGlow();
                });

                for (receptor in strumline){
                    receptor.x -= 40;
                }
            case '2.0', '2.5':
                strumline.onHit.add((hitEvent:NoteHitEvent) -> {
                    var receptor = hitEvent.note.__strum;
                    receptor.lastHit = hitEvent.note.strumTime + (Conductor.crochet * 2);

                    hitEvent.preventStrumGlow();

                    if (receptor.animation.curAnim.name != 'confirm') receptor.playAnim('confirm', false);
                });
            case '3.0':
                strumline.onHit.add((hitEvent:NoteHitEvent) -> {
                    var receptor = hitEvent.note.__strum;

                    if (strumline.cpu){
                        receptor.lastHit = (hitEvent.note.strumTime - (Conductor.stepCrochet * 2)) + ((1000 / 24) * 4);

                        hitEvent.preventStrumGlow();

                        receptor.playAnim('confirm', true);
                    }
                });
        }   
    }
}

function beatHit(curBeat:Int){
    for (strumline in strumLines.members){
        if (strumline.cpu){
            switch(ModManiaHandler.MODVERSION){
                case '2.0', '2.5':
                    for (receptor in strumline){
                        if (receptor.animation.curAnim.curFrame == (receptor.animation.curAnim.numFrames - 1))
                            receptor.playAnim('static', false);
                    }
            }
        }
    }
}