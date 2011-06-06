var c1 = new Array(0, 0);
var c2 = new Array(0, 0);

function initCrop() {
    var cd = document.getElementById("map");
    if (!(/#text/i.test(cd.firstChild.nodeName))) return;
    cd.cropped = true;
    cd.onclick = function(e) {
        if ($('moving').value == "true") {
            $('moving').value = "false";
        }
        else if ($('moving').value == "false") {
            $('moving').value = "true";
            var event = e;//? e : window.event;
            var x = parseInt($('hidden_x').value);
            var y = parseInt($('hidden_y').value);
            tp = getElPos(cd);
            c1[0] = event.clientX - tp[0];
            c1[1] = event.clientY - tp[1];


            if ((x != c1[0]) || (y != c1[1])) {

                //    $('user_pic').src = "http://m99.freerails.de/images/character/charger_right_small.gif" if (x < c1[0])
                window.setTimeout("move(" + x + "," + y + "," + c1[0] + "," + c1[1] + ")", 50);
            }
            //                $('user_pic').src = "http://m99.freerails.de/images/character/charger_stop_small.gif"

        }

    }
}


function move(x, y, mx, my) {
    size = "";
    if ($('user_pic').src.include("_small") != false) {
        size = "_small";
    }
    else if ($('user_pic').src.include("_midi") != false) {
        size = "_midi";
    }
    else {
    }
    if (size == "_small") {
        cx = 21;
        cy = 14;
        pixel = 1;
    }
    else if (size == "_midi") {
        cx = 30;
        cy = 22;
        pixel = 2;

    }
    else {
        cx = 62;
        cy = 45;
        pixel = 5;
    }

    newxy = moves(x, mx, pixel, size, y, my);
    x = newxy[0];
    y = newxy[1];

    $('me_map_div').style.left = "" + (x - cx) + "px";
    valid_area = valid_path(x, y);
    if ($('moving').value == "true" && valid_area && ( (x != mx) || (y != my))) {

        $('hidden_x').value = x;
        $('hidden_y').value = y;
        $('me_map_div').style.top = "" + (y - cy) + "px";
        if (valid_area == "berg") {
            window.setTimeout("move(" + x + "," + y + "," + mx + "," + my + ")", 175);
        }
        if (valid_area == "wasser") {
            window.setTimeout("move(" + x + "," + y + "," + mx + "," + my + ")", 50);
        }
        if (valid_area == "wald") {
            window.setTimeout("move(" + x + "," + y + "," + mx + "," + my + ")", 125);
        }
        if (valid_area == "field") {
            window.setTimeout("move(" + x + "," + y + "," + mx + "," + my + ")", 50);
        }

        if (valid_area.split("_")[0] == "town") {
            $("ajax_move").value = "false";

            new Ajax.Request('/world/visit?town=' + valid_area.split("_")[1] + '&x=' + $("hidden_x").value + '&y=' + $("hidden_y").value + '', {asynchronous:true, evalScripts:true, parameters:'authenticity_token=' + encodeURIComponent('fcdc66c78643c9aef5bea0cf075e79ee3c96cac9')});
        }
        if (valid_area.split("_")[0] == "exit") {
            $("ajax_move").value = "false";

            new Ajax.Request('/world/exit?exit_id=' + valid_area.split("_")[1], {asynchronous:true, evalScripts:true, parameters:'authenticity_token=' + encodeURIComponent('fcdc66c78643c9aef5bea0cf075e79ee3c96cac9')});
        }

        $('me_table').className = "me_table " + valid_area;
    }
    else {
        $('user_pic').src = "/images/character/hannes_stop" + size + ".gif";
        $('moving').value = "false"
    }

}


function getElPos(el) {
    x = el.offsetLeft;
    y = el.offsetTop;
    elp = el.offsetParent;
    while (elp != null) {
        x += elp.offsetLeft;
        y += elp.offsetTop;
        elp = elp.offsetParent;
    }
    return new Array(x, y);
}

function move_way(way, var_x_y, pixel, size) {
    if (way == ""){
       way = $('user_pic').src.split('_')[1];
    }
    if ($('user_pic').src.include("" + way + "" + size + "") == false) {

        $('user_pic').src = "/images/character/hannes_" + way + "" + size + ".gif"
    }
    if (way == "left" || way == "up") {
        return var_x_y -= pixel;
    }
    else if (way == "right" || way == "down") {
        return var_x_y += pixel;
    }

    return var_x_y
}


function moves(x, mx, pixel, size, y, my) {
    if (x < mx) {
        if ((x + pixel) < mx) {
            x = move_way("right", x, pixel, size);
        }
        else {
            x = move_way("right", mx, 0, size);
        }

    }
    else if (x > mx ) {
        if ((x - pixel) > mx) {
            x = move_way("left", x, pixel, size);
        }
        else {
            x = move_way("left", mx, 0, size);
        }

    }
    if (y < my ) {
        if ((y + pixel) < my) {
           y = move_way("right", y, pixel, size);
        }
        else {
            y = move_way("right", my, 0, size);
        }

    }
    else if (y > my ) {
        if ((y - pixel) > my) {
            y = move_way("left", y, pixel, size);
        }
        else {
            y = move_way("left", my, 0, size);
        }

    }
    return [x,y];
}

