%setdefault('show_topbar', False)
%setdefault('show_sidebar', False)

% include('_header.tpl')

<div class="row">
    <div class="col-md-6 col-md-push-3">
        <div class="well">
            Some description here
        </div>

        <form method="post">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="login_required" value="1"> Login Required
                </label>
            </div>
            <button type="submit" class="btn btn-success btn-sm">Submit</button>
        </form>
    </div>
</div>


% include('_footer.tpl')

