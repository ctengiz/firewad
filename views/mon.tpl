% include('_header.tpl')

% include('./incmon/mn_header.tpl')

%if mon_template != '':
    % include(mon_template)
%end

% include('_footer.tpl')

<script src="/static/ace/ace.js"></script>
<script src="/static/ace/ext-language_tools.js"></script>
<script src="/static/ace/ext-statusbar.js"></script>


<script type="text/javascript">

$(document).ready(function() {
    $('.mon-action').click(function () {
        var _url = "/mon/{{db}}/info/" + $(this).data('info-type') + '/' + $('#mon-key').val();
        window.location.href = _url;
        return false;
    });
});


</script>