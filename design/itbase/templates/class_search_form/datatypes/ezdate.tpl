{* 
    Faccio l'override poiché a priori non conosco i limiti (bounds)
    entro eseguire la ricerca.
    Utilizzo quindi 01/01/2010 come limite inferiore e la data odierna come
    limite superiore.
    
    L'originale si trova in ocsearchtools.
*}

{def $start_date=makedate(1, 1, 2010)|mul(1000)}
{def $end_date=currentdate()|mul(1000)}

{def $bounds = hash('start_js', $start_date, 'end_js', $end_date)}
{def $current_bounds = hash('start_js', $start_date, 'end_js', $end_date)}

{if ezhttp_hasvariable( $input.name, 'get' )}
    {def $current=ezhttp( $input.name, 'get' )}
    
    {if $current|contains('-')}
        {set $current = $current|explode('-')}
        
        {set $current_bounds = hash('start_js', $current[0]|mul(1000), 'end_js', $current[1]|mul(1000))}
    {/if}
    
    {undef $current}
{/if}

{include uri = 'design:class_search_form/form_fields/date_slider.tpl'
		 label = $input.class_attribute.name
		 placeholder = 'gg-mm-aaaa'
		 value = $input.value
		 input_name = $input.name
                 bounds = $bounds
                 current_bounds = $current_bounds
		 id = concat('search-for-',$input.id)}
                          
{undef $start_date}
{undef $end_date}
{undef $bounds}
{undef $current_bounds}