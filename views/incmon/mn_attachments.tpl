<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse"  href="#tbl-attachments">
                Attachments
            </a>
        </h4>
    </div>
    <div id="tbl-attachments" class="panel-collapse collapse in">
        <table class="table table-bordered table-condensed">
            <tr>
                <th>ID</th>
                <th>Server PID</th>
                <th>State</th>
                <th>
                    Attachment Name
                    <a href="#" data-toggle="tooltip" title="Connection String"><i class="fa fa-info-circle"></i></a>
                </th>
                <th>User</th>
                <th>Role</th>
                <th>Rem.Protocol</th>
                <th>Rem. Address</th>
                <th>
                    Rem.PID
                    <a href="#" data-toggle="tooltip" title="Remote client process ID"><i class="fa fa-info-circle"></i></a>
                </th>
                <th>
                    Rem.Process
                    <a href="#" data-toggle="tooltip" title="Remote client process pathname"><i class="fa fa-info-circle"></i></a>
                </th>
                <th>
                    Character Set
                    <a href="#" data-toggle="tooltip" title="Attachment character set"><i class="fa fa-info-circle"></i></a>
                </th>
                <th>Connection Time</th>
                <th>Garbage Collection</th>
                <th></th>
                <th></th>

            </tr>
            %for attachment in data:
            <tr>
                <td>{{attachment.id}}</td>
                <td>{{attachment.server_pid}}</td>
                <td>{{'Active' if attachment.state == 1 else 'Idle'}}</td>
                <td>{{attachment.name}}</td>
                <td>{{attachment.user}}</td>
                <td>{{attachment.role}}</td>
                <td>{{attachment.remote_protocol}}</td>
                <td>{{attachment.remote_address}}</td>
                <td>{{attachment.remote_pid}}</td>
                <td>{{attachment.remote_process}}</td>
                <td>{{attachment.character_set.name}}</td>
                <td>{{attachment.timestamp.strftime('%d.%m.%Y %H:%M:%S')}}</td>
                <td>{{attachment.isgcallowed()}}</td>
                <td>
                    <div class="btn-group btn-group-xs">
                        <a href="/mon/{{db}}/info/transactions/{{mon_key}}?attachment={{attachment.id}}"
                           class="btn btn-default btn-xs" title="Transactions">
                            <i class="fa fa-exchange"></i>
                        </a>
                        <a href="/mon/{{db}}/info/statements/{{mon_key}}?attachment={{attachment.id}}"
                           class="btn btn-default btn-xs" title="SQL Statements">
                            <i class="fa fa-code"></i>
                        </a>
                        <a href="/mon/{{db}}/info/iostats/{{mon_key}}?attachment={{attachment.id}}"
                           class="btn btn-default btn-xs" title="Page & Row IO Statistics">
                            <i class="fa fa-line-chart"></i>
                        </a>
                        <a href="/mon/{{db}}/info/variables/{{mon_key}}?attachment={{attachment.id}}"
                           class="btn btn-default btn-xs" title="Variables">
                            <i class="fa fa-tags"></i>
                        </a>
                    </div>
                </td>
                <td>
                    <a class="btn btn-danger btn-xs" title="Kill connection"><i class="fa fa-trash"></i></a>
                </td>
            </tr>

            <tr>
                <td colspan="15">
                    % include('./incmon/mn_iostats.tpl', table_id = 'attachment-%d' % attachment.id, data = attachment.iostats, collapsed=True)
                    <!--
                    include('./incmon/mn_transactions.tpl', table_id = 'attachment-%d' % attachment.id, data = attachment.transactions)
                    include('./incmon/mn_statements.tpl', table_id = 'attachment-%d' % attachment.id, data = attachment.statements)
                    -->
                </td>
            </tr>
            %end
        </table>
    </div>
</div>