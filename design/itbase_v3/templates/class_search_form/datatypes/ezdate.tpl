
{def $fromTimestamp = false()}
{def $endTimestamp = false()}

{if and(is_set($input.value), $input.value)}
    {set $fromTimestamp = $input.value|explode('-')[0]}
    {set $endTimestamp = $input.value|explode('-')[1]}
    
    {set $fromTimestamp = $fromTimestamp|datetime( 'custom', '%d/%m/%Y' )}
    {set $endTimestamp = $endTimestamp|datetime( 'custom', '%d/%m/%Y' )}
{/if}


{include uri = 'design:class_search_form/form_fields/date_range_calendar_double.tpl'
		 label = $input.class_attribute.name
		 placeholder = 'gg-mm-aaaa'
		 value = $input.value
                 start = $fromTimestamp
                 end = $endTimestamp
		 input_name = $input.name
         bounds = $input.bounds
         current_bounds = $input.current_bounds
		 id = concat('search-for-',$input.id)}