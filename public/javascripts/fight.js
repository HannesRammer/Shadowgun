function set_and_select_character(char_id) {
    $('attacked_char').value = char_id;
    $('enemy_' + char_id + '_div_outter').className = 'enemy_div selected';
}

function move_in_fight(x) {

    $('me_div').style.marginTop = 2 * x + "px";
}

function ok_to_fight(char_id) {
    if ($('ajax_fight').value != 'true') {
        return false;
    }
    if ($('pause_fight').checked == true) {
        return false;
    }

}
function ok_to_fight_for(char_id) {
    awtc = $('aw_type_c' + char_id).value;
    r = awtc.split('_');
    wtype = r[0];

    wrange = parseFloat(r[1]);
    if ($('ajax_fight').value != 'true') {
        return false;
    }
    if ($('pause_fight').checked == true) {
        return false;
    }

    if ($('distance_to_' + char_id)) {
        counter = parseFloat($('distance_to_' + char_id).value);
    } else {
        counter = parseFloat($('distance_counter').innerHTML.split(' ')[0]);
    }

    if (counter > wrange || $('move_away_'+char_id).checked) {
        $('allow_fight_for_' + char_id).value = "false"
        return false;
    }
    else if (counter <= wrange || $('move_away_'+char_id).checked) {
        $('allow_fight_for_' + char_id).value = "true"
        return true;
    }

}

function hide_div_after(div_id, t) {
    Effect.Fade(div_id, { duration: t });
}


