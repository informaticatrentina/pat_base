{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, is_set( $tree_menu.children ), count( $tree_menu.children )|gt(0) )}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">

        <h1>
            {$node.name|wash()}
        </h1>

    </div>

    {if $show_left}
      {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">

        {include uri=$openpa.content_main.template}

        {include uri=$openpa.content_detail.template}

        {def $children_count = fetch( openpa, 'list_count', hash( 'parent_node_id', $node.node_id ) )
             $children = fetch( openpa, 'list', hash( 'parent_node_id', $node.node_id,
                                                           'offset', $view_parameters.offset,
                                                           'sort_by', $node.sort_array,
                                                           'limit', 10 ) )}
        
        
        {if $children_count}
          <div class="content-view-children">  
          {foreach $children as $child }
            {node_view_gui view=line content_node=$child image_class=small}	  
          {/foreach}
          </div>
        
          {include name=navigator
               uri='design:navigator/google.tpl'
               page_uri=$node.url_alias
               item_count=$children_count
               view_parameters=$view_parameters
               item_limit=10}
        
        {/if}

    </div>


</div>
