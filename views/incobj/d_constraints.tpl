<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-constraint">
                Constraints
            </a>
        </h4>
    </div>
    <div id="tbl-constraint" class="panel-collapse collapse">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>Type</th>
                <th>Name</th>
                <th>Fields</th>
                <th>Index</th>
                <th>Attr</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            %for k in sorted(tbl.constraints, key=lambda k: str(k.constraint_type) + '-' + str(k.name)):
            %if not k.isnotnull():
            <tr>
                <td>{{k.constraint_type}}</td>
                <td>{{k.name}}</td>
                <td>
                    %if k.index:
                    %for fname in k.index.segment_names:
                    <a href="#field-{{fname}}">{{fname}}</a>
                    %end
                    %end
                </td>
                <td>
                    %if k.index:
                    {{k.index.name}} <small>{{k.index.index_type}}</small>
                    %end
                </td>
                <td>
                    %if k.isfkey():
                    Fk Table:
                    <a href="/db/table/{{db}}/{{k.partner_constraint.index.table.name}}">
                        {{k.partner_constraint.index.table.name}}
                    </a>
                    <small>
                        (
                        %for fname in k.partner_constraint.index.segment_names:
                        {{fname}}
                        %end
                        )
                    </small>
                    On Update : {{k.update_rule}}
                    On Delete : {{k.delete_rule}}
                    %end

                    %if k.ischeck():
                    {{k.triggers[0].source.lstrip('check (').rstrip(')')}}
                    %end
                </td>

                <td>
                    <div class="btn-group btn-group-xs">
                        %if k.index:
                        <a href="#" class="btn btn-warning" title="Edit constraint">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="/tools/script/{{db}}?typ=constraint&name={{k.name}}&table={{tbl.name}}&ddl=drop" class="btn btn-danger" title="Drop constraint ">
                            <i class="fa fa-trash"></i>
                        </a>
                        %end
                    </div>

                </td>

            </tr>
            %end
            %end
            </tbody>
        </table>
    </div>
</div>
