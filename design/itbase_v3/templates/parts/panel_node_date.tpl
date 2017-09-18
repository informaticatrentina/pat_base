{* Mev per visibilità data pubblicazione e/o data modifica*}
{def $resultSplit = ''
     $array_state_identifier = $node.object.state_identifier_array
     $stateExists = false()}
         
{foreach $array_state_identifier as $state_identifiert}         
    {set $resultSplit = $state_identifiert|explode( '/' )}
    {if eq($resultSplit[0] , 'hide_publish_date')}
        {set $stateExists = true()}
        {if $resultSplit[1]|eq('no')}
            {if $node|has_attribute('published')}
                {$node|attribute( 'published' ).content.timestamp|l10n( 'date' )}
            {elseif $node|has_attribute('data')}
                {$node|attribute( 'data' ).content.timestamp|l10n( 'date' )}
            {else}
                {$node.object.published|l10n('date')}
            {/if}
        {/if}
   {/if}
{/foreach}

{if $stateExists|not()}
    {if $node|has_attribute('published')}
        {$node|attribute( 'published' ).content.timestamp|l10n( 'date' )}
    {elseif $node|has_attribute('data')}
        {$node|attribute( 'data' ).content.timestamp|l10n( 'date' )}
    {else}
        {$node.object.published|l10n('date')}
    {/if}
{/if}

{undef $resultSplit
       $array_state_identifier}
       
       
            