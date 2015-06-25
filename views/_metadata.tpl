<a href="/domains/{{db}}" class="list-group-item menu-root" style="padding-left:5px;">
    <i class="fa fa-chain"></i>Domains <small>({{len(metadata['domains'])}})</small>
</a>

<a href="#menu-table" class="list-group-item menu-root" data-toggle="collapse" style="padding-left:5px;">
    <i class="fa fa-table"></i>Tables <small>({{len(metadata['tables'])}})</small> <span class="glyphicon glyphicon-chevron-right"></span>
</a>
<div class="collapse" id="menu-table">
    %for k in metadata['tables']:
        <a class="list-group-item" href="/table/{{db}}/{{k}}" style="padding-left:15px;">{{k}}</a>
    %end
</div>

<a href="#menu-view" class="list-group-item menu-root" data-toggle="collapse" style="padding-left:5px;">
    <i class="fa fa-list"></i>Views <small>({{len(metadata['views'])}})</small> <span class="glyphicon glyphicon-chevron-right"></span>
</a>
<div class="collapse" id="menu-view">
    %for k in metadata['views']:
        <a class="list-group-item" href="/view/{{db}}/{{k}}" style="padding-left:15px;">{{k}}</a>
    %end
</div>

<a href="#menu-trigger" class="list-group-item menu-root" data-toggle="collapse" style="padding-left:5px;">
    <i class="fa fa-bolt"></i>Triggers <small>({{len(metadata['triggers'])}})</small> <span class="glyphicon glyphicon-chevron-right"></span>
</a>
<div class="collapse" id="menu-trigger">
    %for k in metadata['triggers']:
        <a class="list-group-item" href="/trigger/{{db}}/{{k}}" style="padding-left:15px;">{{k}}</a>
    %end
</div>

<a href="#menu-procedure" class="list-group-item menu-root" data-toggle="collapse" style="padding-left:5px;">
    <i class="fa fa-cogs"></i>Procedures <small>({{len(metadata['procedures'])}})</small> <span class="glyphicon glyphicon-chevron-right"></span>
</a>
<div class="collapse" id="menu-procedure">
    %for k in metadata['procedures']:
        <a class="list-group-item" href="/procedure/{{db}}/{{k}}" style="padding-left:15px;">{{k}}</a>
    %end
</div>

<a href="/sequences/{{db}}" class="list-group-item menu-root" style="padding-left:5px;">
    <i class="fa fa-sort-numeric-asc"></i>Sequences <small>({{len(metadata['sequences'])}})</small>
</a>

<a href="/indices/{{db}}" class="list-group-item menu-root" style="padding-left:5px;">
    <i class="fa fa-arrows-v"></i>Indices <small>({{len(metadata['indices'])}})</small>
</a>

<a href="/constraints/{{db}}" class="list-group-item menu-root" style="padding-left:5px;">
    <i class="fa fa-lock"></i>Constraints <small>({{len(metadata['constraints'])}})</small>
</a>

<a href="#menu-function" class="list-group-item menu-root" data-toggle="collapse" style="padding-left:5px;">
    <i class="fa fa-cog"></i>Functions <small>({{len(metadata['functions'])}})</small> <span class="glyphicon glyphicon-chevron-right"></span>
</a>
<div class="collapse" id="menu-function">
    %for k in metadata['functions']:
        <a class="list-group-item" href="/function/{{db}}/{{k}}" style="padding-left:15px;">{{k}}</a>
    %end
</div>

<a href="/exceptions/{{db}}" class="list-group-item menu-root"  style="padding-left:5px;">
    <i class="fa fa-exclamation-triangle"></i>Exceptions <small>({{len(metadata['exceptions'])}})</small>
</a>
