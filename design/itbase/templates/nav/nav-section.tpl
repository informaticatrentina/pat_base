{set_defaults( hash( 'type', 'absolute' ) )}
{def  $root_node_id = cond( $type|eq( 'relative' ), $node.path_array[$node.depth], $node.path_array[2] )
      $root_node = fetch( 'content', 'node', hash( 'node_id', $root_node_id ) )
      $menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                           'sort_by', $root_node.sort_array,
                           'load_data_map', false(),
                           'class_filter_type', 'include',
                           'class_filter_array', appini( 'MenuContentSettings', 'LeftIdentifierList', array() ) ) )
      $menu_items_count = $menu_items|count()
      $current_node_in_path = first_set($node.path_array[3], 0  )
}

{def $contentSettings = appini( 'MenuContentSettings', 'LeftIdentifierList', array() )}

<div class="nav-section">
  {if $menu_items_count}
    <ul class="nav">
      {foreach $menu_items as $key => $item}

        {node_view_gui content_node=$item
                       view='nav-section_item'
                       current_node_in_path=$current_node_in_path
                       current_node_id=$node.node_id
        }
        
      {/foreach}
    </ul>
  {/if}
  {undef $root_node $menu_items $menu_items_count}
</div>

{literal}
<script>
    // attiva o disattiva il sottomenu
    /*
    $('.activate-submenu').click(function( event ) {
        if ($(this).closest('li').children('ul').length) {
            $(this).closest('li').toggleClass('active');
            
            $(this).toggleClass('fa-caret-right');
            $(this).toggleClass('fa-caret-down');
            
            event.preventDefault();
        }
    });
    */
    
    $('.activate-submenu-a').click(function( event ) {
        if ($(this).closest('li').children('ul').length) {
            $(this).closest('li').toggleClass('active');
            
            $(this).children(":first").toggleClass('fa-caret-right');
            $(this).children(":first").toggleClass('fa-caret-down');
            
            event.preventDefault();
        }
    });
</script>
{/literal}

