<div class="row">
    <div class="col-md-12">
        <a class="btn btn-default" href="/db/register">Register DB</a>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered table-condensed">
            <thead>
            <tr>
                <th>Alias</th>
                <th>Server</th>
                <th>Path</th>
                <th>User</th>
                <th>Charset</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            %for k in appconf.db_config.sections():
            <tr>
                <td>
                    <a href="/db/{{k}}">{{k}}</a>
                </td>
                <td>{{appconf.db_config[k]['db_server']}}</td>
                <td>{{appconf.db_config[k]['db_path']}}</td>
                <td>{{appconf.db_config[k]['db_user']}}</td>
                <td>{{appconf.db_config[k]['charset']}}</td>
                <td>
                    <div class="btn-group-xs">
                        <a href="/db/register?db={{k}}" class="btn btn-xs btn-primary" title="Edit Registration Info">
                            <span class="fa fa-edit"></span>
                        </a>
                    </div>
                </td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
