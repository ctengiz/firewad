% include('_header.tpl')

<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Create Table</li>
        </ol>
    </div>
</div>

<div class="btn-toolbar" role="toolbar" style="margin-bottom: 2px;" id="toolbar">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" type="button" id="btn-exec" title="Execute query">
            <i class="fa fa-bolt fa-fw text-danger"></i>
        </button>
    </div>
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default btn-add-field" type="button" title="Add field" data-field-no="99999999">
            <i class="fa fa-plus text-success"></i>
        </button>
        <button class="btn btn-default btn-remove-field" type="button" id="btn-remove-field" title="Remove field">
            <i class="fa fa-minus text-danger"></i>
        </button>
    </div>
</div>


<form>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="table-name" class="col-sm-2 control-label">Table Name</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="table_name" id="table-name">
            </div>
        </div>
        <div class="form-group">
            <label for="table-type" class="col-sm-2 control-label">Table Type</label>
            <div class="col-sm-6">
                <select class="form-control" name="table_type" id="table-type">
                    <option value="P">Persistent</option>
                    <option value="TD">Temporary: Delete Rows</option>
                    <option value="TP">Temporary: Preserve Rows</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="external-file" class="col-sm-2 control-label">External File</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="external_file" id="external-file">
            </div>
        </div>
    </div>

    <!---
    create table a1 (
x1 integer default 0 not null unique  check (x1 in (0, 1, 2) )
)-->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>#</th>
                <th>Is Pk</th>
                <th>Is Computed</th>
                <th>Field Name</th>
                <th>Field Type</th>
                <th>Array</th>
                <th>Default Value</th>
                <th>Not Null</th>
                <th>Is Unique</th>
                <th>Check</th>
                <th>Computed</th>
                <th>Description</th>
                <th></th>
            </tr>
        </thead>
        <tbody id="tbody-fields">

        </tbody>
    </table>
</form>

% include('_footer.tpl')

<script type="text/template" id="row-template">
    <tr id="row-{field_no}">
        <td>{row_number}</td>
        <td><input type="checkbox" name="is_pk"></td>
        <td><input type="checkbox" name="is_computed"></td>
        <td><input type="text" class="form-control" name="field_name"> </td>
        <td><input type="text" class="form-control" name="field_type"> </td>
        <td>
            <input type="text" class="form-control" name="array_low">
            <input type="text" class="form-control" name="array_hi">
        </td>
        <td><input type="text" class="form-control" name="default"></td>
        <td><input type="checkbox" name="is_not_null"></td>
        <td><input type="checkbox" name="is_unique"></td>
        <td><input type="text" class="form-control" name="check"> </td>
        <td><input type="text" class="form-control" name="computed"> </td>
        <td><input type="text" class="form-control" name="description"> </td>
        <td>
            <div class="btn-group btn-group-xs btn-group-vertical">
                <a class="btn btn-default btn-add-field" title="Add new field" data-row-id="row-{field_no}">
                    <i class="fa fa-plus text-success"></i>
                </a>
                <a class="btn btn-default" title="Move up field">
                    <i class="fa fa-arrow-up text-primary"></i>
                </a>
                <a class="btn btn-default" title="Move down field">
                    <i class="fa fa-arrow-down text-primary"></i>
                </a>
                <a class="btn btn-default btn-remove-field" title="Delete field" data-row-id="#row-{field_no}">
                    <i class="fa fa-minus text-danger"></i>
                </a>
            </div>

        </td>
    </tr>
</script>


<script type="text/javascript">

var fieldOps = function() {
    var _field_no = 0;
    var _row_number = 0;

    var tbody = $('#tbody-fields');
    var btn_add_field = $('.btn-add-field');

    var fields = [];
    var row_template = $("#row-template").html();

    function init() {
        btn_add_field.on('click', add_field);
        tbody.on('click', '.btn-add-field', add_field);
        tbody.on('click', '.btn-remove-field', remove_field);
    }

    function add_field() {
        _field_no += 1;
        _row_number += 1;
        var _row_html = templateString(
                row_template,
                {
                    field_no: _field_no,
                    row_number: _row_number
                }
        );

        tbody.append(_row_html);
    }

    function remove_field(field_no) {
        var _row_id = $(this).data("row-id");
        $(_row_id).remove();
        renumber_fields();
    }

    function renumber_fields() {
        $.each(tbody.children(), function( ndx, tr ) {
            //$(tr).firstChild().text(ndx + 1);
            tr.cells[0].textContent = ndx + 1;
            _row_number = ndx + 1;
        });
    }

    return {
        init: init,
        add_field: add_field,
        remove_field: remove_field
    }


}();



$(document).ready(function(){
    fieldOps.init();
})

</script>
