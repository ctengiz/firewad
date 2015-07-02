<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Extract Database Metadata</li>
        </ol>
    </div>
</div>

<div class="panel panel-default">
    <form method="post">
        <div class="panel-body">
            <fieldset id="objects">
                <legend><h4>Available Objects</h4></legend>
                <div class="checkbox"><label><input type="checkbox" name="domain" checked="checked" value="1"> Domains</label></div>
                <div class="checkbox"><label><input type="checkbox" name="table" checked="checked" value="1"> Tables</label></div>
                <div class="checkbox"><label><input type="checkbox" name="view" checked="checked" value="1"> Views</label></div>
                <div class="checkbox"><label><input type="checkbox" name="procedure" checked="checked" value="1"> Procedures</label></div>
                <div class="checkbox"><label><input type="checkbox" name="trigger" checked="checked" value="1"> Triggers</label></div>
                <div class="checkbox"><label><input type="checkbox" name="sequence" checked="checked" value="1"> Sequences</label></div>
                <div class="checkbox"><label><input type="checkbox" name="index" checked="checked" value="1"> Indices</label></div>
                <div class="checkbox"><label><input type="checkbox" name="function" checked="checked" value="1"> Functions</label></div>
                <div class="checkbox"><label><input type="checkbox" name="exception" checked="checked" value="1"> Exception</label></div>
                <div class="checkbox"><label><input type="checkbox" name="role" checked="checked" value="1"> Roles</label></div>
                <div class="checkbox"><label><input type="checkbox" name="grant" checked="checked" value="1"> Privileges</label></div>
            </fieldset>

            <fieldset>
                <legend>Database Statement</legend>
                <div class="radio"><label><input type="radio" name="create_or_connect" value="create" checked> Create Database</label></div>
                <div class="radio"><label><input type="radio" name="create_or_connect" value="connect"> Connect Database </label></div>
                <div class="radio"><label><input type="radio" name="create_or_connect" value="none"> No connect or create statement </label></div>
                <div class="checkbox"><label><input type="checkbox" name="include_password" checked="checked" value="1"> Include Password</label></div>
            </fieldset>

            <fieldset>
                <legend>Output</legend>
                <div class="radio"><label><input type="radio" name="output" value="screen" checked> To screen</label></div>
                <div class="radio"><label><input type="radio" name="output" value="script" > To script</label></div>
                <div class="radio"><label><input type="radio" name="output" value="file"> As File</label></div>
            </fieldset>

        </div>

        <div class="panel-footer">
            <button value="submit" class="btn btn-primary">
                <span class="glyphicon glyphicon-download-alt"></span> Extract
            </button>
        </div>
    </form>
</div>
