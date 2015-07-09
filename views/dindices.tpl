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
                        %for _obj in sorted(tbl, key=lambda k: str(k.name)):
                            <tr>
                                <td>
                                    <a href="/db/index/{{db}}/{{_obj.name}}">
                                        {{_obj.name}}
                                    </a>
                                </td>
                                <td>
                                    <a href="/db/table/{{db}}/{{_obj.table.name}}">{{_obj.table.name}}</a>
                                </td>
                                <td>
                                    %for fname in _obj.segment_names:
                                    <a href="/db/table/{{db}}/{{_obj.table.name}}#{{fname}}">{{fname}}</a>
                                    %end
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if _obj.isenforcer() else '&nbsp;'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="fa fa-sort-alpha-asc"></span>' if _obj.index_type == 'ASCENDING' else '<span class="fa fa-sort-alpha-desc"></span>'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if _obj.isunique() else '&nbsp;'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if not _obj.isinactive() else '&nbsp;'}}
                                </td>
                                <td>{{_obj.expression}}</td>
                                <td class="text-right">{{_obj.statistics}}</td>
                                <td>
                                    <div class="btn-group btn-group-xs">
                                        <a href="#" class="btn btn-primary" title="Edit description">
                                            <i class="fa fa-info fa-fw"></i>
                                        </a>
                                        <a href="/tools/script/{{db}}?typ=index&name={{_obj.name}}&ddl=drop" class="btn btn-danger" title="Drop">
                                            <i class="fa fa-trash fa-fw"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        %end
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
