{def $limit = 40}


<h1><i class="fa fa-tags"></i>{$tag.keyword|wash}</h1>
    <hr/>
    
    {def $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                              extended_attribute_filter,
                                                    hash( id, TagsAttributeFilter,
                                                    params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                              offset, first_set( $view_parameters.offset, 0 ),
                                              limit, $limit,
                                              main_node_only, true(),
                                              sort_by, array( modified, false() ) ) )}

    {def $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                          extended_attribute_filter,
                                                                hash( id, TagsAttributeFilter,
                                                                params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                                          main_node_only, true() ) )}
                                                          


    {if $nodes|count}
  
        <div class="row">
            <section class="portfolio_masonry_container isotope panels-container">
                {foreach $nodes as $child }
                    <div class="t_xs_align_c isotope-item col-md-4">
                        {node_view_gui content_node=$child view=panel image_class=widemedium}
                    </div>
                {/foreach}

            </section>
        </div>
    {/if}
 
    {if or( 
        $tag.keyword|eq('Argomenti') , $tag.keyword|eq('Tematiche')
        )
    }        
      
        <ul class="list-tags">
             
            {def $all_tags = fetch( tags, tree, hash( parent_tag_id, $tag.id ) )}
            {foreach $all_tags as $child_tag sequence array('bglight', 'bgdark') as $sequence}
             {if not($child_tag.keyword|begins_with('#' ))}
                 <li>
                     <a href="https://{ezini("SiteSettings","SiteURL")}/tags/view/{$child_tag.url}">{$child_tag.keyword|wash}</a>
                </li>
             {/if}
            {/foreach} 
        </ul>
        
    {/if}


    {include uri='design:navigator/google.tpl'
             page_uri=concat( '/tags/view/', $tag.url )
             item_count=$nodes_count
             view_parameters=$view_parameters
             item_limit=$limit}

   
{undef $limit $nodes $nodes_count}

{ezscript_require( array( 'ezjsc::jquery', 'jquery.isotope.min.js' ) )}
{literal}
    <script>
        $('.portfolio_masonry_container').isotope({
            itemSelector : '.isotope-item',
            layoutMode : 'masonry',
            masonry: {
                columnWidth: 10,
                gutter:0
            }
        });
    </script>
{/literal}