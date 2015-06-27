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
                    <pre id="editor">select * from usr</pre>
                    <div id="statusBar"></div>
                </div>
            </div>
        </div> <!-- sql tab panel -->

        <div role="tabpanel" class="tab-pane" id="data">
            <div class="row">
                <div class="col-sm-12">
                    <table id="table"></table>
                </div>
            </div>
        </div>
    </div>
</div>




% include('_footer.tpl')


<script src="/static/ace/ace.js" type="text/javascript" charset="utf-8"></script>
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
            }).done(function(data, textStatus, jqXH){
                $("#table").bootstrapTable(data
                );
                $('#data').tab('show');
            }).error(function(){

            }).always(function () {

            })
        });
    });



</script>
