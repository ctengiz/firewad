<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse"  href="#tbl-field">
                {{pnlt}}
            </a>
        </h4>
    </div>
    <div id="tbl-field" class="panel-collapse collapse in">
        <table class="table table-condensed">
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
                <td>{{k.datatype}}</td>
                <td>{{k.domain.name}}</td>
                <td>
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isnullable() else '&nbsp;'}}
                </td>
                <td>{{k.domain.expression}}</td>
                <td>{{k.domain.default}}</td>
                <td>{{k.description}}</td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
