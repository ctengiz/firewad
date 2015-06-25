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
                                <td>{{k.table.name}}</td>
                                <td>
                                    %for fname in k.segment_names:
                                    {{fname}}
                                    %end
                                </td>
                                <td>
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isenforcer() else '&nbsp;'}}
                                </td>
                                <td>
                                    {{k.index_type}}
                                </td>
                                <td>
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isunique() else '&nbsp;'}}
                                </td>
                                <td>
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isinactive() else '&nbsp;'}}
                                </td>
                                <td>
                                    {{k.expression}}
                                </td>
                                <td>
                                    {{k.statistics}}
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
