<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{obj}}<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/tools/query/{{db}}?table={{obj}}">Select from...</a></li>
        <li class="divider"></li>
        <li><a href="#">Edit Table</a></li>
        <li><a href="#">New Field</a></li>
        <li><a href="#">New Trigger</a></li>
        <li><a href="#">New Index</a></li>
        <li><a href="#">New Foreign Key</a></li>
        <li><a href="#">New Uniqe Constraint</a></li>
        <li><a href="#">New Check Constraint</a></li>
        <li class="divider"></li>
        <li><a a href="/tools/script/{{db}}?typ=table&name={{obj}}&ddl=trigger_disable">Disable All Triggers</a></li>
        <li><a href="/tools/script/{{db}}?typ=table&name={{obj}}&ddl=trigger_enable">Enable All Triggers</a></li>
        <li class="divider"></li>
        <li><a href="/tools/script/{{db}}?typ=table&name={{obj}}&ddl=index_recompute">Disable All Indices</a></li>
        <li><a href="/tools/script/{{db}}?typ=table&name={{obj}}&ddl=index_enable">Enable All Indices</a></li>
        <li><a href="/tools/script/{{db}}?typ=table&name={{obj}}&ddl=index_recompute">Recompute All Indices</a></li>
        <li class="divider"></li>
        <li><a href="/tools/script/{{db}}?typ=table&name={{obj}}&ddl=drop">Drop Table</a></li>
    </ul>
</li>
