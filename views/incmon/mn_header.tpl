<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Database Monitoring</li>
            <li class="active form-inline">
                <div class="form-group">
                    <label for="mon-key">Session: </label>
                    <select id="mon-key" class="form-control input-sm">
                        %for k in sorted(appconf.mon[db].keys(), reverse=True):
                        <option value="{{k}}" {{'selected="selected"' if k == mon_key else ''}}>{{k}}</option>
                        %end
                    </select>
                </div>
                <div class="btn-group btn-group-xs" style="margin-top: -4px;">
                    <a href="/mon/{{db}}/monopr?mon_key={{mon_key}}&opr=new" class="btn btn-primary" title="New monitoring session">
                        <i class="fa fa-plus"></i>
                    </a>
                    <a href="/mon/{{db}}/monopr?mon_key={{mon_key}}&opr=del" class="btn btn-danger" title="Delete monitoring session">
                        <i class="fa fa-minus"></i>
                    </a>
                </div>
            </li>
        </ol>
    </div>
</div>


<div class="row" style="margin-bottom: 5px;">
    <div class="col-md-12">
        <div class="btn-group btn-group-sm">
            <a class="btn btn-default mon-action" data-info-type="database" title="Database info">
                <i class="fa fa-database fa-lg"></i>
            </a>
            <a class="btn btn-default mon-action" data-info-type="attachments" title="Connections">
                <i class="fa fa-plug fa-lg"></i>
            </a>
            <a class="btn btn-default mon-action" data-info-type="transactions" title="Transactions">
                <i class="fa fa-exchange fa-lg"></i>
            </a>
            <a class="btn btn-default mon-action" data-info-type="statements" title="SQL Statements">
                <i class="fa fa-code fa-lg"></i>
            </a>
            <a class="btn btn-default mon-action" data-info-type="callstack" title="PSQL Callstack">
                <i class="fa fa-level-down fa-lg"></i>
            </a>
            <a class="btn btn-default mon-action" data-info-type="iostats" title="Page & Row IO Statistics">
                <i class="fa fa-line-chart fa-lg"></i>
            </a>
            <a class="btn btn-default mon-action" data-info-type="variables" title="Comtext variables">
                <i class="fa fa-tags fa-lg"></i>
            </a>
        </div>
    </div>
</div>
