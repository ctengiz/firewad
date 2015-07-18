<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse"  href="#tbl-field">
                {{pnlt}}
            </a>

            <a href="/ddl/new/column/{{db}}/{{tbl.name}}" class="btn btn-xs btn-primary pull-right panel-heading-button">
                <i class="fa fa-table"></i> Add Field
            </a>

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
                <th>Computed</th>
                <th>Default</th>
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
                <td>{{k.domain.expression}}</td>
                <td class="text-center">{{k.domain.default}}</td>
                <td style="word-wrap: break-word">{{k.description}}</td>
                <td>
                    <div class="btn-group btn-group-xs">
                        <a href="/tools/script/{{db}}?typ=column&name={{k.name}}&table={{tbl.name}}&ddl=drop" class="btn btn-danger" title="Drop field">
                            <i class="fa fa-trash"></i>
                        </a>
                    </div>

                </td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
