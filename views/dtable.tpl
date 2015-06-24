<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">{{db}}</a></li>
            <li><a href="/tables/{{db}}">Tables</a></li>
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
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-field">
                            Fields
                        </a>
                    </h4>
                </div>
                <div id="tbl-field" class="panel-collapse collapse in">
                    <table class="table table-condensed">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Field Name</th>
                        <th>Field Type</th>
                        <th>Domain</th>
                        <th>Not Null</th>
                        <th>Computed</th>
                        <th>Default</th>
                        <th>Description</th>
                    </tr>
                    </thead>
                    <tbody>
                    %for k in tbl.columns:
                        <tr>
                            <td>{{k.position}}</td>
                            <td><!-- todo: pk/fk/uq --> {{k.name}}</td>
                            <td>{{k.datatype}}</td>
                            <td>{{k.domain.name}}</td>
                            <td>
                                {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isnullable() else '&nbsp;'}}
                            </td>
                            <td>{{k.domain.expression}}</td>
                            <td>{{k.domain.default}}</td>
                            <td>{{k.description}}</td>
                        </tr>
                    %end
                    </tbody>
                </table>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-constraint">
                            Constraints
                        </a>
                    </h4>
                </div>
                <div id="tbl-constraint" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-condensed">
                            <thead>
                            <tr>
                                <th>Type</th>
                                <th>Name</th>
                                <th>Fields</th>
                                <th>Index</th>
                                <th>FK Attr</th>
                            </tr>
                            </thead>
                            <tbody>
                            %for k in tbl.constraints:
                                %if not k.isnotnull():
                                <tr>
                                    <td>{{k.constraint_type}}</td>
                                    <td>{{k.name}}</td>
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
            </div>


            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-index">
                            Indices
                        </a>
                    </h4>
                </div>
                <div id="tbl-index" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-condensed">
                            <thead>
                            <tr>
                                <th>Name</th>
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
                            %for k in tbl.indices:
                                <tr>
                                    <td>{{k.name}}</td>
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

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-dependents">
                            Dependents
                        </a>
                    </h4>
                </div>
                <div id="tbl-dependents" class="panel-collapse collapse">
                    <table class="table table-condensed">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Field</th>
                        </tr>
                        </thead>
                        <tbody>
                        %for k in tbl.get_dependents():
                        <tr>
                            <td>{{k.dependent_name}}</td>
                            <td>{{k.dependent_type}}</td>
                            <td>{{k.field_name}}</td>
                        </tr>
                        %end
                        </tbody>
                    </table>

                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-depedencies">
                            Dependencies
                        </a>
                    </h4>
                </div>
                <div id="tbl-depedencies" class="panel-collapse collapse">
                    <div class="panel-body">
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-trigger">
                            Triggers
                        </a>
                    </h4>
                </div>
                <div id="tbl-trigger" class="panel-collapse collapse">
                    <div class="panel-body">
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-ddl">
                            DDL
                        </a>
                    </h4>
                </div>
                <div id="tbl-ddl" class="panel-collapse collapse">
                    <div class="panel-body">
                        {{! highlight_sql(tbl.get_sql_for('recreate'))}}
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#tbl-description">
                            Description
                        </a>
                    </h4>
                </div>
                <div id="tbl-description" class="panel-collapse collapse">
                    <div class="panel-body">
                        {{tbl.description}}
                    </div>
                </div>
            </div>

        </div>



    </div>
</div>
