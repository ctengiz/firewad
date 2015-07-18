<table class="table table-bordered">
    <thead>
        <tr>
            <th>#</th>
            %if trtyp == 'table':
            <th>Is Pk</th>
            %end
            <th>Field Name</th>
            <th>Is Computed</th>
            <th>Field Type</th>
            <th>Array</th>
            <th>Default Value</th>
            <th>Not Null</th>
            <th>Is Unique</th>
            <th>Check</th>
            <th>Description</th>
            <th></th>
        </tr>
    </thead>
    <tbody id="tbody-fields">

    </tbody>
</table>


% from common import Constants

<script type="text/template" id="row-template">
    <tr id="row-{field_no}" data-row-no="{field_no}">
        <td>
            {row_number}
        </td>
        %if trtyp == 'table':
        <td>
            <input type="checkbox" name="is_pk" id="is-pk-{field_no}">
        </td>
        %end
        <td>
            <input type="text" class="form-control input-sm" name="field_name" id="field-name-{field_no}">
        </td>
        <td>
            <input type="checkbox" name="is_computed" class="fld-computed" value="1" data-row-id="#row-{field_no}" id="is-computed-{field_no}">
            <div class="computed-show form-group" style="display: none;">
                    <label>Expression</label>
                    <input type="text" class="form-control input-sm col-sm-7" name="computed" id="computed-{field_no}">
            </div>
        </td>

        <td class="computed-hide">
            <div class="radio">
                <label>
                    <input type="radio" name="field_base-{field_no}" class="fld-base" value="custom" checked data-row-id="#row-{field_no}" id="field-base-customn-{field_no}">
                    Custom
                </label>
            </div>
            <div class="radio">
                <label>
                    <input type="radio" name="field_base-{field_no}" class="fld-base" value="domain" data-row-id="#row-{field_no}" id="field-base-domain-{field_no}">
                    Domain Based
                </label>
            </div>

            <div class="base-custom">
                <select class="form-control input-sm fld-type" name="field_type" data-row-id="#row-{field_no}" id="field-type-{field_no}">
                    %for f in Constants.field_types:
                    <option value="{{f}}" data-show="{{Constants.field_types[f]['show']}}">{{f}}</option>
                    %end
                </select>

                <div class="prop-numeric form-group" style="display: none">
                    <label>Field Precision</label>
                    <input type="text" name="field_precision" class="form-control input-sm" value="15" id="field-precision-{field_no}">
                    <label>Field Scale</label>
                    <input type="text" name="field_scale" class="form-control input-sm" value="2" id="field-scale-{field_no}">
                </div>

                <div class="prop-char form-group" style="display: none">
                    <label>Length</label>
                    <input type="text" name="field_length" class="form-control input-sm" value="1" id="field-length-{field_no}">
                    <label>Charset</label>
                    <select name="field_charset" class="form-control input-sm fld-charset" data-row-id="#row-{field_no}" id="field-charset-{field_no}">
                        <option value="" data-collate="[]"></option>
                        %for c in Constants.charsets:
                        <option value="{{c}}" data-collate="{{Constants.charsets[c]}}">{{c}}</option>
                        %end
                    </select>
                    <label>Collate</label>
                    <select name="field_collate" class="form-control input-sm fld-collate" data-row-id="#row-{field_no}" id="field-collate-{field_no}">
                        <option value=""></option>
                    </select>
                </div>
                <div class="prop-blob form-group" style="display: none">
                    <label>Sub Type</label>
                    <select name="field_blob_sub_type" class="form-control input-sm fld-blob-sub-type" data-row-id="#row-{field_no}" id="field-blob-sub-type-{field_no}">
                        <option value="1">Text</option>
                        <option value="0">Binary</option>
                    </select>
                    <label>Segment Size</label>
                    <input type="text" name="field_blob_segment_size" class="form-control input-sm" value="4096" id="field-blob-segment-size-{field_no}">
                    <div class="blob-charset">
                        <label>Charset</label>
                        <select name="field_blob_charset" class="form-control input-sm fld-charset" data-row-id="#row-{field_no}" id="field-blob-charset-{field_no}">
                            <option value="" data-collate="[]"></option>
                            %for c in Constants.charsets:
                            <option value="{{c}}" data-collate="{{Constants.charsets[c]}}">{{c}}</option>
                            %end
                        </select>
                        <label>Collate</label>
                        <select name="field_blob_collate" class="form-control input-sm fld-collate" data-row-id="#row-{field_no}" id="field-blob-collate-{field_no}">
                            <option value=""></option>
                        </select>
                    </div>
                </div>

            </div>

            <div class="base-domain" style="display: none;">
                <select name="field_domain" class="form-control input-sm" id="field-domain-{field_no}">
                    %for d in appconf.ddl[db]['domains']:
                    <option value="{{d}}">{{d}}</option>
                    %end
                </select>
            </div>
        </td>

        <td class="computed-hide" style="width: 85px;">
            <div class="pull-left" style="width: 35px;">
                <input type="text" class="form-control input-sm" name="array_low" id="field-array-low-{field_no}">
            </div>
            <div class="pull-left" style="width: 35px;">
                <input type="text" class="form-control input-sm" name="array_hi" id="field-array-hi-{field_no}">
            </div>
        </td>

        <td class="computed-hide"><input type="text" class="form-control input-sm" name="field_default" id="field-default-{field_no}"></td>

        <td class="computed-hide"><input type="checkbox" name="field_not_null" id="field-not-null-{field_no}"></td>
        <td class="computed-hide"><input type="checkbox" name="field_unique" id="field-unique-{field_no}"></td>

        <td class="computed-hide">
            <textarea class="form-control input-sm" name="field_check" rows="3" id="field-check-{field_no}"></textarea>
        </td>

        <td>
            <textarea class="form-control input-sm" name="field_description" rows="3" id="field-description-{field_no}"></textarea>
        </td>

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
