<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/indices/{{db}}">Indices</a></li>
            <li class="active">{{tbl.name}}</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-Message">
                            Properties
                        </a>
                    </h4>
                </div>
                <div id="tbl-message" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-6">
                                <table class="table table-bordered">
                                    <tr><th>Table</th><td><a href="/db/table/{{db}}/{{tbl.table.name}}">{{tbl.table.name}}</a></td></tr>
                                    <tr>
                                        <th>Fields</th>
                                        <td>
                                            %for fname in tbl.segment_names:
                                            <a href="/db/table/{{db}}/{{tbl.table.name}}#{{fname}}">{{fname}}</a>
                                            %end
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Enforcer</th>
                                        <td>{{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isenforcer() else '&nbsp;'}}</td>
                                    </tr>
                                    <tr>
                                        <th>Sorting</th>
                                        <td>
                                            {{! '<span class="fa fa-sort-alpha-asc"></span>' if tbl.index_type == 'ASCENDING' else '<span class="fa fa-sort-alpha-desc"></span>'}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Unique</th>
                                        <td>
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isunique() else '&nbsp;'}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Active</th>
                                        <td>
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if not tbl.isinactive() else '&nbsp;'}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Expression</th>
                                        <td>
                                            {{tbl.expression}} 
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Statistics</th>
                                        <td>
                                            {{tbl.statistics}}
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_dependencies.tpl')
            %include('./incobj/d_ddl.tpl', ddl_type='create')
            %include('./incobj/d_description.tpl')
        </div>
    </div>
</div>
