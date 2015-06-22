/**
 * Created by cagataytengiz on 10.02.15.
 */

$(document).ready(function(){
    $('[data-toggle=offcanvas]').click(function () {
        $('.row-offcanvas').toggleClass('active');
        $(this).toggleClass('fa-angle-double-left fa-angle-double-right');
    });
});