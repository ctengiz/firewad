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
                            <th>Internal ID</th>
                        </tr>
                        </thead>
                        <tbody>
                        %for k in sorted(tbl, key=lambda k: str(k.name)):
                        <tr>
                            <td>{{k.name}}</td>
                            <td>{{k.message}}</td>
                            <td>{{k.description}}</td>
                            <td class="text-right">{{k.id}}</td>
                        </tr>
                        %end
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
