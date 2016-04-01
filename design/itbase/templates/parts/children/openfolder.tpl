
{*
    Scendo di 2 livelli nelle cartelle
*}

{set_defaults( hash(
  'page_limit', 10,
  'view', 'line',
  'delimiter', '&nbsp;',
  'exclude_classes', openpaini( 'ExcludedClassesAsChild', 'FromFolder', array( 'image', 'infobox', 'global_layout' ) ),
  'include_classes', array(),
  'type', 'exclude',
  'fetch_type', 'list',
  'parent_node', $node,
  'image_class', 'small',
  'open_folder', false()
))}

{if $type|eq( 'exclude' )}
{def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
{else}
{def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
{/if}

{def $children_count = fetch( openpa, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $parent_node.node_id )|merge( $params ) )
   $children = fetch( openpa, $fetch_type, hash( 'parent_node_id', $parent_node.node_id,
                                                  'offset', $view_parameters.offset,
                                                  'sort_by', $parent_node.sort_array,
                                                  'limit', $page_limit )|merge( $params ) ) }


{if $children_count}
    {if $parent_node.data_map.children_view.data_text|eq(8)}
        {set $open_folder = true()}
    {/if}

    <div class="content-view-children">  
 
        {foreach $children as $child }
           
                {node_view_gui view=$view content_node=$child image_class=$image_class open_folder=$open_folder folder_level=1}
                
                {def $children2_count = fetch( openpa, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $child.node_id )|merge( $params ) )
                     $children2 = fetch( openpa, $fetch_type, hash( 'parent_node_id', $child.node_id,
                                                                    'offset', $view_parameters.offset,
                                                                    'sort_by', $child.sort_array,
                                                                    'limit', $page_limit )|merge( $params ) ) }
                {if $children2_count}
                    
                        {foreach $children2 as $child2 }
                            {node_view_gui view=$view content_node=$child2 image_class=$image_class open_folder=$open_folder folder_level=2}
                        {/foreach}
                    
                {/if}
                <div class="spacer">{$delimiter}</div>
                
         {/foreach}
        
    </div>

  {*include  name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$node.url_alias
            item_count=$children_count
            view_parameters=$view_parameters
            item_limit=$page_limit*}

{/if}