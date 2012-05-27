var talks = {};

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
        $('#talk').html("Ce talk fait partie de vos favoris <img src='/static/img/etoile_pleine.png' />");

        $('#talk').addClass('btn-success');
    } else {
        $('#talk').html("Ce talk ne fait pas partie de vos favoris <img src='/static/img/etoile_vide.png' />");
        $('#talk').removeClass('btn-success');
    }
}


/* Gestion des talks favoris sur la page calendar. */
function initFavorisOnCalendar() {
    $.each( talks, function(k, talk){
        var key = 'talk' + talk.id;
        if (localStorage[key] == "true") {
            $("#talk-fav-" + talk.id).html($("#talk-fav-" + talk.id).html() + " <img src='/static/img/etoile_pleine.png' title='Ce talk est un de vos talks favoris' />");
        }
    });

}

/* Gestion de la page des Bookmarks. */
function loadJsonTalks() {
    console.log('talks loading...');
    $.ajaxSetup({'async': false});
    $.getJSON('talks.json?time=' + (new Date().getTime()), function (data) {
        data.sort(sortByDateStart);
        var i = 0; // pas d'utilisation de talk.id en cle, pour ne pas perdre le sort
        $.each(data, function (key, talk) {
            talks[i++] = talk;
        });
        console.log('talks loaded');
	}).error(function() { console.log("une erreur est survenue au chargement des talks"); })
	;
	$.ajaxSetup({'async': true});
}

function loadBookmarksPage() {
    var content = "";

    loadJsonTalks();

    $.each(talks, function (key, talk) {
        if (localStorage['talk' + talk.id] == "true") {
            start =  new Date(talk.start);
            minutes = start.getMinutes();
            if (minutes <= 0) minutes = "00";
            content += "<li><a href='/talk/"+ talk.id +".htm'>";
            content += "Le " + start.getDate() + " à " + start.getHours() + ":" + minutes  + " - ";
            content += talk.room + " - " + talk.title;
            content += " </a></li>"
        }
    });

    if (content == "") {
        content += "Vous n'avez pas (encore) positionné de talks favoris.";
    } else {
        content = " <h4>Mes talks favoris :</h4> <ul>" + content + "</ul>";
    }

    $('#bookmarks-page-content').html(content);
}

function sortByDateStart(a, b){
  var aStart = a.start;
  var bStart = b.start;
  return ((aStart < bStart) ? -1 : ((aStart > bStart) ? 1 : 0));
}


function loadMobileProgramme() {
    var content = "";

    loadJsonTalks();

    $.each(talks, function (key, talk) {
        start =  new Date(talk.start);
        minutes = start.getMinutes();
        if (minutes <= 0) minutes = "00";
        content += "<li><a href='/talk/"+ talk.id +".htm'>";
        content += "Le " + start.getDate() + " à " + start.getHours() + ":" + minutes  + " - ";
        content += talk.room + " - " + talk.title;
        if (localStorage['talk' + talk.id] == "true") {
            content += " <img src='/static/img/etoile_pleine.png'>";
        }
        content += " </a></li>"
    });

    if (content == "") {
        content += "Erreur lors du chargement des talks";
    }
    $('#mobileProgramme').html(content);
}
