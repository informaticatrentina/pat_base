<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
    <h3 class="media-heading">
	  <a href={$node.url_alias|ezurl}>
		{*<span class="fa fa-file-text-o"></span>*}
                {$node.name|wash()}
          </a>
    </h3>

	{*if $node.data_map.intro.content.is_empty|not}
	 {attribute_view_gui attribute=$node.data_map.intro}
	{/if*}

  </div>
</div>