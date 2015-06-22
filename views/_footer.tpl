<%
if not defined('show_topbar'):
    setdefault('show_topbar', True)
end

if not defined('show_sidebar'):
    setdefault('show_sidebar', True)
end
%>


    %if show_sidebar:
        </div> <!-- col -->
    %end
    </div> <!-- row -->
</div> <!-- Container -->

<footer class="footer do-not-print">
    <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
    </div>
</footer>



<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/static/libs/jquery/jquery-2.1.3.min.js"></script>
<script src="/static/libs/bootstrap/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/static/libs/bootstrap/js/ie10-viewport-bug-workaround.js"></script>
<!-- Invigo Core Js -->
<script src="/static/libs/invigo/invigo.js"></script>
</body>
</html>
