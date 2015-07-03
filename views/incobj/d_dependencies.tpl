<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-depedencies">
                <i class="fa fa-share"></i> Dependencies
            </a>
        </h4>
    </div>
    <div id="tbl-depedencies" class="panel-collapse collapse">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>Type</th>
                <th>Name</th>
                <th>Field</th>
            </tr>
            </thead>
            <tbody>
            %for k in sorted(tbl.get_dependencies(), key=lambda k: str(k.depended_on_type) + '-' + str(k.depended_on_name) + '-' + str(k.field_name)):
                %if k.field_name:
                    % utyp = get_rdb_type(k.depended_on_type)
                    % ntyp = utyp.upper()
                    <tr>
                        <td>{{ntyp}}</td>
                        <td><a href="/db/{{utyp}}/{{db}}/{{k.depended_on_name}}">{{k.depended_on_name}}</a></td>
                        <td><a href="/db/{{utyp}}/{{db}}/{{k.depended_on_name}}#field-{{k.field_name}}">{{k.field_name}}</a></td>
                    </tr>
                %end
            %end
            </tbody>
        </table>
    </div>
</div>
