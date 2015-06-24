<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">{{db}}</a></li>
            <li><a href="/views/{{db}}">Views</a></li>
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
