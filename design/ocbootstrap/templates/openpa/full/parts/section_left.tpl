<div class="nav-section">

    {if count($tree_menu.children)|gt(0)}
    <div class="widget">
        {if $node.node_id|ne($openpa.control_menu.side_menu.root_node.node_id)}
        <div class="widget_title">
            <h3>{$openpa.control_menu.side_menu.root_node.name|wash()}</h3>
        </div>
        {/if}
        <div class="widget_content">
            <ul class="side_menu">
                {foreach $tree_menu.children as $menu_item}
                    {include name=side_menu uri='design:menu/side_menu_item.tpl' menu_item=$menu_item current_node=$node}
                {/foreach}
           </ul>
        </div>
    </div>
    {/if}

</div>