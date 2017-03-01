{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}
{def $footer_notes = footer('footer_notes')}

<div class="footer-logo">
    {if $root_node|attribute('logo_footer').content.original.url}
        <img src={$root_node|attribute('logo_footer').content.original.url|ezroot()} alt="{$root_node.name}" />
    {elseif $root_node|attribute('logo').content.original.url}
        <img src={$root_node|attribute('logo').content.original.url|ezroot()} alt="{$root_node.name}" />
    {/if}
</div>
<p class="footer-notes">
    {attribute_view_gui attribute=$footer_notes}
</p>
