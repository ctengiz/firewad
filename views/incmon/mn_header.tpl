<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Database Monitoring</li>
        </ol>
    </div>
</div>


<div class="row">
    <div class="col-md-2">
        Monitor Sessions
    </div>
    <div class="col-md-2">
        <select id="mon-key" class="form-control">
        %for k in appconf.mon[db]:
            <option value="{{k}}">{{k}}</option>
        %end
        </select>
    </div>
    <div class="col-md-3">
        <div class="btn-group">
            <button id="new-session" class="btn btn-success">New Session</button>
            <button id="del-session" class="btn btn-danger">Delete Session</button>
            <!-- todo save & load monitoring sessions -->
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="btn-group">
            <a class="btn btn-default mon-action" data-info-type="database">Database Info</a>
            <a class="btn btn-default mon-action" data-info-type="attachments">Attachments</a>
            <a class="btn btn-default mon-action" data-info-type="transactions">Transactions</a>
            <a class="btn btn-default mon-action" data-info-type="statements">Sql Statements</a>
            <a class="btn btn-default mon-action" data-info-type="callstack">PSQL Callstack</a>
            <a class="btn btn-default mon-action" data-info-type="statistics">Page & Row IO Statistics</a>
            <a class="btn btn-default mon-action" data-info-type="variables">Context Variables</a>

        </div>
    </div>
</div>
