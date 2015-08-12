<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/domains/{{db}}">Domains</a></li>
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
                                        <th>Type</th><td>{{tbl.datatype}}</td>
                                    </tr>
                                    <tr>
                                        <th>Not Null</th>
                                        <td>
                                            {{! '' if tbl.isnullable() else '<span class="glyphicon glyphicon-ok"></span>'}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Computed</th><td>{{tbl.expression}}</td>
                                    </tr>
                                    <tr>
                                        <th>Default</th><td>{{tbl.default}}</td>
                                    </tr>
                                    <tr>
                                        <th>Check</th><td>{{tbl.validation}}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_ddl.tpl', ddl_type='create')
            %include('./incobj/d_description.tpl', pobj="domain")
        </div>
    </div>
</div>
