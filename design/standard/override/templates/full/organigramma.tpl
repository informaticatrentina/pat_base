<div class="content-view-full class-folder row">

  {if and( $node.parent_node_id|ne(1), $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
    {include uri='design:nav/nav-section.tpl'}
  {/if}

  <div class="content-main{if or( $node.parent_node_id|eq(1), $node.node_id|eq( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )} wide{/if}">

    {if $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
      <h1>{$node.name|wash()}</h1>
    {/if}

    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}

    {if $node|has_attribute( 'image' )}
      {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes="image-main"}
    {/if}

    {if $node|has_attribute( 'tags' )}
      <div class="tags">
        {foreach $node.data_map.tags.content.keywords as $keyword}
          <span class="label label-primary">{$keyword}</span>
        {/foreach}
      </div>
    {/if}

    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}

    {def $children=''
         $servizi_area=''}

		{set $children=fetch('content', 'list',hash('parent_node_id', $node.node_id, 
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array('servizio','area'), 
                                                    'sort_by', array('priority', true()) ))}
        {if $children|count()|gt(0)}
        {foreach $children as $child }
        	<ul class="org-chart">
                <li>
				  <div class="vcard"><h2>{node_view_gui view='toolline' content_node=$child.object.main_node}</h2></div>
				  {include node=$child title=false() icon=false() uri='design:parts/articolazioni_interne.tpl'}
				</li>
            </div>
        {/foreach}
        {/if}
    
    

  </div>

</div>