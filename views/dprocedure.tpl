<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/procedures/{{db}}">Procedures</a></li>
            <li class="active">{{tbl.name}}</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            %include('./incobj/d_fields.tpl', clmn=tbl.input_params, pnlt='Input Parameters')
            %include('./incobj/d_fields.tpl', clmn=tbl.output_params, pnlt='Output Parameters')
            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_dependencies.tpl')
            %include('./incobj/d_ddl.tpl')
            %include('./incobj/d_description.tpl')
        </div>
    </div>
</div>
