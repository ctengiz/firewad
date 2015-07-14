% include('_header.tpl')


<div>

    <div class="btn-toolbar" role="toolbar" style="margin-bottom: 2px;" id="toolbar">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" type="button" id="btn-plan" title="Get execution plan">
                <i class="fa fa-crosshairs"></i>
            </button>
            <button class="btn btn-default" type="button" id="btn-exec" title="Execute query">
                <i class="fa fa-play"></i>
            </button>
            <button class="btn btn-default" type="button" id="btn-fetch-all" title="Execute and fetch all">
                <i class="fa fa-fast-forward"></i>
            </button>
            <button class="btn btn-default" type="button" id="btn-refresh">
                <i class="fa fa-refresh"></i>
            </button>
        </div>
        <!-- todo:
        <div class="btn-group btn-group-sm">
            <div class="btn-group btn-group-sm" role="group">
                <button type="button" class="btn btn-default dropdown-toggle"
                        data-toggle="dropdown"
                        aria-haspopup="true"
                        aria-expanded="false"
                        title="Download data">
                    <i class="fa fa-download"></i>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="#"><i class="fa fa-file-excel-o"></i> Excel</a></li>
                    <li><a href="#">Csv</a></li>
                </ul>
            </div>

            <button class="btn btn-default" type="button">
                <i class="fa fa-print"></i>
            </button>
        </div>
        -->
    </div>

    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist" id="tabs">
        <li role="presentation" class="active"><a href="#sql" aria-controls="sql" role="tab" data-toggle="tab">Sql</a></li>
        <li role="presentation"><a href="#data" aria-controls="data" role="tab" data-toggle="tab">Data</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content" style="margin-bottom: 5px;">
        <div role="tabpanel" class="tab-pane active" id="sql">
            <div class="row">
                <div class="col-sm-12">
                    <pre id="editor">{{sql_select}}</pre>
                    <pre id="statusBar"></pre>
                </div>
            </div>
        </div> <!-- sql tab panel -->

        <div role="tabpanel" class="tab-pane" id="data">
            <div style="height: 420px; overflow: auto;" id="data-grid-container">
                <table id="table" class="table table-bordered table-condensed"></table>
            </div>
        </div>
    </div>

    <div class="alert alert-danger alert-dismissible" role="alert" id="error-panel" style="margin-bottom: 3px; display:none;">
        <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <span id="error-panel-text">

        </span>
    </div>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Query Plan
        </div>
        <div class="panel-body">
            <pre id="sql-plan"></pre>
        </div>
    </div>

    <div class="panel panel-warning" style="display: none;">
        <div class="panel-heading">
            Parameters
        </div>
        <div class="panel-body form-horizontal" id="params">
        </div>
        <div class="panel-footer">
            <button class="btn btn-default" type="button" id="btn-exec-param" title="Execute query">
                <i class="fa fa-play"></i>
            </button>
            <button class="btn btn-default" type="button" id="btn-fetch-all-param" title="Execute and fetch all">
                <i class="fa fa-fast-forward"></i>
            </button>
        </div>
    </div>
</div>


<!-- Static Modal -->
<!-- Source : http://bootsnipp.com/snippets/featured/centered-processing-modal -->
<div class="modal modal-static fade" id="processing-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <!--
                    <img src="http://www.travislayne.com/images/loading.gif" class="icon" />
                    -->
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                            <!--<span class="sr-only">45% Complete</span>-->
                        </div>
                    </div>
                    <h4>
                        Executing sql
                        <!-- <button type="button" class="close" style="float: none;" data-dismiss="modal" aria-hidden="true">×</button> -->
                    </h4>
                </div>
            </div>
        </div>
    </div>
</div>

% include('_footer.tpl')

<script type="text/template" id="param-template">
    <div class="form-group"><label class="col-sm-3 control-label">{param}</label>
        <div class="col-sm-9">
            <input class="form-control input-xs prm" name="{param}" id="prm-{param}">
        </div>
    </div>
</script>

<script src="/static/ace/ace.js"></script>
<script src="/static/ace/ext-language_tools.js"></script>
<script src="/static/ace/ext-statusbar.js"></script>

<script src="/static/jquery.floatThead.min.js"></script>



<script type="text/javascript">
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
            url: "/tools/query/{{db}}",
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

    $(document).ready(function(){
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
    });


</script>


