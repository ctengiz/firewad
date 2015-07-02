<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{db}}<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/db/recompute_all/{{db}}">Recompute All Indices</a></li>
        <li class="divider"></li>
        <li><a href="/db/enable_all_triggers/{{db}}">Enable All Triggers</a></li>
        <li><a href="/db/disable_all_triggers/{{db}}">Disable All Triggers</a></li>
        <li class="divider"></li>
        <li><a href="/db/backup/{{db}}">Backup Database</a></li>
        <li><a href="/db/restore/{{db}}">Restore Database</a></li>
        <li class="divider"></li>
        <li><a href="/db/refresh_cache_metadata/{{db}}">Refresh Cached Database Metadata</a></li>
        <li><a href="/db/metadata/{{db}}">Export Database Metadata</a></li>
    </ul>
</li>

<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Create<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/admin/client">New Domain</a></li>
        <li><a href="/admin/user">New Table</a></li>
        <li><a href="/admin/usrgrp">New View</a></li>
        <li><a href="/admin/role">New Procedure</a></li>
        <li><a href="/admin/dfcategory">New Trigger</a></li>
        <li><a href="/admin/dfstatus">New Generator</a></li>
        <li><a href="/admin/dfpriority">New Exception</a></li>
        <li><a href="/admin/dfflow">New UDF</a></li>
        <li><a href="/admin/dfreltype">New Role</a></li>
    </ul>
</li>

<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tools<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/tools/query/{{db}}">Query</a></li>
        <li><a href="/tools/script/{{db}}">Script</a></li>
    </ul>
</li>
