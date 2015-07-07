<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle {{'collapsed' if collapsed else ''}}" data-toggle="collapse"  href="#tbl-transactions-{{table_id}}">
                Transactions
            </a>
        </h4>
    </div>
    <div id="tbl-transactions-{{table_id}}" class="panel-collapse collapse {{'' if collapsed else 'in'}}">
        <table class="table table-bordered table-condensed text-right" style="background-color: #ffffff;">
            <tr>
                <th>ID</th>
                <th>State</th>
                <th>Start</th>
                <th>Top Trn</th>
                <th>OIT</th>
                <th>OAT</th>
                <th>Isolation</th>
                <th>Lock Timeout</th>
                <th>Read Only</th>
                <th>Auto Commit</th>
                <th>Auto Undo</th>
                <th></th>
            </tr>
            %for t in data:
            <tr>
                <td>{{t.id}}</td>
                <td>{{'Active' if t.state == 1 else 'Idle'}}</td>
                <td>{{t.timestamp.strftime('%d.%m.%Y %H:%M:%S')}}</td>
                <td>{{t.top}}</td>
                <td>{{t.oldest}}</td>
                <td>{{t.oldest_active}}</td>
                <td>
                    %if t.isolation_mode == 0:
                    Consistency
                    %elif t.isolation_mode == 1:
                    Concurrency
                    %elif t.isolation_mode == 2:
                    Read committed record version
                    %elif t.isolation_mode == 3:
                    Read committed no record version
                    %end
                </td>
                <td>
                    %if t.lock_timeout == -1:
                    Infinite wait
                    %elif t.lock_timeout == 0:
                    No wait
                    %else:
                    Timeout {{t.lock_timeout}}
                    %end
                </td>
                <td>{{t.isreadonly()}}</td>
                <td>{{t.isautocommit()}}</td>
                <td>{{t.isautoundo()}}</td>
                <td>
                    <div class="btn-group btn-group-xs">
                        <a href="/mon/{{db}}/info/statements/{{mon_key}}?transaction={{t.id}}"
                           class="btn btn-default btn-xs" title="SQL Statements">
                            <i class="fa fa-code"></i>
                        </a>

                        <a href="/mon/{{db}}/info/iostats/{{mon_key}}?transaction={{t.id}}"
                           class="btn btn-default btn-xs" title="Page & Row IO Statistics">
                            <i class="fa fa-line-chart"></i>
                        </a>

                        <a href="/mon/{{db}}/info/variables/{{mon_key}}?transaction={{t.id}}"
                           class="btn btn-default btn-xs" title="Variables">
                            <i class="fa fa-tag"></i>
                        </a>
                    </div>
                </td>
            </tr>
            %end
        </table>
    </div>
</div>
