 {def $tmplabel = $label}
{set $tmplabel= $tmplabel|explode(' ')|implode('')|downcase()}
 
 <div class="form-group">
    <label for="{$id}">{$label}</label>
    <input type="text" 
           name="daterange{$tmplabel}" 
           value=""
           class="form-control date-picker" />
    
    {*<i class="glyphicon glyphicon-calendar fa fa-calendar"
       style="text-align:right; bottom: 25px; right:-10px;top: auto;"></i>*}
       
    <input id="data-{$id}" name="{$input_name}" value="{$value|wash()}" style="display: none" />
</div>

<script type="text/javascript">
    $(function(){ldelim}
            $('input[name="daterange{$tmplabel}"]').daterangepicker({ldelim}
             "locale": {ldelim}
                "format": "DD/MM/YYYY",
                "separator": " - ",
                "applyLabel": "Applica",
                "cancelLabel": "Annulla",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "daysOfWeek": [ "Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa"],
                "monthNames": [ "Gen","Feb", "Mar", "Apr", "Mag", "giu", "Lug", "Aug", "Setr", "Ottr", "Nov", "Dic"],
                "firstDay": 1
            {rdelim},
            "autoApply": true,
            {if $start}
                "startDate": '{$start}',
                "endDate": '{$end}',
            {else}
                "autoUpdateInput": false,
            {/if}
            "opens": "left"
            {rdelim}, function(start, end, label){literal}
                {
                    $("#data-{/literal}{$id}{literal}").val( Math.floor(start/1000) + '-' + Math.floor(end/1000) );
                } 
                {/literal}  
                );
        {rdelim});
        
        
        $('input[name="daterange{$tmplabel}"]').on('apply.daterangepicker', function(ev, picker) {ldelim}
            $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
        {rdelim});

        $('input[name="daterange{$tmplabel}"]').on('cancel.daterangepicker', function(ev, picker) {ldelim}
            $(this).val('');
        {rdelim}); 
        
</script>