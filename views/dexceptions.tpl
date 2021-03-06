<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Exceptions</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-exceptions">
                            Exceptions
                        </a>
                    </h4>
                </div>
                <div id="tbl-exceptions" class="panel-collapse collapse in">
                    <table class="table table-condensed table-bordered">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Message</th>
                            <th>Description</th>
                            <th style="min-width: 60px;"></th>
                        </tr>
                        </thead>
                        <tbody>
                        %for _obj in sorted(tbl, key=lambda _obj: str(_obj.name)):
                        <tr>
                            <td>
                                <a href="/db/exception/{{db}}/{{_obj.name}}">
                                    {{_obj.name}}
                                </a>
                            </td>
                            <td>{{_obj.message}}</td>
                            <td>{{_obj.description}}</td>
                            <td>
                                <div class="btn-group btn-group-xs">
                                    <!--
                                    <a href="#" class="btn btn-primary" title="Edit description">
                                        <i class="fa fa-info fa-fw"></i>
                                    </a>
                                    -->
                                    <a href="/tools/script/{{db}}?typ=exception&name={{_obj.name}}&ddl=drop" class="btn btn-danger" title="Drop">
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
