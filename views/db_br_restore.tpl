% include('_header.tpl')

<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li class="active">Restore Database</li>
            <li><a href="/db/{{db}}">{{db}}</a></li>
        </ol>
    </div>
</div>


<div class="row">
    <div class="col-md-6">
        <form method="post" id="form-restore">

            <div class="form-group">
                <label for="source_filename">Source File Name</label>
                <input type="text" id="source_filename" name="source_filename" class="form-control" >
            </div>

            <div class="form-group">
                <label class="radio-inline">
                    <input type="radio" name="restore_target" id="restore-target-db" value="registered" checked="checked"> Restore to registered DB
                </label>
                <label class="radio-inline">
                    <input type="radio" name="restore_target" id="restore-target-new" value="new"> Restore to new DB
                </label>
            </div>

            <div id="new-db" style="display: none">
                <div class="form-group">
                    <label for="dest_filename">Dest File Name</label>
                    <input type="text" id="dest_filename" name="dest_filename" class="form-control">
                </div>

                <div class="form-group">
                    <label for="dest_filename">Server</label>
                    <input type="text" name="dest_server" class="form-control" value="127.0.0.1">
                </div>

                <div class="form-group">
                    <label for="passw">SYSDBA Password</label>
                    <input type="text" id="passw" name="passw" class="form-control">
                </div>
            </div>

            <div class="form-group" id="registered-db">
                <label for="dest_db">Restore backup to</label>
                <select name="dest_db" id="dest_db">
                    %for k in appconf.db_config.sections():
                    <option value="{{k}}" {{'selected="selected"' if k == session['db'] else ''}}>{{k}}</option>
                    %end
                </select>
            </div>

            <!--
            <div class="form-group">
                <label for="dest_file_pages">Dest File Pages</label>
                <input type="text" id="dest_file_pages" name="dest_file_pages" class="form-control" value="8192">
            </div>
            -->

            <div class="form-group">
                <label for="page_size">Page Size</label>
                <input type="text" id="page_size" name="page_size" class="form-control" value="8192">
            </div>

            <!--
            <div class="form-group">
                <label for="cache_buffers">Dest File Pages</label>
                <input type="text" id="cache_buffers" name="cache_buffers" class="form-control" value="8192">
            </div>
            -->

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="access_mode_read_only" value="1"> Create read-only database
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="replace" checked="checked" value="1"> Replace database
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="deactivate_indexes" value="1"> Deactivate Indices
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="do_not_restore_shpdows" value="1"> Do not restore shadows
                </label>
            </div>


            <div class="checkbox">
                <label>
                    <input type="checkbox" name="do_not_enforce_constraints" value="1"> Do not enforce constraints
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="commit_after_each_table" value="1"> Commit after each table
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="use_all_page_space" checked="checked" value="1"> Use all page space
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="no_db_triggers" value="1"> Disable database triggers temporarily
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="metadata_only" value="1"> Restore only database metadata
                </label>
            </div>

            <button class="btn btn-success" id="btn-restore">Restore</button>
        </form>
    </div>
</div>

<div class="row" style="margin-top: 10px;">
    <div class="col-md-12">
        <div class="alert alert-success" id="restore-link" style="display: none;">

        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <pre id="results" style="display: none;">

        </pre>
    </div>
</div>

<!-- Static Modal -->
<!-- Source : http://bootsnipp.com/snippets/featured/centered-processing-modal -->
<div class="modal modal-static fade" id="processing-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                        </div>
                    </div>
                    <h4>
                        Restoring your lovely database... Keep calm and leave it to Firebird
                    </h4>
                </div>
            </div>
        </div>
    </div>
</div>


% include('_footer.tpl')


<script type="text/javascript">
$(document).ready(function(){
    $("#btn-restore").click(function() {
        var data = $("#form-restore").serialize();

        $.ajax({
            method: "POST",
            url: "/restore",
            data: data,
            dataType: "json",
            beforeSend: function() {
                $('#processing-modal').modal('show');
            },
            error: function (e) {
            }
        }).done(function(rslt, textStatus, jqXH){
            if (rslt.success == 1) {
                $("#results").show();

                $("#results").text(rslt.report);
                $("#restore-link").text("Restore completed...")
            } else {
                alert(rslt.message);
            }
        }).fail(function(){

        }).always(function () {
            $('#processing-modal').modal('hide');

        });

        return false;
    });

    $("#restore-target-db").click(function () {
        $("#new-db").hide();
        $("#registered-db").show();
    });

    $("#restore-target-new").click(function () {
        $("#new-db").show();
        $("#registered-db").hide();
    });

}
);
</script>
