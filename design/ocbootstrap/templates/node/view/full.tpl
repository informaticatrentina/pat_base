{* Menu laterale *}
{def $side_menu=false()}
{if $node.object.state_identifier_array|contains('side_menu/active')}
    {set $side_menu=true()}
{/if}
      
{if and( $side_menu, $node.parent_node_id|ne(1), $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
    {include uri='design:nav/nav-section.tpl'}
{/if}


<div class="content-main {if $side_menu|not}wide{/if}">
    {def $openpa = object_handler($node)}
    {include uri=$openpa.control_template.full}
</div>