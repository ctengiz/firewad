<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Domains</li>
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
                            Domains
                        </a>
                    </h4>
                </div>
                <div id="tbl-field" class="panel-collapse collapse in">
                    <table class="table table-condensed">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Not Null</th>
                        <th>Computed</th>
                        <th>Default</th>
                        <th>Description</th>
                    </tr>
                    </thead>
                    <tbody>
                    %for k in tbl:
                        <tr>
                            <td>{{k.name}}</td>
                            <td>{{k.datatype}}</td>
                            <td>
                                {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isnullable() else '&nbsp;'}}
                            </td>
                            <td>{{k.expression}}</td>
                            <td>{{k.default}}</td>
                            <td>{{k.description}}</td>
                        </tr>
                    %end
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</div>
