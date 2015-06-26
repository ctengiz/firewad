<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-dependents">
                Dependents
            </a>
        </h4>
    </div>
    <div id="tbl-dependents" class="panel-collapse collapse">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>Type</th>
                <th>Name</th>
                <th>Field</th>
            </tr>
            </thead>
            <tbody>
            %for k in sorted(tbl.get_dependents(), key=lambda k: str(k.dependent_type) + '-' + str(k.dependent_name) + '-' + str(k.field_name)):
                %if k.field_name:
                    % utyp = get_rdb_type(k.dependent_type)
                    % ntyp = utyp.upper()
                    <tr>
                        <td>{{ntyp}}</td>
                        <td><a href="/db/{{utyp}}/{{db}}/{{k.dependent_name}}">{{k.dependent_name}}</a></td>
                        <td>
                            <a href="/db/{{utyp}}/{{db}}/{{k.dependent_name}}#field-{{k.field_name}}">{{k.field_name}}</a>
                        </td>
                    </tr>
                %end
            %end
            </tbody>
        </table>
    </div>
</div>
