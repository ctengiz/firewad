var db = "";
var refresh_object = "";

var params_parsed = false;
var params_entered = false;

var editor = ace.edit("editor");

var langTools = ace.require("ace/ext/language_tools");

var StatusBar = ace.require("ace/ext/statusbar").StatusBar;
// create a simple selection status indicator
var statusBarI = new StatusBar(editor, document.getElementById("statusBar"));

editor.setTheme("ace/theme/tomorrow_night_blue");
editor.getSession().setMode("ace/mode/sql");

// enable autocompletion and snippets
editor.setOptions({
    enableBasicAutocompletion: true,
    enableSnippets: true,
    enableLiveAutocompletion: false
});

editor.on('change', function() {
    params_parsed = false;
    params_entered = false;
});

editor.focus();

/*
 var customCompleter = {
 getCompletions: function(editor, session, pos, prefix, callback) {
 if (prefix.length === 0) { callback(null, []); return }
 callback(null, [
 %for k in appconf.ddl[db]['tables']:
 {name: '{{k}}', value: '{{k}}', score:300, meta:'tables'},
 %end
 %for k in appconf.ddl[db]['views']:
 {name: '{{k}}', value: '{{k}}', score:300, meta:'tables'},
 %end
 %for k in appconf.ddl[db]['procedures']:
 {name: '{{k}}', value: '{{k}}', score:300, meta:'tables'},
 %end

 ]);
 }
 };
 langTools.addCompleter(customCompleter);
 */

var build_table=function(rslt) {
    $("#table").floatThead('destroy');
    $("#table").html('');

    var thead = '';
    for (var i in rslt.columns) {
        thead = thead +
            '<th>' +
            rslt.columns[i].field +
                /*'<div>' + rslt.columns[i].field + '</div>' + */
            '</th>'
    }
    thead = '<thead><tr>' + thead + '</tr></thead>';

    var tbody = '';
    for (var i in rslt.data) {
        tbody = tbody + '<tr>';
        for (var col in rslt.columns) {
            tbody = tbody + '<td>' + rslt.data[i][rslt.columns[col].field] + '</td>'
        }
        tbody = tbody + '</tr>';
    }
    tbody = '<tbody>' + tbody + '</tbody>';

    $("#table").html(thead + tbody);

    $('a[href="#data"]').tab('show');

    $("#table").floatThead({
        scrollContainer: function($table){
            return $table.closest('#data-grid-container');
        }
    });

};

var parse_params = function(sql) {
    params_parsed = true;

    $("#params").parent().hide();
    sql = sql || editor.getSession().getValue();

    var re = /":[_a-zA-Z0-9]+"|':[_a-zA-Z0-9]+'|(:[_a-zA-Z0-9]+)/g;

    var params = sql.match(re) || [];

    var param_html = '';
    for (var i = 0; i < params.length; i++) {
        param_html = param_html +
            templateParamString($("#param-template").html(), {param: params[i]});
    }
    $("#params").html(param_html);

    if (params.length > 0) {
        params_entered = false;
        $("#params").parent().show();
        $('html, body').animate({
            scrollTop: $("#params").offset().top
        }, 1000);
        return true;
    } else {
        params_entered = true;
        $("#params").parent().hide();
    }
};

var exec_sql=function(exec_typ, limit) {
    var sql = editor.getSession().getValue();

    var post_data = {
        sql: sql,
        exec_typ: exec_typ,
        limit: limit,
        params: {}
    };

    if (params_entered) {
        $('.prm').each(function(el){
            post_data.params[$(this).attr("name")] = $(this).val();
        });
    }

    $.ajax({
        method: "POST",
        url: "/tools/query/" + db,
        data: post_data,
        dataType: "json",
        beforeSend: function() {
            $('#processing-modal').modal('show');
            $("#plan-sql").text('');

            $("#error-panel").hide();
        },
        error: function (e) {
            $("#error-panel").show();
            $("#error-panel-text").html(e.responseText);
        }
    }).done(function(rslt, textStatus, jqXH){
        $("#sql-plan").text(rslt.plan);

        if ((exec_typ == 'fetch') || (exec_typ == 'fetch_all')) {
            build_table(rslt.tdata);
        }

    }).fail(function(){

    }).always(function () {
        $('#processing-modal').modal('hide');

    })
};

var exec_script=function(exec_typ, limit) {
    var sql = editor.getSession().getValue();

    var post_data = {
        sql: sql,
        auto_commit: $('#btn-commit-type').data('pressed'),
        refresh: refresh_object
    };

    $.ajax({
        method: "POST",
        url: "/tools/script/" + db,
        data: post_data,
        dataType: "json",
        beforeSend: function() {
            $('#processing-modal').modal('show');

            $("#error-panel").hide();
            $('#result-panel-action').hide();
            $("#result-panel").hide();
        },
        error: function (e) {
            $("#error-panel").show();
            $("#error-panel-text").text(e.responseText);
        }
    }).done(function(rslt, textStatus, jqXH){
        $("#result-panel").show();
        $("#result-panel-text").html(rslt.result);

        if (rslt.trn_id) {
            $('.trn-action').data('trn_id', rslt.trn_id);
            $('#result-panel-action').show();
        }

        if (rslt.errors.length > 0) {
            $("#error-panel").show();
            var error_text = '';
            for (var i = 0; i < rslt.errors.length; i++) {
                error_text = error_text + '<br/>' + rslt.errors[i];
            }
            $("#error-panel-text").html(error_text);
        }
    }).fail(function(){

    }).always(function () {
        $('#processing-modal').modal('hide');
    })
};


$(document).ready(function(){
    db = $("#db").text();
    refresh_object = $("#refresh_object").text();


    $('#btn-commit-type').on('click', function () {
        if ($(this).data('pressed') == '0') {
            $(this).data('pressed', '1');
            $(this).addClass('btn-warning');
            $(this).removeClass('btn-default');
        } else {
            $(this).data('pressed', '0');
            $(this).removeClass('btn-warning');
            $(this).addClass('btn-default');
        }

        $(this).button($(this).data('pressed'));
    });

    $('#btn-script').click(function(){
        exec_script('fetch');
    });

    $('#btn-exec').click(function(){
        if (!params_parsed) {parse_params()}
        if (params_entered) {
            exec_sql('fetch');
            $('html, body').animate({
                scrollTop: $("#toolbar").offset().top - 50
            }, 200);

        } else {
            params_entered = true;
        }
    });

    $('#btn-exec-param').click(function(){
        $('#btn-exec').click();
    });

    $("#btn-refresh").click(function() {
        $('#btn-exec').click();
    });

    $('#btn-plan').click(function(){
        parse_params();
        exec_sql('plan')
    });

    $('.alert .close').click(function(){
        $(this).parent().hide();
    });


    $('.trn-action').click(function() {
        var post_data = {
            action: $(this).data('action'),
            trn_id: $(this).data('trn_id'),
            auto_commit: $('#btn-commit-type').data('pressed'),
            refresh: refresh_object
        };

        $.ajax({
            method: "POST",
            url: "/tools/script/" + db,
            data: post_data,
            dataType: "json",
            beforeSend: function() {
                $('#processing-modal').modal('show');

                $("#error-panel").hide();
                $('#result-panel-action').hide();
                $("#result-panel").hide();
            },
            error: function (e) {
                $("#error-panel").show();
                $("#error-panel-text").text(e.responseText);
            }
        }).done(function(rslt, textStatus, jqXH){
            $('.trn-action').data('trn_id', null);

            $("#result-panel").show();
            $("#result-panel-text").html(rslt.result);

            if (rslt.errors.length > 0) {
                $("#error-panel").show();
                var error_text = '';
                for (var i = 0; i < rslt.errors.length; i++) {
                    error_text = error_text + '<br/>' + rslt.errors[i];
                }
                $("#error-panel-text").html(error_text);
            }
        }).fail(function(){

        }).always(function () {
            $('#processing-modal').modal('hide');
        })
    })

});


