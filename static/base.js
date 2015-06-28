/**
 * Created by cagataytengiz on 10.02.15.
 */

$(document).ready(function(){
    $('[data-toggle=offcanvas]').click(function () {
        $('.row-offcanvas').toggleClass('active');
        $(this).toggleClass('fa-angle-double-left fa-angle-double-right');

        //a very dirty hack for fixed table header
        try {
            var h = $("#data-grid-container").height();
            //$("#data-grid-container").height(h + 10);
        } catch (e) {
            //alert(e.message);
        }
    });

    //Main screen db select
    $("#nav-db-select").change(function () {
        var str = $("#nav-db-select option:selected").text();
        window.location = '/db/' + str;
        return false;
    });

    //Tooltip
    $("[data-toggle='tooltip']").tooltip();
});