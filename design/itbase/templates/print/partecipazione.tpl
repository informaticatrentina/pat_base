<h1>
     {attribute_view_gui attribute=$node|attribute('titolo')}
</h1>

{if $node|has_attribute( 'nome' )}
    <h3>
    {attribute_view_gui attribute=$node|attribute('nome')}
    </h3>
{/if}
<p>
    <small>
    da <b>{$node|attribute( 'from_time' ).content.timestamp|l10n(date)}</b>
        {if $node.data_map.to_time.has_content}
            a <b>{$node|attribute( 'to_time' ).content.timestamp|l10n(date)}</b>
        {/if}
        {if $node|has_attribute('note_orario')}     
         {attribute_view_gui attribute=$node|attribute( 'note_orario' )}
       {/if}
    </small>
    
</p>
<p>
    {if $node|has_attribute('ente')}
        Ente: {attribute_view_gui attribute=$node|attribute('ente')}
    {/if}        
    {if $node|has_attribute('sede')}
        Sede: {attribute_view_gui attribute=$node|attribute('sede')}
    {/if}   
    {if $node|has_attribute( 'indirizzo' )}
            
                {attribute_view_gui attribute=$node|attribute('indirizzo')}
    {/if}    
</p>

<p>
    {attribute_view_gui attribute=$node|attribute( 'testo_completo' ) is_paradox=true()}
</p>
<p>
<ul>
{if $node|has_attribute('stato')}
    <li>Stato:
    {attribute_view_gui attribute=$node|attribute('stato')}</li>
{/if}
{if $node|has_attribute('tipologia')}
    <li>Tipologia:
    {attribute_view_gui attribute=$node|attribute('tipologia')}</li>
{/if}
{if $node|has_attribute('ambito')}
    <li>Ambito:
    {attribute_view_gui attribute=$node|attribute('ambito')}</li>
{/if}
</ul>
</p>