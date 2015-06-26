% _sum = 0
<table class="table table-bordered table-condensed">
    %for k in _kl.keys():
    % _sum += _kl[k]
    <tr>
        <td>{{k}}</td>
        <td>{{_kl[k]}}</td>
    </tr>
    %end
    <tr>
        <td></td>
        <td>{{_sum}}</td>
    </tr>
</table>
