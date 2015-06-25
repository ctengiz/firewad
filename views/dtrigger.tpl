<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/">{{db}}</a></li>
            <li><a href="/triggers/{{db}}/{{tbl.name}}">Triggers</a></li>
            <li class="active">{{tbl.name}}</li>
        </ol>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="panel-group" id="accordion">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-properties">
                            Properties
                        </a>
                    </h4>
                </div>
                <div id="tbl-properties" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-3">
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Is Active</th>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isactive() else '<span class="glyphicon glyphicon-ban-circle"></span>'}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Is Database Trigger</th>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isdbtrigger() else '<span class="glyphicon glyphicon-ban-circle"></span>'}}
                                        </td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <th>Position</th>
                                        <td>{{tbl.sequence}}</td>
                                    </tr>
                                </table>
                            </div>

                            <div class="col-xs-3">
                                <table class="table table-condensed table-bordered">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th style="text-align: center;">Insert</th>
                                        <th style="text-align: center;">Update</th>
                                        <th style="text-align: center;">Delete</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <th>Before</th>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isbefore() and tbl.isinsert() else '&nbsp;'}}
                                        </td>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isbefore() and tbl.isupdate() else '&nbsp;'}}
                                        </td>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isbefore() and tbl.isdelete() else '&nbsp;'}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>After</th>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isafter() and tbl.isinsert() else '&nbsp;'}}
                                        </td>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isafter() and tbl.isupdate() else '&nbsp;'}}
                                        </td>
                                        <td style="text-align: center;">
                                            {{! '<span class="glyphicon glyphicon-ok"></span>' if tbl.isafter() and tbl.isdelete() else '&nbsp;'}}
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_dependencies.tpl')
            %include('./incobj/d_ddl.tpl')
            %include('./incobj/d_description.tpl')

        </div>



    </div>
</div>
