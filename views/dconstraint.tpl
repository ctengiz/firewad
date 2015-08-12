<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/constraints/{{db}}">Constraints</a></li>
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
                                    <tr>
                                        <th data-field="type" data-sortable="true">Type</th>
                                        <td>
                                            {{tbl.constraint_type}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th data-field="table" data-sortable="true">Table</th>
                                        <td>
                                            %if tbl.index:
                                            <a href="/db/table/{{db}}/{{tbl.index.table.name}}">{{tbl.index.table.name}}</a>
                                            %end
                                        </td>
                                    </tr>
                                    <tr>
                                        <th data-field="fields" data-sortable="true">Fields</th>
                                        <td>
                                            %if tbl.index:
                                                %for fname in tbl.index.segment_names:
                                                <a href="/db/table/{{db}}/{{tbl.index.table.name}}#{{fname}}">{{fname}}</a>
                                                %end
                                            %end
                                        </td>
                                    </tr>
                                    <tr>
                                        <th data-field="index" data-sortable="true">Index</th>
                                        <td>
                                            %if tbl.index:
                                                %if tbl.index.name != tbl.name:
                                                {{tbl.index.name}} <small>{{tbl.index.index_type}}</small>
                                                %end
                                            %end
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>FK Attributes</th>
                                        <td style="word-wrap: break-word">
                                            %if tbl.isfkey():
                                            Fk Table:
                                            <a href="/db/table/{{db}}/{{tbl.partner_constraint.index.table.name}}">
                                                {{tbl.partner_constraint.index.table.name}}
                                            </a>
                                            <small>
                                                (
                                                %for fname in tbl.partner_constraint.index.segment_names:
                                                <a href="/db/table/{{db}}/{{tbl.partner_constraint.index.table.name}}#{{fname}}">
                                                    {{fname}}
                                                </a>
                                                %end
                                                )
                                            </small>
                                            On Update : {{tbl.update_rule}}
                                            On Delete : {{tbl.delete_rule}}
                                            %end
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

            <!--
            %include('./incobj/d_description.tpl', pobj="constraint")
            -->
        </div>
    </div>
</div>
