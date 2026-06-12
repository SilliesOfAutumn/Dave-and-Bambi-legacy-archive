import ModManiaHandler;
import funkin.options.Options;

function postCreate(){
    switch(ModManiaHandler.MODVERSION){ //healthbar shit
        case 'alpha 3', 'alpha 8', 'alpha 9', '1.0', '2.0':
            healthBar.createFilledBar(0xffff0000, 0xff00ff00);
            healthBar.updateBar();
        default:
            Options.colorHealthBar = true;
    }

    missesTxt.visible = false;
    accuracyTxt.visible = false;
}