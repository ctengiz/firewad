<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-index">
                Indices
            </a>
        </h4>
    </div>
    <div id="tbl-index" class="panel-collapse collapse">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>Name</th>
                <th>Fields</th>
                <th style="text-align: center;">Enforcer</th>
                <th>Sorting</th>
                <th>Unique</th>
                <th>Active</th>
                <th>Expression</th>
                <th>Statistics</th>
                <th>Opr</th>
            </tr>
            </thead>
            <tbody>
            %for k in sorted(tbl.indices, key=lambda k: str(k.name)):
            <tr>
                <td>{{k.name}}</td>
                <td>
                    %for fname in k.segment_names:
                    <a href="#field-{{fname}}">{{fname}}</a>
                    %end
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isenforcer() else '&nbsp;'}}
                </td>
                <td>
                    {{k.index_type}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isunique() else '&nbsp;'}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if not k.isinactive() else '&nbsp;'}}
                </td>
                <td>
                    {{k.expression}}
                </td>
                <td style="text-align: right;">
                    {{k.statistics}}
                </td>
                <td>

                </td>

            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
