
/* Pourquoi encore utiliser IE ?. */
NavName = navigator.appName;
if ( NavName == "Microsoft Internet Explorer") {
    window.location="/error/notie.htm";
}

/* Gestion du konami code.*/
jQuery(function() {
    var kKeys = [];
    function Kpress(e) {
        kKeys.push(e.keyCode);
        if (kKeys.toString().indexOf("38,38,40,40,37,39,37,39,66,65") >= 0) {
            jQuery(this).unbind('keydown', Kpress);
            kExec();
        }
    }
    jQuery(document).keydown(Kpress);
});

function kExec(){
    $('html').css({"background":"url('/static/BreizhCamp_invert.png') no-repeat top center"});
}

function setActive(id){
    $("#" + id).addClass("active");
}

/* Gestion des talks favoris sur la page de Talk. */
function initFavoris() {

    $('#talk').click(
        function () {
            var id = parseInt($(this).attr('id_talk'));
            var key = 'talk' + id;

            if (localStorage[key] == "true") {
                localStorage[key] = 'false';
            } else {
                localStorage[key] = 'true';
            }
            initTalkOnTalkPage(id);

    });
}

function initTalkOnTalkPage(id_talk) {
    var key = 'talk' + id_talk;
    if (localStorage[key] == "true") {
        $('#talk').html("Ce talk fait partie de vos favoris");
        $('#talk').addClass('btn-success');
    } else {
        $('#talk').html("Ce talk ne fait pas partie de vos favoris");
        $('#talk').removeClass('btn-success');
    }
}


/* Gestion des talks favoris sur la page calendar. */
function initFavorisOnCalendar(talks) {
    $.each( talks, function(k, id_talk){
        var key = 'talk' + id_talk;
        if (localStorage[key] == "true") {
            $("#" + id_talk).html($("#" + id_talk).html() + " <i class='icon-star'></i>");
        }
    });

}
