<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Indices</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-index">
                            Indices
                        </a>
                    </h4>
                </div>
                <div id="tbl-index" class="panel-collapse collapse in">
                    <table class="table table-condensed table-sortable table-bordered">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Table</th>
                            <th>Fields</th>
                            <th>Enforcer</th>
                            <th>Sorting</th>
                            <th>Unique</th>
                            <th>Active</th>
                            <th>Expression</th>
                            <th>Statistics</th>
                        </tr>
                        </thead>
                        <tbody>
                        %for k in sorted(tbl, key=lambda k: str(k.name)):
                            <tr>
                                <td>{{k.name}}</td>
                                <td>
                                    <a href="/db/table/{{db}}/{{k.table.name}}">{{k.table.name}}</a>
                                </td>
                                <td>
                                    %for fname in k.segment_names:
                                    <a href="/db/table/{{db}}/{{k.table.name}}#{{fname}}">{{fname}}</a>
                                    %end
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isenforcer() else '&nbsp;'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="fa fa-sort-alpha-asc"></span>' if k.index_type == 'ASCENDING' else '<span class="fa fa-sort-alpha-desc"></span>'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isunique() else '&nbsp;'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isinactive() else '&nbsp;'}}
                                </td>
                                <td>{{k.expression}}</td>
                                <td class="text-right">{{k.statistics}}</td>
                            </tr>
                        %end
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
