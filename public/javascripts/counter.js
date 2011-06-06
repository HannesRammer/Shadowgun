var id;
var counter_max;
function set_weapon_counter(char_id, time, id) {
    counter_max = roundNumber((time - $("my_level").innerHTML * 0.025), 2);
    ac_id = $('attacked_char').value;
    if (counter_max <= 0) {
        counter_max = 0;

    }

    $("time_counter").innerHTML = "" + counter_max + " sekunden";
    countdown(countdown, counter_max, id, char_id, ac_id, "sekunden", 100, 0.1, 0.1, 0.0);

}
function set_distance_counter_for(char_id, id) {
    ac_id = $('attacked_char').value;
    distance = roundNumber(($('distance_to_' + ac_id).value), 2);
    repeat_every_ms = 100;
    /*milliseconds*/
    cmps = roundNumber($('mps_' + char_id).value, 6);
    amps = roundNumber($('mps_' + ac_id).value, 6);

    cmpms = cmps / 1000;
    ampms = amps / 1000;
    /*milliseconds*/
    cmpr = cmpms * repeat_every_ms;
    ampr = ampms * repeat_every_ms;
    $("distance_counter").innerHTML = "" + distance + " meter";
    move_in_fight(distance);


    countdown(distance, distance, id, char_id, ac_id, "meter", repeat_every_ms, cmpr, ampr, 0.0);
}
//set text eg "3 meter" oder "2 sekunden"}
function countdown(counter_max, counter, id, char_id, ac_id, name, repeat_every_ms, cmpr, ampr, past_time_since_run_start) {
    counting = true;


    if (name == "meter") {

        awtc = $('aw_type_c' + char_id).value;
        r = awtc.split('_');
        wtype = r[0];
        wrange = r[1];

        awtc2 = $('aw_type_c' + ac_id).value;
        r2 = awtc2.split('_');
        wtype2 = r2[0];
        wrange2 = r2[1];
        cra = $('move_away_' + char_id).checked;
        ara = $('move_away_' + ac_id).checked;
        if (wrange > counter) {
            if (cra) {
                $('allow_fight_for_' + char_id).value = "false";
                counter = increase_counter(counter, cmpr);
                move_in_fight(counter);
            } else {
                $('allow_fight_for_' + char_id).value = "true";
            }
            $('distance_to_' + ac_id).value = counter;
            if (wrange2 > counter) {
                counting = false;
                setTimeout('countdown(' + counter_max + ',' + counter + ',\"' + id + '\",\"' + char_id + '\",\"' + ac_id + '\",\"' + name + '\",' + repeat_every_ms + ',' + cmpr + ',' + ampr + ',' + past_time_since_run_start + ')', repeat_every_ms);
            } else if (wrange2 <= counter) {
                counter = decrease_counter(counter, ampr);
                move_in_fight(counter);
                $('distance_to_' + ac_id).value = counter;
            }
        } else if (wrange <= counter) {
            counter = decrease_counter(counter, cmpr);
            move_in_fight(counter);
            $('distance_to_' + ac_id).value = counter;
            $('allow_fight_for_' + char_id).value = "false";
            if (wrange2 > counter) {
            } else if (wrange2 <= counter) {
                counter = decrease_counter(counter, ampr);
                move_in_fight(counter);
                $('distance_to_' + ac_id).value = counter;
            }
        }

        ok_to_fight_for(ac_id);
        ok_to_fight_for(char_id);

    }

    if (counting) {
        count(counter, id, counter_max, name, char_id, ac_id, repeat_every_ms, cmpr, ampr, past_time_since_run_start);
    }

}

function count(counter, id, counter_max, name, char_id, ac_id, repeat_every_ms, cmpr, ampr, past_time_since_run_start) {
    if (counter > 0) {
        $(id).disabled = true;
        $(id).style.zIndex = 0;
        drown_to_null(counter_max, counter, id);


        if (name == "sekunden") {
            counter = decrease_counter(counter, cmpr);
            name_type = "time";
        } else if (name == "meter") {
            name_type = "distance";
            past_time_since_run_start += repeat_every_ms;
            past_dist = counter_max - counter;
            $("distance_time_counter").innerHTML = roundNumber(past_dist, 1) + "meter in " + (roundNumber(past_time_since_run_start, 1) / 1000) + " sekunden";
        }
        $(name_type + "_counter").innerHTML = "" + counter + " " + name;
        setTimeout('countdown(' + counter_max + ',' + counter + ',\"' + id + '\",\"' + char_id + '\",\"' + ac_id + '\",\"' + name + '\",' + repeat_every_ms + ',' + cmpr + ',' + ampr + ',' + past_time_since_run_start + ')', repeat_every_ms);
    }
    else {
        $(id).disabled = false;
        $(id).style.zIndex = 2
    }
}

function decrease_counter(counter, y) {
    x = roundNumber((counter - y), 2);
    if (x < 0) {
        x = 0;
    }
    return x;
}
function increase_counter(counter, y) {
    x = roundNumber((counter + y), 2);
    return x;
}
//fill functions START ////

//fills 2 divs decount + id + _empty and _full
// like a glass _empty clear and the _full filled
//eg diablo mana health
function fill(percent, id) {             //called
    $("decount_" + id + "_empty").style.height = (100 - percent) + "%";
    $("decount_" + id + "_full").style.height = percent + "%";
}

//fill id to 100%
function full(id) {               //inject
    fill(100, id);
}

//calles fill function with max val and current val
function drown_to_null(counter_max, counter, id) {             //called
    var percent = ((100 / counter_max ) * counter);
    if (percent > 0) {
        fill(percent, id)
    }
}

//fill functions END ////