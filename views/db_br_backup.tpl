% include('_header.tpl')

<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li class="active">Backup Database</li>
        </ol>
    </div>
</div>


<div class="row">
    <div class="col-md-6">
        <form method="post" id="form-backup">
            <div class="form-group">
                <label for="backup_path">Select DB To Backed Up</label>
                <select name="db" id="backup-db-select">
                    %for k in appconf.db_config.sections():
                    <option value="{{k}}" {{'selected="selected"' if k == session['db'] else ''}}>{{k}}</option>
                    %end
                </select>
            </div>

            <div class="form-group">
                <label for="backup_path">Backup File Path</label>
                <span  class="help-block alert-warning">
                    Please note that, this path should be writable for firebird service
                </span>
                <input type="text" id="backup_path" name="backup_path" class="form-control" value="./static/backup">
            </div>

            <div class="form-group">
                <label for="backup_name">Backup File Name</label>
                %if session['db']:
                    <input type="text" id="backup_name" name="backup_name" class="form-control" value="{{session['db']}}.fbk">
                %else:
                    <input type="text" id="backup_name" name="backup_name" class="form-control">
                %end
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="ignore_checksums" value="1"> Ignore Checksums
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="ignore_limbo_transactions" value="1"> Ignore Limbo Transactions
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="metadata_only" value="1"> Metadata Only
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="collect_garbage" checked="checked" value="1"> Collect Garbage
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="transportable" checked="checked" value="1"> Transportable
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="convert_external_to_internal" checked="checked" value="1"> Convert external table to internal ones
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="compressed" checked="checked" value="1"> Compressed Backup
                </label>
            </div>

            <div class="checkbox">
                <label>
                    <input type="checkbox" name="no_db_triggers" checked="checked" value="1"> Disable database triggers temporarily
                </label>
            </div>

            <button class="btn btn-success" id="btn-backup">Backup</button>
        </form>
    </div>
</div>

<div class="row" style="margin-top: 10px;">
    <div class="col-md-12">
        <div class="alert alert-success" id="backup-link" style="display: none;">

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
                        Backing up your lovely database ...
                    </h4>
                </div>
            </div>
        </div>
    </div>
</div>


% include('_footer.tpl')


<script type="text/javascript">
$(document).ready(function(){
    $("#backup_name").val(slug("{{session['db']}}") + '.fbk');

    $("#btn-backup").click(function() {
        var data = $("#form-backup").serialize();

        $.ajax({
            method: "POST",
            url: "/backup",
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

                if (rslt.link != "") {
                    $("#backup-link").show();
                    $("#backup-link").html(rslt.link);
                } else {
                    $("#backup-link").text("Backup completed...")
                }
            } else {
                alert(rslt.message);
            }

        }).fail(function(rslt){



        }).always(function () {
            $('#processing-modal').modal('hide');

        });

        return false;
    });

    $("#backup-db-select").change(function () {
        var str = slug($("#backup-db-select option:selected").text()) + '.fbk';
        $("#backup_name").val(str);
        return false;
    });


}
);
</script>
