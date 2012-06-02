var talks = {};
var bookmarksOnly = false;

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
        data.sort(sortByDateStartAndRoom);
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
            content += "Le " + start.getDate() + " à " + start.getUTCHours() + ":" + minutes  + " - ";
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

function sortByDateStartAndRoom(a, b){
  var aStart = a.start;
  var bStart = b.start;
  //return ((aStart < bStart) ? -1 : ((aStart > bStart) ? 1 : 0));
  return ((aStart < bStart) ? -1 : ((aStart > bStart) ? 1 : ((a.room > b.room) ? 1 : 0) ));
}


/** Programme version Mobile. */
function loadMobileProgramme(vBookmarksOnly) {
    var content = "";
    bookmarksOnly = vBookmarksOnly;
    $('#mobileMsg').html("");

    loadJsonTalks();

    var day = "";
    var oldHours = null;
    var firstLine = true;
    var hours = null;

    $('#linesMobile').html("");

    $.each(talks, function (key, talk) {

        if (bookmarksOnly &&  localStorage['talk' + talk.id] != "true") {
            return true; // equivalent to 'continue' with a normal for loop
        }
        start =  new Date(talk.start);

        if (day == "") {
            day = start.getDate();
        }

        if (day != start.getDate()) {
            lineMobile($('#linesMobile'), oldStart, content, day, firstLine, hours);
            day = start.getDate();
            firstLine = false;
            content = "";
        }

        minutes = start.getMinutes();
        if (minutes <= 0) minutes = "00";

        if (oldHours != start.getUTCHours()) {
            hours = start.getUTCHours() + "h" + minutes;
            console.log(hours);
        }

        content += "<li class='row-fluid'>";
        if (hours != null) {
            content += '<div>'+hours+'</div>';
        }
        content += "<div class='span1'><a href='/talk/"+ talk.id +".htm'>";

        if (talk.room != null) {
            content += talk.room;
        }
        content +=  " - " + talk.title;

        if (localStorage['talk' + talk.id] == "true") {
            content += " <img src='/static/img/etoile_pleine.png'>";
        }
        content += " </a><div></li>";

        oldStart =  new Date(talk.start);
        oldHours =  start.getUTCHours();
        hours = null;

    });

    // last line
    lineMobile($('#linesMobile'), start, content, day, firstLine, hours);

    if (content == "" && bookmarksOnly) {
        $('#mobileMsg').html("Vous n'avez pas (encore) positionné de talks favoris.");
        $('#linesMobile').html("");
    } else if (content == "") {
        content = "Erreur lors du chargement des talks";
        $('#mobileProgramme').html(content);
    }
}

function btnFavoris() {
    $('#favOnly').click(function() {

        loadMobileProgramme(bookmarksOnly==false)

        if (bookmarksOnly == false) {
            $('#favOnly').html("Afficher vos favoris");

        } else {
            $('#favOnly').html("Afficher tout");

        }
    });
}

function lineMobile(root, startDate, content, day, firstLine) {
    console.log('Enter ' + day);
    var html = ""
    var first = "";
    var firstHeight = "0px";
    var title = "Le " + startDate.getDate() + "/" + (startDate.getMonth() + 1) + "/" + startDate.getFullYear();

    if (firstLine) {
        first = "in";
        firstHeight = "auto";
    }

    html += '<div class="accordion-group">';
    html += '<div class="accordion-heading">';
    html += '<a class="accordion-toggle" data-toggle="collapse" data-parent="#linesMobile" href="#collapse' + day + '">';
    html += title;
    html += '</a>';
    html += '</div>';
    html += '<div id="collapse' + day + '" class="accordion-body '+first+' collapse" style="height: ' + firstHeight + '; ">';

    html += '<div class="accordion-inner">';
    html += '<ul class="nav nav-list">';
    html += content;
    html += '</ul>'
    html += '</div>';
    html += '</div>';
    html += '</div>';

    root.append(html);
}