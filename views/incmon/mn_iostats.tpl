%from fdb.monitor import IOStatsInfo
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle {{'collapsed' if collapsed else ''}}" data-toggle="collapse"  href="#tbl-iostats-{{table_id}}">
                IO Statistics
            </a>
        </h4>
    </div>
    <% 
    if isinstance(data, IOStatsInfo):
        alist = []
        alist.append(data)
    else:
        alist = data
    end
    %>
    <div id="tbl-iostats-{{table_id}}" class="panel-collapse collapse {{'' if collapsed else 'in'}}">
        <table class="table table-bordered table-condensed text-right" style="background-color: #ffffff;">
            %for t in alist:
            <tr>
                <th class="text-right">Max. Memory Used</th><td class="text-right">{{'{:,}'.format(t.max_memory_used)}}</td>
                <th class="text-right">Max. Memory Allocated
                    <a href="#" data-toggle="tooltip" title="Maximum number of bytes allocated from the operating system by this object"><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right" >{{'{:,}'.format(t.max_memory_allocated )}}</td>

                <td style="border: none;"></td>

                <th class="text-right">Page Fetch Count
                    <!--<a href="#" data-toggle="tooltip" title="Number of records read sequentially."><i class="fa fa-info-circle"></i></a>-->
                </th><td class="text-right">{{'{:,}'.format(t.fetches)}}</td>
                <th class="text-right">Page Read Count
                    <!--<a href="#" data-toggle="tooltip" title="Number of records read via an index"><i class="fa fa-info-circle"></i></a>-->
                </th><td class="text-right">{{'{:,}'.format(t.reads)}}</td>

            </tr>

            <tr>
                <th class="text-right">Memory Used
                    <a href="#" data-toggle="tooltip" title="Number of bytes currently in use."><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.memory_used)}}</td>
                <th class="text-right">Memory Allocated
                    <a href="#" data-toggle="tooltip" title="Number of bytes currently allocated at the OS level"><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.memory_allocated )}}</td>

                <td style="border: none;"></td>

                <th class="text-right">Page Write Count
                    <!--<a href="#" data-toggle="tooltip" title="Number of records read sequentially."><i class="fa fa-info-circle"></i></a>-->
                </th><td class="text-right">{{'{:,}'.format(t.writes)}}</td>
                <th class="text-right">Pages Changes Pending
                    <!--<a href="#" data-toggle="tooltip" title="Number of records read via an index"><i class="fa fa-info-circle"></i></a>-->
                </th><td class="text-right">{{'{:,}'.format(t.marks)}}</td>
            </tr>

            <tr><td colspan="9"></td></tr>

            <tr>
                <th class="text-right">Sequential Reads
                    <a href="#" data-toggle="tooltip" title="Number of records read sequentially."><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.seq_reads)}}</td>
                <th class="text-right">Indexed Reads
                    <a href="#" data-toggle="tooltip" title="Number of records read via an index"><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.idx_reads)}}</td>

                <td style="border: none;"></td>

                <th class="text-right">Purges
                    <a href="#" data-toggle="tooltip" title="Number of records where record version chain is being
                                purged of versions no longer needed by OAT or younger transactions."><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.purges)}}</td>
                <th class="text-right">Expunges
                    <a href="#" data-toggle="tooltip" title="Number of records where record version chain is being
                                deleted due to deletions by transactions older than OAT"><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.expunges)}}</td>

            </tr>


            <tr>
                <th class="text-right">Inserted Records
                    <!--<a href="#" data-toggle="tooltip" title="Number of inserted records."><i class="fa fa-info-circle"></i></a>-->
                </th><td class="text-right">{{'{:,}'.format(t.inserts)}}</td>
                <th class="text-right">Updated Records
                    <!-- <a href="#" data-toggle="tooltip" title="Number of updated records"><i class="fa fa-info-circle"></i></a> -->
                </th><td class="text-right">{{'{:,}'.format(t.updates)}}</td>

                <td style="border: none;"></td>
            </tr>
            <tr>
                <th class="text-right">Deleted Records
                    <!--<a href="#" data-toggle="tooltip" title="Number of deleted records."><i class="fa fa-info-circle"></i></a>-->
                </th><td class="text-right">{{'{:,}'.format(t.deletes)}}</td>

                <th class="text-right">Backouts
                    <a href="#" data-toggle="tooltip" title="Number of records where a new primary record version
                                or a change to an existing primary record version is backed out due to rollback or savepoint
                                undo."><i class="fa fa-info-circle"></i></a>
                </th><td class="text-right">{{'{:,}'.format(t.deletes)}}</td>
            </tr>
            %end
        </table>
    </div>
</div>
