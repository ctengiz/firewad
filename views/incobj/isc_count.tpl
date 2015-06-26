% _sum = 0
<table class="table table-bordered table-condensed">
    %for k in _kl.keys():
    % _sum += _kl[k]
    <tr>
        <td>
            %if k in appconf.ddl[db]['tables_id']:
            {{appconf.ddl[db]['tables_id'][k]}}
            %else:
            {{k}}
            %end
        </td>
        <td>{{_kl[k]}}</td>
    </tr>
    %end
    <tr>
        <td></td>
        <td>{{_sum}}</td>
    </tr>
</table>
