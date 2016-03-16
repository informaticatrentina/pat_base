{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if $show_left|not()} wide{/if}">

        {include uri=$openpa.content_main.template}

        {include uri=$openpa.content_detail.template}

        {if fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                  'class_filter_type', 'include',
                                                  'class_filter_array', array( 'image', 'video' ) ) )}
                                                  
          {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                           'class_filter_type', 'include',
                                                           'class_filter_array', array( 'image', 'video' ),
                                                           'sort_by', $node.sort_array ) )}
          
           {include name="carousel"
                    uri='design:atoms/carousel.tpl'
                    items=$children
                    css_id=concat( 'gallery', $node.node_id)
                    root_node=$node
                    autoplay=0
                    i_view=image
                    pagination=false()
                    navigation=true()
                    top_pagination_position=true()
                    image_class=imagefull
                    items_per_row=1}
        {/if}

    </div>


</div>
