<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/views/{{db}}">Views</a></li>
            <li class="active">{{tbl.name}}</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">
            %include('./incobj/d_fields.tpl', clmn=tbl.columns, pnlt='Fields', pobj='view')
            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_dependencies.tpl')
            %include('./incobj/d_triggers.tpl')
            %include('./incobj/d_ddl.tpl')
            %include('./incobj/d_description.tpl')
        </div>
    </div>
</div>
