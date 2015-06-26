% include('_header.tpl')

<div class="row">
    <div class="col-md-12">
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
    <div class="col-md-12">
        <pre id="editor"></pre>
        <div id="statusBar"></div>
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
                {name:'beee1', value:'beee1', score:300, meta:'test'},
                {name:'beee1', value:'beee2', score:300, meta:'test'},
                {name:'deneme3', value:'deee1', score:300, meta:'test'},
                {name:'deneme4', value:'deee2', score:300, meta:'test'},
                {name:'deneme5', value:'deee3', score:300, meta:'test'}
            ]);
        }
    };
    langTools.addCompleter(customCompleter);
</script>

<script>
    $(document).ready(function(){
       $('#btn-exec').click(function(){
           var sql = editor.getSession().getValue();
           alert(sql);
           $.post( "/execsql",
                   { sql: "getNameAndTime" },
                   function( data ) {
                       console.log( data.name );
                       console.log( data.time );
                   },
                   "json");
       });
    });
</script>
