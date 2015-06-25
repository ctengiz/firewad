% import fdb
<div class="row">
    <div class="col-md-6">
        <ul class="list-group">
            <li class="list-group-item row">
                <div class="col-md-4 text-right">Server Version</div>
                <div class="col-md-8">{{appconf.con[db].version}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Memory Usage (kb)</div>
                <div class="col-md-8">{{appconf.con[db].database_info(fdb.isc_info_current_memory, 'i') / 1024 }}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_max_memory</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_max_memory) / 1024}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_db_sql_dialect</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_db_sql_dialect)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_creation_date</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_creation_date)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">ODS Version</div>
                <div class="col-md-8">{{appconf.con[db].ods}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Open Connections</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_user_names)}}</div>
            </li>
            % _page_allocated = appconf.con[db].db_info(fdb.isc_info_allocation)
            % _page_size = appconf.con[db].db_info(fdb.isc_info_page_size)
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Pages Allocated</div>
                <div class="col-md-8">{{_page_allocated}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Page Size</div>
                <div class="col-md-8">{{_page_size}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">DB Size (mb)</div>
                <div class="col-md-8">{{(_page_size * _page_allocated) / (1024 * 1024) }}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Oldest Transaction</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_oldest_transaction)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Oldest Active Transaction</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_oldest_active)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Oldest Snapshot</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_oldest_snapshot)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Next Transaction</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_next_transaction)}}</div>
            </li>
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Active Transaction Count</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_active_tran_count)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">Allocation</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_allocation)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_no_reserve</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_no_reserve)}}</div>
            </li>


            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_forced_writes</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_forced_writes)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_num_buffers</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_num_buffers)}}</div>
            </li>

            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_sweep_interval</div>
                <div class="col-md-8">{{appconf.con[db].db_info(fdb.isc_info_sweep_interval)}}</div>
            </li>

            <!--
            <li class="list-group-item row">
                <div class="col-md-4 text-right" style="text-align: right;">isc_info_limbo</div>
                <div class="col-md-8">todo : appconf.con[db].db_info(fdb.isc_info_limbo, 'i')}}</div>
            </li>

    , , ,
    isc_info_attachment_id, isc_info_fetches, isc_info_marks, isc_info_reads,
    isc_info_writes, isc_info_set_page_buffers, isc_info_db_read_only,
    isc_info_db_size_in_pages, isc_info_page_errors, isc_info_record_errors,
    isc_info_bpage_errors, isc_info_dpage_errors, isc_info_ipage_errors,
    isc_info_ppage_errors, isc_info_tpage_errors,
    isc_info_oldest_transaction, isc_info_oldest_active,
    isc_info_oldest_snapshot, isc_info_next_transaction,
    isc_info_active_tran_count,
    isc_info_backout_count, isc_info_delete_count, isc_info_expunge_count,
    isc_info_insert_count, isc_info_purge_count, isc_info_read_idx_count,
    isc_info_read_seq_count, isc_info_update_count
    -->



        </ul>
    </div>
</div>

