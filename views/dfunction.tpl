<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">{{db}}</a></li>
            <li><a href="/functions/{{db}}/{{tbl.name}}">Functions</a></li>
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
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-ddl">
                            DDL
                        </a>
                    </h4>
                </div>
                <div id="tbl-ddl" class="panel-collapse collapse in">
                    <div class="panel-body">
                        {{! highlight_sql(tbl.get_sql_for('declare'))}}
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
