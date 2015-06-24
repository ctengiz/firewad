<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li class="active">Sequences</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <table class="table table-condensed">
            <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Internal ID</th>
                <th>Value</th>
            </tr>
            </thead>
            <tbody>
            %for k in tbl:
            <tr>
                <td>{{k.name}}</td>
                <td>{{k.description}}</td>
                <td>{{k.id}}</td>
                <td style="text-align: right;">{{k.value}}</td>
            </tr>
            %end
            </tbody>
        </table>
        </div>
    </div>
</div>
