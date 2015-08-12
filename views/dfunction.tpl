<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/functions/{{db}}">Functions</a></li>
            <li class="active">{{tbl.name}}</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            %include('./incobj/d_arguments.tpl')
            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_dependencies.tpl')
            %include('./incobj/d_ddl.tpl', ddl_type='declare')
            %include('./incobj/d_description.tpl', pobj="function")
        </div>



    </div>
</div>
