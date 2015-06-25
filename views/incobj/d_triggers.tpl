<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle collapsed" data-toggle="collapse" href="#tbl-trigger">
                Triggers
            </a>
        </h4>
    </div>
    <div id="tbl-trigger" class="panel-collapse collapse">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>Name</th>
                <th style="text-align: center;">Is Active</th>
                <th style="text-align: center;">Position</th>
                <th style="text-align: center;">BI</th>
                <th style="text-align: center;">BU</th>
                <th style="text-align: center;">BD</th>
                <th style="text-align: center;">AI</th>
                <th style="text-align: center;">AU</th>
                <th style="text-align: center;">AD</th>
            </tr>
            </thead>
            <tbody>
            %for k in tbl.triggers:
            <tr>
                <td>
                    <a href="/trigger/{{db}}/{{k.name}}">{{k.name}}</a>
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isactive() else '<span class="glyphicon glyphicon-ban-circle"></span>'}}
                </td>
                <td style="text-align: center;">{{k.sequence}}</td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isbefore() and k.isinsert() else '&nbsp;'}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isbefore() and k.isupdate() else '&nbsp;'}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isbefore() and k.isdelete() else '&nbsp;'}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isafter() and k.isinsert() else '&nbsp;'}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isafter() and k.isupdate() else '&nbsp;'}}
                </td>
                <td style="text-align: center;">
                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.isafter() and k.isdelete() else '&nbsp;'}}
                </td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
