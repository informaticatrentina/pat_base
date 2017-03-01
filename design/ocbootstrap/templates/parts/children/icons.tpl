{set_defaults( hash(
  'page_limit', 16,  
  'delimiter', '',
  'exclude_classes', appini( 'ContentViewChildren', 'ExcludeClasses', array( 'image', 'video' ) ),
  'include_classes', array(),
  'type', 'exclude',
  'fetch_type', 'list',
  'parent_node', $node
))}

{if $type|eq( 'exclude' )}
{def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
{else}
{def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
{/if}

{def $children_count = fetch( content, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $parent_node.node_id )|merge( $params ) )}
{if $children_count}
  <div class="content-view-children">
        {def $lista_icone = fetch( content, $fetch_type, hash( 'parent_node_id', $parent_node.node_id,
                                                               'offset', $view_parameters.offset,
                                                               'sort_by', $parent_node.sort_array,											
                                                               'limit', $page_limit )|merge( $params ) )}
      
        
	{foreach $lista_icone as $i => $child }
            {if $i|eq(0)}
                  <div class="row">
            {/if}
            <div class="col-sm-2">
                {* Verifica se è un Link *}
                {def $child_url = $child.url_alias
                     $target = '_self'}
                {if $child.object.class_identifier|eq('link')}
                    {set $child_url=$child|attribute('location').content}
                    {if $child|attribute('open_in_new_window').content|eq(1)}
                        {set $target = '_blank'}
                    {/if}
                {/if}
                {* ** *}


                {if $child|has_attribute( 'image' )}			
                      {include uri='design:atoms/image.tpl' href=$child_url|ezurl() target=$target item=$child image_class=squarethumb alignment=center image_css_class="img-circle"}  
                {/if}
                <div class="caption">
                      <h5 class="text-center">
                          <a href={$child_url|ezurl()} target="{$target}" alt="{'Read more'|i18n('ocbootstrap')} {$child.name|wash()}">
                              {$child.name|wash()}
                          </a>
                      </h5>
                </div>
                          
                {undef $child_url
                       $target}
            </div>
            {if eq(sum($i,1)|mod(6),0)}
                  </div>
                  <div class="row">
            {/if}

            {if $i|eq($lista_icone|count()|sub(1))}
                  </div>
            {/if}	 
	{/foreach}
        
        {undef $lista_icone}
  </div>

  {include name=navigator
		   uri='design:navigator/google.tpl'
		   page_uri=$node.url_alias
		   item_count=$children_count
		   view_parameters=$view_parameters
		   item_limit=$page_limit}

{/if}