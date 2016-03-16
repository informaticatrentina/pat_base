{def $current_state =  "in_pubblicazione"
     $attribute_filter = array( array( 'state', "in", $openpa.content_albotelematico.default_state_ids ) )}

{if is_set( $view_parameters.stato )}
   {set $current_state = $view_parameters.stato}
{/if}

{if $current_state|eq( 'archivio' )}
  {set $attribute_filter = array( array( 'state', "in", $openpa.content_albotelematico.archive_state_ids ) )}
{/if}

<div class="state-navigation m_bottom_20">
  <a class="button{if $current_state|eq('in_pubblicazione')} defaultbutton{/if}" href="{$node.url_alias|ezurl(no)}">In pubblicazione</a>
  <a class="button{if $current_state|eq('archivio')} defaultbutton{/if}" href="{concat( $node.url_alias, '/(stato)/archivio')|ezurl(no)}">Archivio</a>
</div>

{def $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 25 )
     $children_count = fetch( openpa, 'list_count', hash( 'parent_node_id', $node.node_id, 'attribute_filter', $attribute_filter ) )
     $children = fetch( openpa, 'list', hash( 'parent_node_id', $node.node_id,
                                              'attribute_filter', $attribute_filter,
                                              'offset', $view_parameters.offset,
                                              'sort_by', $node.sort_array,
                                              'limit', $page_limit ) ) }
  
  
{if $children_count}
  <div class="content-view-children">  
  {foreach $children as $child }
    {node_view_gui view='line' content_node=$child image_class=small}         
  {/foreach}
  </div>

  {include name=navigator
       uri='design:navigator/google.tpl'
       page_uri=$node.url_alias
       item_count=$children_count
       view_parameters=$view_parameters
       item_limit=$page_limit}
{else}
 <div class="message-warning">
   <p>Non sono attualmente presenti atti in questa sezione</p>
 </div>
{/if}

  