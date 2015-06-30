<%
if not defined('ftyp'):
    setdefault('ftyp', 'register')
end
%>

<div class="row">
    <div class="col-md-6">
        <form method="post">
            <input type="hidden" name="old_alias" value="{{reg['db_alias']}}">
            <div class="form-group">
                <label for="db_alias">Alias</label>
                <input type="text" id="db_alias" name="db_alias" class="form-control" placeholder="Database Alias" value="{{reg['db_alias']}}">
            </div>
            <div class="form-group">
                <label for="db_server">Database Server</label>
                <input type="text" id="db_server" name="db_server" class="form-control" placeholder="Database Server" value="{{reg['db_server']}}">
            </div>
            <div class="form-group">
                <label for="db_path">Database Location</label>
                <input type="text" id="db_path" name="db_path" class="form-control" placeholder="Database Path" value="{{reg['db_path']}}">
            </div>

            %if ftyp == 'create':
            <div class="form-group">
                <label for="db_name">Database File Name</label>
                <input type="text" id="db_name" name="db_name" class="form-control" placeholder="Database File Name">
            </div>
            %end

            <div class="form-group">
                <label for="db_user">Database User Name</label>
                <input type="text" class="form-control" id="db_user" name="db_user" placeholder="Database User Name" value="{{reg['db_user']}}">
            </div>
            <div class="form-group">
                <label for="db_pass">Database User Password</label>
                <input type="text" class="form-control" id="db_pass" name="db_pass" placeholder="Database User Password" value="{{reg['db_pass']}}">
            </div>
            %if ftyp == 'register':
            <div class="form-group">
                <label for="db_role">Role</label>
                <input type="text" class="form-control" id="db_role" name="db_role" placeholder="Role" value="{{reg['db_role']}}">
            </div>
            %end

            %if ftyp == 'register':
            <div class="form-group">
                <label for="charset">Dialect</label>
                <select class="form-control" id="dialect" name="dialect">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3" selected="selected">3</option>
                </select>
            </div>
            %end

            %if ftyp == 'create':
            <div class="form-group">
                <label for="db_name">Page Size</label>
                <select class="form-control" name="db_page_size" id="db_page_size">
                    <option value="4096">4096</option>
                    <option value="8192" selected="selected">8192</option>
                    <option value="16384">16384</option>
                </select>
            </div>
            %end

            <div class="form-group">
                <label for="charset">Charset</label>
                <select class="form-control" id="charset" name="charset">
                    % chset = ['NONE', 'ASCII', 'UNICODE_FSS', 'UTF8', 'ISO8859_1', 'ISO8859_2', 'ISO8859_3', 'ISO8859_4', 'ISO8859_5', 'ISO8859_6', 'ISO8859_7', 'ISO8859_8', 'ISO8859_9', 'ISO8859131', 'WIN1250', 'WIN1251', 'WIN1252', 'WIN1253', 'WIN1254', 'WIN1255', 'WIN1256', 'WIN1257', 'WIN1258', 'DOS437', 'DOS737', 'DOS775', 'DOS850', 'DOS852', 'DOS857', 'DOS858', 'DOS860', 'DOS861', 'DOS862', 'DOS863', 'DOS864', 'DOS865', 'DOS866', 'DOS869', 'BIG_5', 'KOI8R', 'CYRL', 'DB_RUS', 'PDOX_CYRL', 'KSC_5601', 'KSC_DICTIONARY', 'NEXT', 'NXT_DEU', 'NXT_ESP', 'NXT_FRA', 'NXT_ITA', 'NXT_US', 'SJIS_0208', 'EUCJ_0208', 'GB_2312', 'CP943C', 'TIS620']
                    %for ch in chset:
                    <option value="{{ch}}" {{!'selected="selected"' if ch==reg['charset'] else ""}}>{{ch}}</option>
                    %end
                </select>
            </div>
            <button type="submit" class="btn btn-success">Submit</button>
        </form>

    </div>
</div>

