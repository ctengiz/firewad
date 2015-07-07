<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle {{'collapsed' if collapsed else ''}}" data-toggle="collapse"  href="#tbl-variables-{{table_id}}">
                Variables
            </a>
        </h4>
    </div>
    <div id="tbl-variables-{{table_id}}" class="panel-collapse collapse {{'' if collapsed else 'in'}}">
        <table class="table table-bordered table-condensed" style="background-color: #ffffff;">
            <tr>
                <th>Name</th>
                <th>Value</th>
                <th>Is Connection Var</th>
                <th>Is Transaction Var</th>
            </tr>
            %for t in data:
            <tr>
                <td>{{t.name}}</td>
                <td>{{t.value}}</td>
                <td>{{t.isattachmentvar()}} {{' - %d' % t.attachment.id if t.isattachmentvar() else ''}}</td>
                <td>{{t.istransactionvar()}} {{' - %d' % t.transaction.id if t.istransactionvar() else ''}}</td>
            </tr>
            %end
        </table>
    </div>
</div>
