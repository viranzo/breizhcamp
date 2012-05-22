

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
    if (localStorage[key] == "false") {
        $('#talk').html("Ce talk ne fait pas partie de vos favoris");
        $('#talk').removeClass('btn-success');
    } else {
        $('#talk').html("Ce talk fait partie de vos favoris");
        $('#talk').addClass('btn-success');
    }
}

