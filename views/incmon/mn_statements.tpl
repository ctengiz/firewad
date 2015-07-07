<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle {{'collapsed' if collapsed else ''}}" data-toggle="collapse"  href="#tbl-statements-{{table_id}}">
                Statements
            </a>
        </h4>
    </div>
    <div id="tbl-statements-{{table_id}}" class="panel-collapse collapse {{'' if collapsed else 'in'}}">
        <table class="table table-bordered table-condensed" style="background-color: #ffffff;">
            <tr>
                <th>ID</th>
                <th>State</th>
                <th>Start</th>
                <th>Sql Text</th>
                <th></th>
                <th></th>
            </tr>
            %for t in data:
            <tr>
                <td>{{t.id}}</td>
                <td>{{'Active' if t.state == 1 else 'Idle'}}</td>
                <td>{{t.timestamp.strftime('%d.%m.%Y %H:%M:%S') if t.timestamp else ''}}</td>
                <td>
                    <div style="max-width: 450px; max-height: 300px; overflow: auto;">
                    {{! highlight_sql(t.sql_text)}}
                    </div>
                </td>
                <td>
                    <div class="btn-group btn-group-xs">
                        <a href="/mon/{{db}}/info/callstack/{{mon_key}}?statement={{t.id}}"
                           class="btn btn-default btn-xs" title="PSQL Callstack">
                            <i class="fa fa-level-down"></i>
                        </a>

                        <a href="/mon/{{db}}/info/iostats/{{mon_key}}?statement={{t.id}}"
                           class="btn btn-default btn-xs" title="Page & Row IO Statistics">
                            <i class="fa fa-line-chart"></i>
                        </a>
                    </div>
                </td>
                <td>
                    <a class="btn btn-danger btn-xs" title="Terminate statement"><i class="fa fa-trash"></i></a>
                </td>
            </tr>
            %end
        </table>
    </div>
</div>
