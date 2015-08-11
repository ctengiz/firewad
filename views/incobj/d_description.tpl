<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-description">
                <i class="fa fa-info"></i> Description
            </a>
            <a href="#"
               class="btn btn-xs btn-primary pull-right panel-heading-button edit-description" title="Edit description"
               data-db="{{db}}"
               data-object="table"
               data-object_name="{{tbl.name}}"
               data-description="{{tbl.description}}">
                <i class="fa fa-edit"></i>
                Edit
            </a>


        </h4>
    </div>
    <div id="tbl-description" class="panel-collapse collapse">
        <div class="panel-body">
            {{tbl.description}}
        </div>
    </div>
</div>
