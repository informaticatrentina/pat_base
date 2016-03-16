{def $dipendenti = fetch( 'openpa', 'dipendenti', hash( 'struttura', $struttura ) )
     $informatici = fetch( 'openpa', 'dipendenti', hash( 'struttura', $struttura, 'subtree', array( openpaini( 'ControlloUtenti', 'referenti_informatici' ) ) ) )
	   $editors = fetch( 'openpa', 'dipendenti', hash( 'struttura', $struttura, 'subtree', array( openpaini( 'ControlloUtenti', 'redattori' ) ) ) )}	

{if $dipendenti|count()}	
<div class="row attribute-personale">
    <div class="col-md-3"><strong>Personale</strong></div>
    <div class="col-md-9">

    <ul class="list-unstyled">   
    {foreach $dipendenti as $item}
        <li><a href={$item.url_alias|ezurl()}>{$item.name}</a>

        {def $telefoni_correlati=fetch('content', 'list',
                    hash('parent_node_id', openpaini( 'ControlloUtenti', 'telefoni' ),
                         'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 
                            'params', array(openpaini( 'ControlloUtenti', 'utente_telefono_attribute_ID' ), $item.contentobject_id) ) ) )}
        {if $telefoni_correlati|count()}
            {foreach $telefoni_correlati as $tel_correlato}
                <small>
                {$tel_correlato.name} 					
                {if $tel_correlato.data_map.numero_interno.has_content}
                    (interno: {attribute_view_gui attribute=$tel_correlato.data_map.numero_interno})
                {/if}
                </small>
            {/foreach}
        {elseif is_set( $item.data_map.telefono )}
            <small>{attribute_view_gui attribute=$item.data_map.telefono}</small>
        {/if}
        {undef $telefoni_correlati}
        </li>    
    {/foreach}
    </ul>
    
    {if $informatici|count()}	
    <h5>Referenti informatici</h5>
    <ul class="list-unstyled">   
    {foreach $informatici as $item}
        <li><a href={$item.url_alias|ezurl()}>{$item.name}</a></li>     
    {/foreach}
    </ul>
    {/if}
    
    {if $editors|count()}	
    <h5>Redattori sito/intranet</h5>
    <ul class="list-unstyled">   
    {foreach $editors as $item}
        <li><a href={$item.url_alias|ezurl()}>{$item.name}</a></li>     
    {/foreach}
    </ul>
    {/if}

    </div>
</div>

{/if}	