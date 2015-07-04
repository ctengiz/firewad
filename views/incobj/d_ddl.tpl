<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-ddl">
                <i class="fa fa-code"></i> DDL
            </a>

            <a href="/tools/script/{{db}}?typ={{typ}}&name={{tbl.name}}&ddl=edit" class="btn btn-xs btn-primary pull-right panel-heading-button">
                <i class="fa fa-edit"></i> Edit
            </a>
        </h4>

    </div>
    <div id="tbl-ddl" class="panel-collapse collapse">
        <div class="panel-body">
            {{! highlight_sql(tbl.get_sql_for('recreate'))}}
        </div>
    </div>
</div>
