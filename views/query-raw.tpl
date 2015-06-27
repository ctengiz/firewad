% include('_header.tpl')


<div style="background-color: snow;">


    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#sql" aria-controls="sql" role="tab" data-toggle="tab">Sql</a></li>
        <li role="presentation"><a href="#data" aria-controls="data" role="tab" data-toggle="tab">Data</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="sql">
            <div class="row">
                <div class="col-sm-12">
                    <div class="btn-toolbar" role="toolbar">
                        <div class="btn-group">
                            <button class="btn btn-default" type="button" id="btn-exec">Exec</button>
                            <button class="btn btn-default" type="button">y</button>
                            <button class="btn btn-default" type="button">z</button>
                            <button class="btn btn-default" type="button">t</button>
                        </div>
                        <div class="btn-group">
                            <button class="btn btn-default" type="button">x</button>
                            <button class="btn btn-default" type="button">y</button>
                            <button class="btn btn-default" type="button">z</button>
                            <button class="btn btn-default" type="button">t</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <pre id="editor">select * from acbankslip</pre>
                    <div id="statusBar"></div>
                </div>
            </div>
        </div> <!-- sql tab panel -->

        <div role="tabpanel" class="tab-pane" id="data">
            <div style="height: 400px; overflow: auto;" id="ahead">
                <table id="table" class="table table-bordered table-condensed"></table>
            </div>
        </div>
    </div>
</div>

% include('_footer.tpl')

<script src="/static/ace/ace.js"></script>
<script src="/static/ace/ext-language_tools.js"></script>
<script src="/static/ace/ext-statusbar.js"></script>

<script src="/static/jquery.floatThead.min.js"></script>



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
</script>

<script>
    $(document).ready(function(){
        $('#btn-exec').click(function(){
            var sql = editor.getSession().getValue();
            $.ajax({
                method: "POST",
                url: "/tools/query/{{db}}",
                data: {sql: sql},
                dataType: "json",
                error: function () {
                    alert("errror")
                }
            }).done(function(rslt, textStatus, jqXH){

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
                        return $table.closest('#ahead');
                    }
                });

            }).error(function(){

            }).always(function () {

            })
        });
    });



</script>
