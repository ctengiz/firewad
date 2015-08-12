<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Constraints</li>
        </ol>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-constraints">
                            Constraints
                        </a>
                    </h4>
                </div>
                <div id="tbl-constraints" class="panel-collapse collapse in" style="overflow-x: scroll;">
                    <table class="table table-condensed table-bordered">
                        <thead>
                        <tr>
                            <th data-field="name" data-sortable="true">Name</th>
                            <th data-field="type" data-sortable="true">Type</th>
                            <th data-field="table" data-sortable="true">Table</th>
                            <th data-field="fields" data-sortable="true">Fields</th>
                            <th data-field="index" data-sortable="true">Index</th>
                            <th>FK Attributes</th>
                        </tr>
                        </thead>
                        <tbody>
                        %for _obj in sorted(tbl, key=lambda _obj: str(_obj.name)):
                            %if not _obj.isnotnull():
                            <tr>
                                <td>
                                    <a href="/db/constraint/{{db}}/{{_obj.name}}">
                                        {{_obj.name}}
                                    </a>
                                </td>
                                <td>{{_obj.constraint_type}}</td>
                                <td>
                                    %if _obj.index:
                                    <a href="/db/table/{{db}}/{{_obj.index.table.name}}">{{_obj.index.table.name}}</a>
                                    %end
                                </td>
                                <td>
                                    %if _obj.index:
                                    %for fname in _obj.index.segment_names:
                                    <a href="/db/table/{{db}}/{{_obj.index.table.name}}#{{fname}}">{{fname}}</a>
                                    %end
                                    %end
                                </td>
                                <td>
                                    %if _obj.index:
                                    %if _obj.index.name != _obj.name:
                                    {{_obj.index.name}} <small>{{_obj.index.index_type}}</small>
                                    %end
                                    %end
                                </td>
                                <td style="word-wrap: break-word">
                                    %if _obj.isfkey():
                                    Fk Table:
                                    <a href="/db/table/{{db}}/{{_obj.partner_constraint.index.table.name}}">
                                        {{_obj.partner_constraint.index.table.name}}
                                    </a>
                                    <small>
                                        (
                                        %for fname in _obj.partner_constraint.index.segment_names:
                                        <a href="/db/table/{{db}}/{{_obj.partner_constraint.index.table.name}}#{{fname}}">
                                        {{fname}}
                                        </a>
                                        %end
                                        )
                                    </small>
                                    On Update : {{_obj.update_rule}}
                                    On Delete : {{_obj.delete_rule}}
                                    %end
                                </td>
                                <td>
                                    <div class="btn-group btn-group-xs">
                                        <!--
                                        <a href="#" class="btn btn-primary" title="Edit description">
                                            <i class="fa fa-info fa-fw"></i>
                                        </a>
                                        -->
                                        <a href="/tools/script/{{db}}?typ=constraint&name={{_obj.name}}&ddl=drop" class="btn btn-danger" title="Drop">
                                            <i class="fa fa-trash fa-fw"></i>
                                        </a>
                                    </div>

                                </td>
                            </tr>
                            %end
                        %end
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

