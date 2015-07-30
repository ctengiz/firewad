<div class="btn-toolbar" role="toolbar" style="margin-bottom: 2px;" id="toolbar">

    %if extyp == 'script':
    <div class="btn-group btn-group-sm">
        <button class="btn btn-warning" type="button" id="btn-commit-type"
                data-toggle="button"
                data-pressed="0"
                data-0-text="Auto Commit: OFF"
                data-1-text="Auto Commit: ON"
                >
            Auto Commit: OFF
        </button>
    </div>

    <div class="btn-group btn-group-sm">
        <button class="btn btn-danger" type="button" id="btn-script" title="Execute script">
            <i class="fa fa-bolt"></i> Execute
        </button>
    </div>
    %end

    %if extyp == 'query':
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" type="button" id="btn-plan" title="Get execution plan">
            <i class="fa fa-crosshairs"></i>
        </button>
        <button class="btn btn-default" type="button" id="btn-exec" title="Execute query">
            <i class="fa fa-play"></i>
        </button>
        <button class="btn btn-default" type="button" id="btn-fetch-all" title="Execute and fetch all">
            <i class="fa fa-fast-forward"></i>
        </button>
        <button class="btn btn-default" type="button" id="btn-refresh">
            <i class="fa fa-refresh"></i>
        </button>
    </div>
    <!-- todo:
    <div class="btn-group btn-group-sm">
        <div class="btn-group btn-group-sm" role="group">
            <button type="button" class="btn btn-default dropdown-toggle"
                    data-toggle="dropdown"
                    aria-haspopup="true"
                    aria-expanded="false"
                    title="Download data">
                <i class="fa fa-download"></i>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#"><i class="fa fa-file-excel-o"></i> Excel</a></li>
                <li><a href="#">Csv</a></li>
            </ul>
        </div>

        <button class="btn btn-default" type="button">
            <i class="fa fa-print"></i>
        </button>
    </div>
    -->
    %end

</div>


<!-- Nav tabs -->
%if extyp == 'query':
<ul class="nav nav-tabs" role="tablist" id="tabs">
    <li role="presentation" class="active"><a href="#sql" aria-controls="sql" role="tab" data-toggle="tab">Sql</a></li>
    <li role="presentation"><a href="#data" aria-controls="data" role="tab" data-toggle="tab">Data</a></li>
</ul>
%end

<!-- Tab panes -->
<div class="tab-content" style="margin-bottom: 5px;">
    <div role="tabpanel" class="tab-pane active" id="sql">
        <div class="row">
            <div class="col-sm-12">
                <pre id="editor">{{sql}}</pre>
                <pre id="statusBar"></pre>
            </div>
        </div>
    </div> <!-- sql tab panel -->

    <div role="tabpanel" class="tab-pane" id="data">
        <div style="height: 420px; overflow: auto;" id="data-grid-container">
            <table id="table" class="table table-bordered table-condensed"></table>
        </div>
    </div>
</div>

<div class="alert alert-danger alert-dismissible" role="alert" id="error-panel" style="margin-bottom: 3px; display:none;">
    <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <span id="error-panel-text">

        </span>
</div>

%if extyp == 'query':
<div class="panel panel-primary">
    <div class="panel-heading">
        Query Plan
    </div>
    <div class="panel-body">
        <pre id="sql-plan"></pre>
    </div>
</div>
%end

<div class="panel panel-warning" style="display: none;">
    <div class="panel-heading">
        Parameters
    </div>
    <div class="panel-body form-horizontal" id="params">
    </div>
    <div class="panel-footer">
        <button class="btn btn-default" type="button" id="btn-exec-param" title="Execute query">
            <i class="fa fa-play"></i>
        </button>
        <button class="btn btn-default" type="button" id="btn-fetch-all-param" title="Execute and fetch all">
            <i class="fa fa-fast-forward"></i>
        </button>
    </div>
</div>


<div class="alert alert-info alert-dismissible" role="alert" id="result-panel" style="margin-bottom: 3px; display:none;">
    <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <span id="result-panel-text">
        </span>
    <div class="btn-group" id="result-panel-action" style="display: none;">
        <a class="btn btn-success trn-action" data-action="commit">Commit</a>
        <a class="btn btn-danger trn-action" data-action="rollback">Rollback</a>
    </div>
</div>



<!-- Static Modal -->
<!-- Source : http://bootsnipp.com/snippets/featured/centered-processing-modal -->
<div class="modal modal-static fade" id="processing-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                        </div>
                    </div>
                    <h4>
                        Executing sql
                    </h4>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/template" id="param-template">
    <div class="form-group"><label class="col-sm-3 control-label">{param}</label>
        <div class="col-sm-9">
            <input class="form-control input-xs prm" name="{param}" id="prm-{param}">
        </div>
    </div>
</script>

<script type="text/template" id="db">{{db}}</script>
<script type="text/template" id="refresh_object">{{refresh_object}}</script>
