% include('_header.tpl')


<div style="background-color: snow;">

    <div class="btn-toolbar" role="toolbar" style="margin-bottom: 2px;" id="toolbar">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" type="button" id="btn-commit-type"
                    data-toggle="button"
                    data-pressed="0"
                    data-0-text="Auto Commit: OFF"
                    data-1-text="Auto Commit: ON"
                    >
                Auto Commit: OFF
            </button>
        </div>

        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" type="button" id="btn-exec" title="Execute script">
                <i class="fa fa-bolt"></i>
            </button>
        </div>
    </div>

    <pre id="editor">{{sql_script}}</pre>
    <pre id="statusBar"></pre>

    <div class="alert alert-info alert-dismissible" role="alert" id="result-panel" style="margin-bottom: 3px; display:none;">
        <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <span id="result-panel-text">
        </span>
    </div>

    <div class="alert alert-danger alert-dismissible" role="alert" id="error-panel" style="margin-bottom: 3px; display:none;">
        <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <span id="error-panel-text">
        </span>
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

<script src="/static/ace/ace.js"></script>
<script src="/static/ace/ext-language_tools.js"></script>
<script src="/static/ace/ext-statusbar.js"></script>


<script>
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


    var exec_sql=function(exec_typ, limit) {
        var sql = editor.getSession().getValue();

        var post_data = {
            sql: sql,
            commit: $('#btn-commit-type').data('pressed')
        };

        $.ajax({
            method: "POST",
            url: "/tools/script/{{db}}",
            data: post_data,
            dataType: "json",
            beforeSend: function() {
                $('#processing-modal').modal('show');

                $("#error-panel").hide();
                $("#result-panel").hide();
            },
            error: function (e) {
                $("#error-panel").show();
                $("#error-panel-text").text(e.responseText);
            }
        }).done(function(rslt, textStatus, jqXH){
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
    };

    $(document).ready(function(){
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

        $('#btn-exec').click(function(){
            exec_sql('fetch');
        });

        $('.alert .close').click(function(){
            $(this).parent().hide();
        });
    });


</script>


