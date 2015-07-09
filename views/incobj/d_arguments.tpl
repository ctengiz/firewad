<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse"  href="#tbl-field">
                Arguments
            </a>
        </h4>
    </div>
    <div id="tbl-field" class="panel-collapse collapse in">
        <table class="table table-condensed table-bordered">
            <thead>
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Type</th>
                <th>Mechanism</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            %for k in tbl.arguments:
            <tr id="field-{{k.name}}">
                <td>{{k.position}}</td>
                <td>{{k.name}}</td>
                <td style="word-wrap: break-word">{{k.datatype}}</td>
                <td>{{k.mechanism}}</td>
                <td>

                </td>
            </tr>
            %end
            </tbody>
        </table>
    </div>
</div>
