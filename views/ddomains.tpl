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
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-domains">
                            Domains
                        </a>
                    </h4>
                </div>
                <div id="tbl-domains" class="panel-collapse collapse in">
                    <table class="table table-condensed table-bordered">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Not Null</th>
                        <th>Computed</th>
                        <th>Default</th>
                        <th>Description</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    %for _obj in sorted(tbl, key=lambda _obj: str(_obj.name)):
                        <tr>
                            <td>
                                <a href="/db/domain/{{db}}/{{_obj.name}}">
                                    {{_obj.name}}
                                </a>
                            </td>
                            <td>{{_obj.datatype}}</td>
                            <td class="text-center">
                                {{! '<span class="glyphicon glyphicon-ok"></span>' if not _obj.isnullable() else '&nbsp;'}}
                            </td>
                            <td>{{_obj.expression}}</td>
                            <td>{{_obj.default}}</td>
                            <td>{{_obj.description}}</td>
                            <td>
                                <div class="btn-group btn-group-xs">
                                    <a href="#" class="btn btn-primary" title="Edit description">
                                        <i class="fa fa-info fa-fw"></i>
                                    </a>
                                    <a href="/tools/script/{{db}}?typ=domain&name={{_obj.name}}&ddl=drop" class="btn btn-danger" title="Drop">
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
