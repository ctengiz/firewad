<div class="row">
    <div class="col-xs-12">
        <ol class="breadcrumb">
            <li><a href="/db/{{db}}">{{db}}</a></li>
            <li><a href="/db/roles/{{db}}">Roles</a></li>
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
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#tbl-privileges">
                            Privileges
                        </a>
                    </h4>
                </div>
                <div id="tbl-privileges" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <table class="table table-bordered table-condensed">
                            <thead>
                            <tr>
                                <th>Priviledge Subject</th>
                                <th>Field Name</th>
                                <th>Privilege</th>
                                <th>Grant Option</th>
                                <th>Membership</th>
                                <th>Grantor Name</th>
                                <th>Name</th>
                            </tr>
                            </thead>
                            <tbody>
                            %for k in tbl.privileges:
                            <tr>
                                <td>
                                    %if k.subject_type == 0:
                                        <a href="/db/table/{{db}}/{{k.subject_name}}">{{k.subject_name}}</a>
                                    %elif k.subject_type == 5:
                                        <a href="/db/procedure/{{db}}/{{k.subject_name}}">{{k.subject_name}}</a>
                                    %elif k.subject_type == 1:
                                        <a href="/db/view/{{db}}/{{k.subject_name}}">{{k.subject_name}}</a>
                                    %elif k.subject_type == 13:
                                        <a href="/db/role/{{db}}/{{k.subject_name}}">{{k.subject_name}}</a>
                                    %else:
                                        {{k.subject_name}}
                                    %end
                                </td>
                                <td>{{k.field_name}}</td>
                                <td>{{k.privilege}}</td>

                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.has_grant() else '&nbsp;'}}
                                </td>
                                <td class="text-center">
                                    {{! '<span class="glyphicon glyphicon-ok"></span>' if k.ismembership() else '&nbsp;'}}
                                </td>
                                <td>{{k.grantor_name}}</td>
                                <td>{{k.name}}</td>
                            </tr>
                            %end
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            %include('./incobj/d_dependents.tpl')
            %include('./incobj/d_dependencies.tpl')

            %if tbl.name != 'RDB$ADMIN':
                %include('./incobj/d_ddl.tpl', ddl_type='create')
            %end
            %include('./incobj/d_description.tpl', pobj='role')

        </div>



    </div>
</div>
