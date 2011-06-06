window.onkeydown =
        function(event) {
            // normalize event
            event = event || window.event;
            //alert(event.keyCode);
            if ((event.keyCode >= 96) && (event.keyCode <= 105)) {
                var x = $("calc_result").value.toString() + (event.keyCode - 96).toString();
                $("calc_result").value = x;
            }

            if (event.keyCode == 81) // q
            {
                toggle_quests();

            }
            if (event.keyCode == 67) // c
            {
                toggle_inventar();

            }
            if (event.keyCode == 69) // e
            {
                toggle_enhancements();
            }
        };
function toggle_quests() {
    if ($("quests").style.height == "35px") {
        $("quests").style.height = "";
        new Effect.Appear('quests_table');
        document.cookie = 'quests=displayed;';
    }
    else {
        $("quests").style.height = "35px";
        $("quests_table").style.display = "none";
        document.cookie = 'quests=hidden;';
    }
}
function toggle_inventar() {
    if ($("inventar").style.height == "35px") {
        $("inventar").style.height = "";
        new Effect.Appear('inventar_table');
        document.cookie = 'character=displayed;';
    }
    else {
        $("inventar").style.height = "35px";
        $("inventar_table").style.display = "none";
        document.cookie = 'character=hidden;';
    }
}
function toggle_enhancements() {
    if ($("enhancements").style.height == "35px") {
        $("enhancements").style.height = "";
        new Effect.Appear('enhancements_table');
        document.cookie = 'enhancements=displayed;';
    }
    else {
        $("enhancements").style.height = "35px";
        $("enhancements_table").style.display = "none";
        document.cookie = 'enhancements=hidden;';
    }
}