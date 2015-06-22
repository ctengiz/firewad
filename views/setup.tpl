%setdefault('show_topbar', False)
%setdefault('show_sidebar', False)

% include('_header.tpl')

<div class="row">
    <div class="col-md-6 col-md-push-3">
        <div class="well">
            Some description here
        </div>

        <form method="post">
            <div class="form-group">
                <label for="db_server">Metadata Database Server</label>
                <input type="text" id="db_server" name="db_server" class="form-control" placeholder="Metadata Database Server">
            </div>
            <div class="form-group">
                <label for="db_path">Metadata Database Location</label>
                <input type="text" id="db_path" name="db_path" class="form-control" placeholder="Metadata Database Location">
            </div>
            <div class="form-group">
                <label for="db_user">Database User Name</label>
                <input type="text" class="form-control" id="db_user" name="db_user" placeholder="Database User Name">
            </div>
            <div class="form-group">
                <label for="db_pass">Database User Password</label>
                <input type="text" class="form-control" id="db_pass" name="db_pass" placeholder="Database User Password">
                <p class="help-block">Example block-level help text here.</p>
            </div>
            <div class="form-group">
                <label for="charset">Charset</label>
                <input type="text" class="form-control" id="charset" name="charset" placeholder="Database Charset" value="UTF8">
                <p class="help-block">Example block-level help text here.</p>
            </div>
            <button type="submit" class="btn btn-success">Submit</button>
        </form>

    </div>
</div>


% include('_footer.tpl')

