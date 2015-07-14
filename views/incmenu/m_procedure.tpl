<!-- Procedure Actions -->
<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
        <i class="fa fa-cogs fa-fw"></i> {{obj}}<b class="caret"></b>
    </a>
    <ul class="dropdown-menu">
        <li><a href="/tools/query/{{db}}?procedure={{obj}}">Select from...</a></li>
        <li><a href="#">Execute</a></li>
        <li class="divider"></li>
        <li><a href="#">Comment Body</a></li>
        <li><a href="#">Uncomment Body</a></li>
        <li class="divider"></li>
        <li><a href="/tools/script/{{db}}?typ=procedure&name={{obj}}&ddl=drop">Drop Procedure</a></li>
    </ul>

</li>
