<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
    <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
     </a>
  {/if}
  <div class="media-body">
    <h3 class="media-heading">
        <a href="{$node.data_map.location.content}" target="_blank">
            <i class="fa fa-link"></i>
            {$node.name|wash} 
        </a>
        <div class="pull-right">
            
            {include uri='design:parts/toolbar/node_toolbar.tpl' current_node=$node}
            
        </div>
    </h3>
    {if $node.data_map.description.content.is_empty|not}
	{attribute_view_gui attribute=$node.data_map.description}
    {/if}
     
  </div>
</div>