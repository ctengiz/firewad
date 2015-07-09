<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/exceptions/{{db}}">Exceptions</a></li>
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
                            Message
                        </a>
                    </h4>
                </div>
                <div id="tbl-message" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <h4>{{tbl.message}}</h4>
                    </div>
                </div>
            </div>



            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_ddl.tpl')
            %include('./incobj/d_description.tpl')
        </div>
    </div>
</div>
