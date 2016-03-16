
{if is_set($show_short_description)}
    {if eq($show_short_description, 1 )}
        {if $node|has_attribute( 'short_description' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'short_description' )}
            </div>
        {/if}
    {/if}
{/if}

{set_defaults( hash(
  'page_limit', 24,  
  'delimiter', '',
  'exclude_classes', openpaini( 'ExcludedClassesAsChild', 'FromFolder', array( 'image', 'infobox', 'global_layout' ) ),
  'include_classes', array(),
  'type', 'exclude',
  'fetch_type', 'list',
  'parent_node', $node,
  'col-width', 6,
  'modulo', 2
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
  <div class="content-view-children">
    <div class="row panels-container">
    {foreach $children as $child }
      <div class="col-md-{$col-width}">
        {node_view_gui content_node=$child view=panel image_class=widemedium}
      </div>
      {delimiter modulo=$modulo}</div><div class="row panels-container">{/delimiter}
    {/foreach}
    </div>
  </div>

  {include name=navigator
		   uri='design:navigator/google.tpl'
		   page_uri=$node.url_alias
		   item_count=$children_count
		   view_parameters=$view_parameters
		   item_limit=$page_limit}

{/if}