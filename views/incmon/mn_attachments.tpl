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

    </tr>
    %for k in mon.attachments:
    <tr>
        <td>{{k.id}}</td>
        <td>{{k.server_pid}}</td>
        <td>{{'Active' if k.state == 1 else 'Idle'}}</td>
        <td>{{k.name}}</td>
        <td>{{k.user}}</td>
        <td>{{k.role}}</td>
        <td>{{k.remote_protocol}}</td>
        <td>{{k.remote_address}}</td>
        <td>{{k.remote_pid}}</td>
        <td>{{k.remote_process}}</td>
        <td>{{k.character_set}}</td>
        <td>{{k.timestamp}}</td>
        <td>{{k.isgcallowed()}}</td>
        <td>
            {{k.iostats}}
        </td>
        <td>
            Transactions
            Statements
            Variables
        </td>
        <td>
            Kill Attachment
        </td>
    </tr>
    %end
</table>