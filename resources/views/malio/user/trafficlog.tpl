<div id="scatter-plot"></div>
<script>
    ! function ($) {
        "use strict";

        var ChartC3 = function () {};

        ChartC3.prototype.init = function () {
            var xs_data = {};
            var columns_data = [];
            {foreach $logs as $single_log}
                var log_traffic = {number_format($single_log->totalUsedRaw()/1024,2,'.', '')};
                if ( log_traffic > 0.5) {
                    var node_name = '{$single_log->node()->name}'.split(" - ")[0];
                    var node_name_x = '{$single_log->node()->name}'.split(" - ")[0]+'_x';
                    if (!xs_data.hasOwnProperty(node_name)) {
                        xs_data[node_name] = node_name_x;
                        columns_data[node_name] = [node_name];
                        columns_data[node_name_x] = [node_name_x];
                    };
                    columns_data[node_name].push(log_traffic);
                    columns_data[node_name_x].push((new Date({$single_log->log_time*1000})));
                };
            {/foreach}
            var columns_data_edit = [];
            for (var column in columns_data) {
                columns_data_edit.push(
                    columns_data[column]
                )
            };
            //Scatter Plot
            c3.generate({
                bindto: '#scatter-plot',
                data: {
                    xs:xs_data,
                    columns: columns_data_edit,
                    type: 'scatter'
                },
                color: {
                    pattern: ["#1bb99a", "#f1b53d", "#007bff", "#6610f2", "#e83e8c", "#fd7e14", "#ffc107", "#6f42c1", "#28a745", "#20c997", "#17a2b8"]
                },
                tooltip: {
                    format: {
                        value: function (value) {
                            return value+'MB';
                        },
                        title: function (title) {
                            return title.toLocaleString('chinese',
                            {
                                hour12:false
                            }
                            )
                        }
                    }
                },
                axis: {
                    x: {
                        label: '时间',
                        type: 'timeseries',
                        tick: {
                            fit: false,
                            format: '%d日 %H:%M',
                            multiline: true,
                        }
                        
                    },
                    y: {
                        label: '流量/MB',
                    }
                }
                
            });


        },
        $.ChartC3 = new ChartC3, $.ChartC3.Constructor = ChartC3
    }(window.jQuery),

    //initializing 
    function ($) {
        "use strict";
        $.ChartC3.init()
    }(window.jQuery);
</script>