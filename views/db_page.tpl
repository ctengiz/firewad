% import fdb

<!-- isc_info descriptions are taken from : Lua fbclient / fbclient_info_db.lua -->

<div class="row">
    <div class="col-md-5">
        <ul class="list-group">
            <li class="list-group-item row">
                <div class="col-md-6 text-right">Server Version</div>
                <div class="col-md-6 text-right">{{appconf.con[db].version}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">
                    Memory Usage (kb)
                    <a href="#" data-toggle="tooltip" title="Amount of server memory (in kbytes) currently in use"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{'{:,.2f}'.format(appconf.con[db].database_info(fdb.isc_info_current_memory, 'i') / 1024) }}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">
                    Max Mem Used (kb)
                    <a href="#" data-toggle="tooltip" title="Maximum amount of memory (in kbytes) used at one time since the first process attached to the database"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{'{:,.2f}'.format(appconf.con[db].db_info(fdb.isc_info_max_memory) / 1024)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Sql Dialect</div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_db_sql_dialect)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">ODS Version</div>
                <div class="col-md-6 text-right">{{appconf.con[db].ods}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">DB Creation Date</div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_creation_date)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">DB Is Readonly</div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_db_read_only)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Shutdown Mode</div>
                <div class="col-md-6 text-right">todo</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Backup State</div>
                <div class="col-md-6 text-right">todo</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Forced Writes
                    <a href="#" data-toggle="tooltip" title="Mode in which database writes are performed: true=sync, false=async"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_forced_writes)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Reserve No Space
                    <a href="#" data-toggle="tooltip" title="boolean: 20% page space is NOT reserved for holding backup versions of modified records"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_no_reserve)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Open Connections</div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_user_names)
                    <table class="table table-bordered table-condensed">
                        <tr><th>User</th><th>Con #</th></tr>
                        %for _xx in _kl:
                        <tr><td>{{_xx}}</td><td>{{_kl[_xx]}}</td></tr>
                        %end
                    </table>
                </div>
            </li>
            % _page_allocated = appconf.con[db].db_info(fdb.isc_info_allocation)
            % _page_size = appconf.con[db].db_info(fdb.isc_info_page_size)
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">
                    Pages Allocated
                    <a href="#" data-toggle="tooltip" title="Number of database pages allocated"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{'{:,}'.format(_page_allocated)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">
                    Page Size
                    <a href="#" data-toggle="tooltip" title="Number of bytes per page of the attached database"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{_page_size}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">
                    DB Size (mb)
                    <a href="#" data-toggle="tooltip" title="Page Size * Allocated Page Number"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{'{:,.2f}'.format((_page_size * _page_allocated) / (1024 * 1024)) }}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Buffers Allocated
                    <a href="#" data-toggle="tooltip" title="Number of memory buffers currently allocated"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_num_buffers)}}</div>
            </li>

            <!--
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">isc_info_db_file_size</div>
                <div class="col-md-6 text-right">appconf.con[db].db_info(fdb.isc_info_db_file_size)}}</div>
            </li>
            -->

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Oldest Transaction</div>
                <div class="col-md-6 text-right" style="text-align: right;">{{appconf.con[db].db_info(fdb.isc_info_oldest_transaction)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Oldest Active Transaction</div>
                <div class="col-md-6 text-right" style="text-align: right;">{{appconf.con[db].db_info(fdb.isc_info_oldest_active)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Oldest Snapshot</div>
                <div class="col-md-6 text-right" style="text-align: right;">{{appconf.con[db].db_info(fdb.isc_info_oldest_snapshot)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Next Transaction</div>
                <div class="col-md-6 text-right" style="text-align: right;">{{appconf.con[db].db_info(fdb.isc_info_next_transaction)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Active Transaction Count</div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_active_tran_count)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Sweep Interval
                    <a href="#" data-toggle="tooltip" title="Number of transactions that are committed between sweeps to remove database record versions that are no longer needed"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_sweep_interval)}}</div>
            </li>

            <!--
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">isc_info_limbo</div>
                <div class="col-md-6 text-right">todo : appconf.con[db].db_info(fdb.isc_info_limbo)}}</div>
            </li>
            -->
            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Attachment ID
                    <a href="#" data-toggle="tooltip" title="Attachment id number; att. IDs are in system table MON$ATTACHMENTS"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_attachment_id)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Page Reads
                    <a href="#" data-toggle="tooltip" title="Number of page reads"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right" style="text-align: right;">{{'{:,}'.format(appconf.con[db].db_info(fdb.isc_info_reads))}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Page Writes
                    <a href="#" data-toggle="tooltip" title="Number of page writes"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right" style="text-align: right;">{{'{:,}'.format(appconf.con[db].db_info(fdb.isc_info_writes))}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Cache Read
                    <a href="#" data-toggle="tooltip" title="Number of reads from the memory buffer cache"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right" style="text-align: right;">{{'{:,}'.format(appconf.con[db].db_info(fdb.isc_info_fetches))}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Cache Write
                    <a href="#" data-toggle="tooltip" title="Number of writes to the memory buffer cache"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right" style="text-align: right;">{{'{:,}'.format(appconf.con[db].db_info(fdb.isc_info_marks))}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">isc_info_set_page_buffers
                    <a href="#" data-toggle="tooltip" title="Number of transactions that are "><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_set_page_buffers)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Sequential Reads
                    <a href="#" data-toggle="tooltip" title="Number of sequential table scans (row reads) done on each table since the database was last attached"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_read_seq_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Indexed Reads
                    <a href="#" data-toggle="tooltip" title="Number of reads done via an index since the database was last attached"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_read_idx_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Insert Count
                    <a href="#" data-toggle="tooltip" title="Number of inserts into the database since the database was last attached"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_insert_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Update Count
                    <a href="#" data-toggle="tooltip" title="Number of database updates since the database was last attached"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_update_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Delete Count
                    <a href="#" data-toggle="tooltip" title="Number of database deletes since the database was last attached"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_delete_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Backout Count
                    <a href="#" data-toggle="tooltip" title="Number of removals of a version of a record"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_backout_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Purge Count
                    <a href="#" data-toggle="tooltip" title="Number of removals of old versions of fully mature records (records that are committed, so that older ancestor versions are no longer needed)"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_purge_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Expunge Count
                    <a href="#" data-toggle="tooltip" title="Number of removals of a record and all of its ancestors, for records whose deletions have been committed"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">
                    % _kl = appconf.con[db].db_info(fdb.isc_info_expunge_count)
                    % include('./incobj/isc_count', _kl=_kl)
                </div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Page Errors
                    <a href="#" data-toggle="tooltip" title="Number of page level errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_page_errors)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Record Errors
                    <a href="#" data-toggle="tooltip" title="Number of record level errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_record_errors)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Blob Page Errors
                    <a href="#" data-toggle="tooltip" title="Number of blob page errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_bpage_errors)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Data Page Errors
                    <a href="#" data-toggle="tooltip" title="Number of data page errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_dpage_errors)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Index Page Errors
                    <a href="#" data-toggle="tooltip" title="Number of index page errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_ipage_errors)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Pointer Page Errors
                    <a href="#" data-toggle="tooltip" title="Number of pointer page errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_ppage_errors)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-6 text-right" style="text-align: right;">Transaction Page Errors
                    <a href="#" data-toggle="tooltip" title="Number of transaction page errors validate found"><i class="fa fa-info-circle"></i></a>
                </div>
                <div class="col-md-6 text-right">{{appconf.con[db].db_info(fdb.isc_info_tpage_errors)}}</div>
            </li>

        </ul>
    </div>
</div>

