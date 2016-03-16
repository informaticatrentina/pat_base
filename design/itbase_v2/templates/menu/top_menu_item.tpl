{def $node_icon = $menu_item.item.node_id}

<a href="{if $menu_item.item.internal}{$menu_item.item.url|ezurl(no)}{else}{$menu_item.item.url}{/if}" 
   {if $menu_item.item.target}target="{$menu_item.item.target}"{/if} 
   title="Vai a {$menu_item.item.name|wash()}">
    
    {if is_set($bold)}<b>{/if}
        {$menu_item.item.name|wash()}
    {if is_set($bold)}</b>{/if}
        
    {*if ezini_hasvariable('MenuItemIcons', concat('Node_', $node_icon), 'fa_icons.ini')} 
        <i class="fa {ezini('MenuItemIcons', concat('Node_', $node_icon), 'fa_icons.ini')}"></i>
    {/if*}
</a>