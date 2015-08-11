<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse"  href="#tbl-field">
                {{pnlt}}
            </a>

            %if pobj == 'table':
            <a href="/ddl/new/column/{{db}}/{{tbl.name}}" class="btn btn-xs btn-primary pull-right panel-heading-button">
                <i class="fa fa-table"></i> Add Field
            </a>
            %end

        </h4>
    </div>
    <div id="tbl-field" class="panel-collapse collapse in">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>#</th>
                <th>Field Name</th>
                <th>Field Type</th>
                <th>Domain</th>
                <th>Not Null</th>
                %if pobj == 'table':
                <th>Computed</th>
                <th>Default</th>
                <th>Check</th>
                %end
                <th>Description</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            %for k in clmn:
            <tr id="field-{{k.name}}">
                <td>
                    %try:
                      {{k.position}}
                    %except:
                      {{k.sequence}}
                    %end
                </td>
                <td><!-- todo: pk/fk/uq --> {{k.name}}</td>
                <td style="word-wrap: break-word">{{k.datatype}}</td>
                <td>{{k.domain.name}}</td>
                <td class="text-center">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isnullable() else '&nbsp;'}}
                </td>
                %if pobj == 'table':
                <td>{{k.get_computedby()}}</td>
                <td class="text-center">{{k.default}}</td>
                <td>{{k.domain.validation}}</td>
                %end
                <td style="word-wrap: break-word">{{k.description}}</td>
                <td>
                    <div class="btn-group btn-group-xs">
                        %if pobj == 'table':
                        <a href="#" class="btn btn-primary edit-description" title="Edit description"
                           data-db="{{db}}"
                           data-object="column"
                           data-object_name="{{tbl.name}}.{{k.name}}"
                           data-description="{{k.description}}"
                        >
                            <i class="fa fa-comment"></i>
                        </a>
                        <a href="#" class="btn btn-warning" title="Edit field">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="/tools/script/{{db}}?typ=column&name={{k.name}}&table={{tbl.name}}&ddl=drop" class="btn btn-danger" title="Drop field">
                            <i class="fa fa-trash"></i>
                        </a>
                        %end
                    </div>

                </td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
