function start_buff_effect_on(char_id, start_color,end_color) {
    div = $('c' + char_id + '_effect_div');

    div.style.backgroundColor = start_color;
    div.style.border = "2px solid " + end_color;
    x = 0;
    height = 0;
    width = 0;
    left = ($('user_pic').width/2);
    top = ($('user_pic').height/2);
    div.style.opacity = 0.5;
    do_effect(char_id, height, width,left,top,end_color,0);

}


function do_effect(char_id, height, width,left,top,end_color,percent) {
    max = 1.2;
    size = "";
    if ($('user_pic').src.include("_small") != false) {
        size = "_small";
    }
    else if ($('user_pic').src.include("_midi") != false) {
        size = "_midi";
    }
    else {
    }
    cx = $('user_pic').width;
    cy = $('user_pic').height;
    if (percent < max) {
        percent += 0.1;
    }

    div = $('c' + char_id + '_effect_div');
     width = (cx * percent);
    height = (cy * percent);
    div.style.left = (left - (width/2)) + "px";
    div.style.top = (top - (height/2)) + "px";
    div.style.height = height + "px";
    div.style.width = width + "px";
    if (width >= cx ) {
       /* div.style.backgroundColor = end_color;*/
    }
    if (width < (cx * max)) {
        setTimeout('do_effect('+ char_id + ', ' + height + ', ' + width + ', ' + left + ', ' + top + ', \"' + end_color + '\",' + percent + ')', 50);

    }else{
        div.style.height = 0;
            div.style.width = 0;
        div.style.background = "";
            div.style.border = "";

        
    }

}

function hide_element(x){
    setTimeout(x.style.display = 'none',1000) ;
}