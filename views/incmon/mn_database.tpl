<div class="row">
    <div class="col-md-5">
        <ul class="list-group">
            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right">Cache Size (Page Buffers)</div>
                    <div class="col-md-6 text-right">{{data.cache_size}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">DB Creation Date</div>
                    <div class="col-md-6 text-right">{{data.created.strftime('%d.%m.%Y %H:%M:%S')}}</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Forced Writes</div>
                    <div class="col-md-6 text-right">{{data.forced_writes}}</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right">DB Path or Alias</div>
                    <div class="col-md-6 text-right">{{data.name}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Sql Dialect</div>
                    <div class="col-md-6 text-right">{{data.sql_dialect}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">ODS Version</div>
                    <div class="col-md-6 text-right">{{data.ods}}</div>
                </div>
            </li>


            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">DB Is Readonly</div>
                    <div class="col-md-6 text-right">{{data.read_only}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Shutdown Mode</div>
                    <div class="col-md-6 text-right">
                        %if data.shutdown_mode == 0:
                            Online
                        %elif data.shutdown_mode == 1:
                            Multi-User Shutdown
                        %elif data.shutdown_mode == 2:
                            Single-User Shutdown
                        %elif data.shutdown_mode == 3:
                            Full Shutdown
                        %end
                    </div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right">Backup State</div>
                    <div class="col-md-6 text-right">
                        %if data.backup_state == 0:
                            Normal
                        %elif data.backup_state == 1:
                            Stalled
                        %elif data.backup_state == 2:
                            Merge
                        %end
                    </div>
                </div>
            </li>

            % _page_allocated = data.pages
            % _page_size = data.page_size
            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">
                        Pages Allocated
                        <a href="#" data-toggle="tooltip" title="Number of database pages allocated"><i class="fa fa-info-circle"></i></a>
                    </div>
                    <div class="col-md-6 text-right">{{'{:,}'.format(_page_allocated)}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">
                        Page Size
                        <a href="#" data-toggle="tooltip" title="Number of bytes per page of the attached database"><i class="fa fa-info-circle"></i></a>
                    </div>
                    <div class="col-md-6 text-right">{{_page_size}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">
                        DB Size (mb)
                        <a href="#" data-toggle="tooltip" title="Page Size * Allocated Page Number"><i class="fa fa-info-circle"></i></a>
                    </div>
                    <div class="col-md-6 text-right">{{'{:,.2f}'.format((_page_size * _page_allocated) / (1024 * 1024)) }}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Oldest Transaction</div>
                    <div class="col-md-6 text-right" style="text-align: right;">{{data.oit}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Oldest Active Transaction</div>
                    <div class="col-md-6 text-right" style="text-align: right;">{{data.oat}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Oldest Snapshot</div>
                    <div class="col-md-6 text-right" style="text-align: right;">{{data.ost}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Next Transaction</div>
                    <div class="col-md-6 text-right" style="text-align: right;">{{data.next_transaction}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Sweep Interval
                        <a href="#" data-toggle="tooltip" title="Number of transactions that are committed between sweeps to remove database record versions that are no longer needed"><i class="fa fa-info-circle"></i></a>
                    </div>
                    <div class="col-md-6 text-right">{{data.sweep_interval}}</div>
                </div>
            </li>

            <li class="list-group-item">
                <div class="row">
                    <div class="col-md-6 text-right" style="text-align: right;">Reserve No Space
                        <a href="#" data-toggle="tooltip" title="boolean: 20% page space is NOT reserved for holding backup versions of modified records"><i class="fa fa-info-circle"></i></a>
                    </div>
                    <div class="col-md-6 text-right">{{data.reserve_space}}</div>
                </div>
            </li>
        </ul>
    </div>

    <div class="col-md-7">
        % include('./incmon/mn_iostats.tpl', table_id = 'db-%d' % data.stat_id, data = data.iostats, collapsed=False)
    </div>
</div>
