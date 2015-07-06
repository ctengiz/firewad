<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{db}}<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/tools/script/{{db}}?typ=db&ddl=index_recompute">Recompute All Indices</a></li>
        <li><a href="/tools/script/{{db}}?typ=db&ddl=index_enable">Enable All Indices</a></li>
        <li><a href="/tools/script/{{db}}?typ=db&ddl=index_disable">Disable All Indices</a></li>
        <li class="divider"></li>
        <li><a href="/tools/script/{{db}}?typ=db&ddl=trigger_enable">Enable All Triggers</a></li>
        <li><a href="/tools/script/{{db}}?typ=db&ddl=trigger_disable">Disable All Triggers</a></li>
        <li class="divider"></li>
        <li><a href="/db/backup/{{db}}">Backup Database</a></li>
        <li><a href="/db/restore/{{db}}">Restore Database</a></li>
        <li class="divider"></li>
        <li><a href="/db/metadata/{{db}}">Extract Database Metadata</a></li>
        <li class="divider"></li>
        <li><a href="/db/refresh_cache_metadata/{{db}}">Refresh Cached Database Metadata</a></li>
    </ul>
</li>

<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Create<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="#">New Domain</a></li>
        <li><a href="#">New Table</a></li>
        <li><a href="/tools/script/{{db}}?typ=view&ddl=create">New View</a></li>
        <li><a href="#">New Procedure</a></li>
        <li><a href="#">New Trigger</a></li>
        <li><a href="/tools/script/{{db}}?typ=sequence&ddl=create">New Sequence</a></li>
        <li><a href="/tools/script/{{db}}?typ=exception&ddl=create">New Exception</a></li>
        <li><a href="#">New UDF</a></li>
        <li><a href="/tools/script/{{db}}?typ=role&ddl=create">New Role</a></li>
    </ul>
</li>

<li>
    <a href="/mon/{{db}}">Monitor</a>
</li>


<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tools<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/tools/query/{{db}}">Query</a></li>
        <li><a href="/tools/script/{{db}}">Script</a></li>
    </ul>
</li>
