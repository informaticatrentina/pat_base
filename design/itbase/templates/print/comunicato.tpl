


<p>
    <b>Ufficio Stampa della Provincia autonoma di Trento</b>
    <br/>Piazza Dante 15, 38122 Trento
    <br/>Tel. 0461 494614 - Fax 0461 494615
    <br/>uff.stampa@provincia.tn.it
</p>
<p>
    <b>
        COMUNICATO
        {if $node|attribute( 'numero' ).data_int|ne(0)}
            n. 
            {attribute_view_gui attribute=$node|attribute( 'numero' )}
        {/if}
        del 
        {$node.data_map.published.content.timestamp|l10n('shortdate')}
    </b>
</p>

<h4>
    {if $node|has_attribute( 'occhiello' )}
        {attribute_view_gui attribute=$node|attribute( 'occhiello' )}
    {/if}
</h4>

<h1>
    {$node.name}
</h1>

<h3>
    {attribute_view_gui attribute=$node|attribute( 'abstract' )}
</h3>

<p>
    {attribute_view_gui attribute=$node|attribute( 'testo_completo' ) is_paradox=true()}
</p>