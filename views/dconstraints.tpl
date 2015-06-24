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
        <table class="table table-condensed">
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
            %for k in tbl:
                %if not k.isnotnull():
                <tr>
                    <td>{{k.name}}</td>
                    <td>{{k.constraint_type}}</td>
                    <td>
                        %if k.index:
                            {{k.index.table.name}}
                        %end
                    </td>
                    <td>
                        %if k.index:
                            %for fname in k.index.segment_names:
                            {{fname}}
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
                            <a href="/table/{{db}}/{{k.partner_constraint.index.table.name}}">
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
                    </td>
                </tr>
                %end
            %end
            </tbody>
        </table>
    </div>
</div>


<script type="text/javascript">
    $(document).ready(function(){
        $("#table").bootstrapTable({});
    });
</script>