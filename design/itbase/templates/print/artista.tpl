<h1>
     {attribute_view_gui attribute=$node|attribute('nome')}
</h1>

{if $node|has_attribute( 'soggetto' )}    
    <h4>     
       Soggetto: {include uri='design:parts/related-selection.tpl' attribute=$node|attribute( 'soggetto' ) separatore=' -'}
   </h4>
{/if}

<p>
{if $node|has_attribute( 'occupazione' )}
    Si occupa di:
    {include uri='design:parts/related-selection.tpl' attribute=$node|attribute( 'occupazione' ) separatore=','}
{/if}
</p>

<p>
    {attribute_view_gui attribute=$node|attribute( 'descrizione' ) is_paradox=true()}
</p>

<p>
<ul>
{if $node|has_attribute('telefono')}
    <li>Telefono:
    {attribute_view_gui attribute=$node|attribute('telefono')}</li>
{/if}
{if $node|has_attribute('mobile')}
    <li>Mobile:
    {attribute_view_gui attribute=$node|attribute('mobile')}</li>
{/if}
{if $node|has_attribute('fax')}
    <li>Fax:
    {attribute_view_gui attribute=$node|attribute('fax')}</li>
{/if}
</ul>
</p>