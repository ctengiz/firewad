<form method="post">
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

    <!-- todo
    <div class="radio"><label><input type="radio" name="create_or_connect" value="create" checked> Create Database</label></div>
    <div class="radio"><label><input type="radio" name="create_or_connect" value="connect"> Connect Database </label></div>
    <div class="checkbox"><label><input type="checkbox" name="include_password" checked="checked" value="1"> Include Password</label></div>
    -->

    <button value="submit" class="btn btn-primary">
        <span class="glyphicon glyphicon-alert"></span> Extract
    </button>
</form>