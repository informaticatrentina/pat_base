{if $node|has_attribute( 'show_children' )}
      {def $children_view=$node.data_map.children_view.class_content.options[$node.data_map.children_view.value[0]].name|downcase()
           $col_width=6
           $modulo=2}
    
{/if}
 

{if $children_view|eq( 'groupbyclass')}
    {include uri=concat('design:parts/children/', $children_view, '.tpl') col_width=$col_width modulo=$modulo}
{elseif $children_view|eq( 'groupbyclassonright')}
    {include uri=concat('design:parts/children/', $children_view, '.tpl') col_width=$col_width modulo=$modulo}
{else}    
    
<div class="content-view-full class-folder row childs-container">
  
  <div class="content-main wide">
  
    {if $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
      <h1>{$node.name|wash()}</h1>
    {/if}

    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}

    {def $show_image=true()}
    {if $node.data_map.show_image.content|eq(0) }
        {set $show_image=false()}
    {/if}
    {if and($node|has_attribute( 'image' ), $show_image)}
        {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes="image-main"}
    {/if}
    {undef $show_image}

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
    
    {if $node|has_attribute( 'show_children' )}
      {set $children_view=$node.data_map.children_view.class_content.options[$node.data_map.children_view.value[0]].name|downcase()
           $col_width=6
           $modulo=2}
           
      {if $children_view|eq('panels')}
          {set $col_width=4
               $modulo=3}
      {/if}
                
      {include uri=concat('design:parts/children/', $children_view, '.tpl') col_width=$col_width modulo=$modulo}

      {undef $children_view}
    {*else}
      {include uri='design:parts/children.tpl' view='line'*}
    {/if}

  </div>

  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>
{/if}

