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
                    <!-- todo : alert confirmation -->
                    <div class="btn-group-xs">
                        <a href="/db/drop?db={{k}}" class="btn btn-xs btn-danger" title="Drop database">
                            <span class="fa fa-trash"></span>
                        </a>
                    </div>
                </td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
