/**
 * Created by cagataytengiz on 10.02.15.
 */


var slug = function(str) {
    //Source : http://stackoverflow.com/questions/1053902/how-to-convert-a-title-to-a-url-slug-in-jquery

    str = str.replace(/^\s+|\s+$/g, ''); // trim
    str = str.toLowerCase();

    // remove accents, swap ñ for n, etc
    var from = "ãàáäâẽèéëêìíïîõòóöôùúüûñçığşç·/_,:;";
    var to   = "aaaaaeeeeeiiiiooooouuuuncigsc______";
    for (var i=0, l=from.length ; i<l ; i++) {
        str = str.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
    }

    str = str.replace(/[^a-z0-9 -_.]/g, '') // remove invalid chars
        .replace(/\s+/g, '_') // collapse whitespace and replace by -
        .replace(/-+/g, '-'); // collapse dashes

    return str;
};

var templateString = function(tstr, prm) {
    tstr = tstr.replace(/{[^{}]+}/g, function(key){
        return prm[key.replace(/[{}]+/g, '')] || "";
    });
    return tstr;
};

var templateParamString = function(tstr, prm) {
    tstr = tstr.replace(/{[^{}]+}/g, function(key){
        return prm[key.replace(/[{}]+/g, '')].replace(':', '') || "";
    });
    return tstr;
};

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



    //Database objects description edit
    $(".edit-description").click(function() {
        var object = $(this).data("object");
        var object_name = $(this).data("object_name");
        var description = $(this).data("description");
        var db = $(this).data("db");

        bootbox.prompt({
            title: "Description for " + object_name,
            value: description,
            callback: function(result) {
                if (result === null) {

                } else {
                    window.location="/tools/script/"
                    + db + '?'
                    + "typ=" + object + ';'
                    + "name=" + object_name + ';'
                    + "ddl=description;"
                    + "description=" + result;
                }
            }
        });


    })
});