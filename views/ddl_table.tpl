% include('_header.tpl')

<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Create Table</li>
        </ol>
    </div>
</div>

<div class="btn-toolbar" role="toolbar" style="margin-bottom: 2px;">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default btn-ddl" type="button" title="Get DDL">
            <span class="fa fa-code fa-fw text-info"></span> DDL
        </button>
    </div>
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default btn-add-field" type="button" title="Add field" data-field-no="99999999">
            <i class="fa fa-plus text-success"></i>
        </button>
        <button class="btn btn-default btn-remove-field" type="button" title="Remove field">
            <i class="fa fa-minus text-danger"></i>
        </button>
    </div>
</div>


<div class="form-horizontal">
    <div class="form-group">
        <label for="table-name" class="col-sm-2 control-label">Table Name</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="table_name" id="table-name" required>
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
    <div class="form-group">
        <label for="description" class="col-sm-2 control-label">Description</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="description" id="description">
        </div>
    </div>
</div>

% include('./incddl/l_column.tpl', trtyp='yable')

<div class="btn-toolbar" role="toolbar" style="margin-bottom: 2px;" id="toolbar">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default btn-ddl" type="button" title="Get DDL">
            <span class="fa fa-code fa-fw text-info"></span> DDL
        </button>
    </div>
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default btn-add-field" type="button" title="Add field" data-field-no="99999999">
            <i class="fa fa-plus text-success"></i>
        </button>
        <button class="btn btn-default btn-remove-field" type="button" title="Remove field">
            <i class="fa fa-minus text-danger"></i>
        </button>
    </div>
</div>



<div id="script" style="display: none;">
    % include('_script.tpl', extyp = 'script', sql='', refresh_object='tables')
</div>



% include('_footer.tpl')


<script type="text/template" id="table-template">CREATE {gtt} TABLE {table_name} (
{fields}{pk});{gtt_end}
{description}
</script>


<script src="/static/ace/ace.js"></script>
<script src="/static/ace/ext-language_tools.js"></script>
<script src="/static/ace/ext-statusbar.js"></script>

<script src="/static/jquery.floatThead.min.js"></script>

<script src="/static/script.js"></script>


<script type="text/javascript">

var fieldOps = function() {
    var _field_no = 0;
    var _row_number = 0;

    var tbody = $('#tbody-fields');
    var btn_add_field = $('.btn-add-field');

    var fields = [];
    var row_template = $("#row-template").html();

    function init() {
        $('.btn-ddl').on('click', get_ddl);

        btn_add_field.on('click', add_field);
        tbody.on('click', '.btn-add-field', add_field);
        tbody.on('click', '.btn-remove-field', remove_field);

        tbody.on('change', '.fld-type', change_field_type);
        tbody.on('change', '.fld-charset', change_collate);
        tbody.on('change', '.fld-base', change_field_base);
        tbody.on('click', '.fld-computed', change_computed);

        tbody.on('change', '.fld-blob-sub-type', change_blob);
    }

    function get_ddl() {
        var table_template = $('#table-template').text();

        //constanst
        var _space = '    ';

        var _table_vals = {};
        _table_vals.table_name = $("#table-name").val();

        //fields
        var _ddl_fields = '';
        var _ddl_description = '';
        var _ddl_pk = '';
        var _tr_count = $('#tbody-fields tr').length;
        $.each(tbody.children(), function( ndx, tr ) {
            var rno = $(tr).data('row-no');
            var rid = tr.getAttribute('id');

            var _field_name = $('#field-name-' + rno).val() + ' ';

            //is pk ?
            if ($('#is-pk-' + rno).is(':checked')) {
                if (_ddl_pk) {
                    _ddl_pk += ', ' + _field_name;
                } else {
                    _ddl_pk += _field_name;
                }
            }

            //is not null ?
            var _not_null = '';
            if ($('#field-not-null-' + rno).is(':checked')) {
                _not_null = ' NOT NULL'
            }

            //unique
            var _unique = '';
            if ($('#field-unique-' + rno).is(':checked')) {
                _unique = ' UNIQUE'
            }

            //check
            var _check = $('#field-check-' + rno).val();
            if (_check) {
                _check = ' CHECK (' + _check + ')'
            }

            var _description = $('#field-description-' + rno).val();

            //is computed ?
            var _field_type = '';
            if ($('#is-computed-' + rno).is(':checked')) {
                _field_type = 'COMPUTED BY (' + $('#computed-' + rno).val() + ')'
            }
            else {
                //is domain based ?
                if ($('#field-base-domain-' + rno).is(':checked')) {
                    _field_type = $('#field-domain-' + rno).val() + _not_null + _check +  _unique;
                }
                //custom data type
                else {
                    var _type = $('#field-type-' + rno).val();
                    var _length = $('#field-length-' + rno).val();
                    var _array_hi = $('#field-array-hi-' + rno).val();
                    var _array_low = $('#field-array-low-' + rno).val();
                    var _array_str = '';
                    if (_array_hi && _array_low) {
                        _array_str = '[' + _array_low + ':' + _array_hi + ']';
                    }

                    var _charset = $('#field-charset-' + rno).val();
                    if (_charset) {_charset = ' CHARACTER SET ' + _charset}
                    var _collate = $('#field-collate-' + rno).val();
                    if (_collate) {_collate = ' COLLATE ' + _collate}

                    var _precision = $('#field-precision-' + rno).val();
                    var _scale = $('#field-scale-' + rno).val() || '0';

                    var _sub_type = $('#field-blob-sub-type-' + rno).val();
                    var _segment_size = $('#field-blob-segment-size-' + rno).val();
                    var _blob_charset = $('#field-blob-charset-' + rno).val();
                    if (_blob_charset) {_blob_charset = ' CHARACTER SET ' + _blob_charset}
                    var _blob_collate = $('#field-blob-collate-' + rno).val();
                    if (_blob_collate) {_blob_collate = ' COLLATE ' + _blob_collate}

                    var _default = $('#field-default-' + rno).val();
                    if (_default) {
                        _default = ' DEFAULT ' + _default
                    }

                    if (_type == 'VARCHAR') {
                        _field_type = _type + '(' + _length + ')' + _array_str  + _charset + ' ' + _collate;
                    } else
                    if ((_type == 'NUMERIC') || (_type == 'DECIMAL')) {
                        _field_type = _type + '(' + _precision + ', ' + _scale + ')' + _array_str;
                    } else
                    if (_type == 'BLOB') {
                        _field_type = _type +
                                ' SUB TYPE ' + _sub_type +
                                ' SEGMENT_SIZE ' + _segment_size +
                                _blob_charset + _blob_collate + _not_null + _check;
                    } else {
                        _field_type = _type + _array_str;
                    }

                    _field_type += _default + _not_null + _check + _unique;
                }
            }

            _ddl_fields += _space + _field_name + _field_type;

            if ( (ndx < _tr_count - 1) || (_ddl_pk)) {
                _ddl_fields += ',';
            }
            _ddl_fields +=  '\n';

            if (_description) {
                _ddl_description += 'comment on column ' +
                        _table_vals.table_name + '.' +
                        _field_name + "is '" +
                        _description + "';\n";
            }
        });

        _table_vals.fields = _ddl_fields;
        if (_ddl_pk) {
            _table_vals.pk = _space + 'CONSTRAINT PK_' + _table_vals.table_name + ' PRIMARY KEY (' + _ddl_pk + ')\n'
        }

        var _table_type = $('#table-type').val();
        if (_table_type == 'P') {
            _table_vals.gtt = '';
            _table_vals.gtt_end = '';
        } else if ( _table_type == 'TD') {
            _table_vals.gtt = 'GLOBAL TEMPORARY';
            _table_vals.gtt_end = ' ON COMMIT DELETE ROWS'
        } else {
            _table_vals.gtt = 'GLOBAL TEMPORARY';
            _table_vals.gtt_end = ' ON COMMIT PRESERVE ROWS'
        }

        var _table_description = $('#description').val();
        if (_table_description) {
            _ddl_description = 'comment on table ' +
                    _table_vals.table_name + " is '" +
                    _table_description + "';\n" +
                    _ddl_description;
        }

        _table_vals.description = _ddl_description;

        var _ddl = templateString(table_template, _table_vals);

        editor.setValue(_ddl, -1);
        $('#script').show();
        editor.focus();
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
            tr.cells[0].textContent = ndx + 1;
            _row_number = ndx + 1;
        });
    }

    function change_field_type() {
        var _row_id = $(this).data("row-id");
        var _show = $(this).find(":selected").data("show");

        $(_row_id + ' [class|="prop"]').hide();
        $(_row_id + ' ' + _show).show();
    }

    function change_collate() {
        var _row_id = $(this).data("row-id");
        var _collate_list = eval($(this).find(":selected").data("collate"));
        var _collate_select = $(_row_id + ' .fld-collate');

        _collate_select.empty();
        for (var i = 0; i < _collate_list.length; i++) {
            var _option = $('<option></option>').attr("value", _collate_list[i]).text(_collate_list[i]);
            _collate_select.append(_option);
        }
    }

    function change_blob() {
        var _row_id = $(this).data("row-id");

        if ($(this).val() == "1") {
            $(_row_id + ' .blob-charset').show();
        } else {
            $(_row_id + ' .blob-charset').hide();
        }

    }

    function change_field_base() {
        var _row_id = $(this).data("row-id");

        if ($(this).val() == 'custom') {
            $(_row_id + ' .base-domain').hide();
            $(_row_id + ' .base-custom').show();
        } else {
            $(_row_id + ' .base-custom').hide();
            $(_row_id + ' .base-domain').show();
        }
    }

    function change_computed() {
        var _row_id = $(this).data("row-id");

        if (this.checked) {
            $(_row_id + ' .computed-hide').hide();
            $(_row_id + ' .computed-show').show().parent().attr('colspan', 7);
        } else {
            $(_row_id + ' .computed-show').hide().parent().attr('colspan', 1);
            $(_row_id + ' .computed-hide').show();
        }
    }


    return {
        init: init,
        add_field: add_field,
        remove_field: remove_field
    }


}();



$(document).ready(function(){
    fieldOps.init();
    fieldOps.add_field();
})

</script>
