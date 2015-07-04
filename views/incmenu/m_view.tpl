<!-- View Actions -->
<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{obj}}<b class="caret"></b></a>
    <ul class="dropdown-menu">
        <li><a href="/tools/query/{{db}}?view={{obj}}">Select from...</a></li>
        <li class="divider"></li>
        <li><a href="/tools/script/{{db}}?typ=view&name={{obj}}&ddl=drop">Drop View</a></li>
    </ul>
</li>
