{set_defaults( hash(
  'show_date', false()
))}


<li class="media mymedia">
  {*if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squaremini' css_class="media-object"}
  </a>
  {/if*}

  {if $node|has_attribute( 'image')}
    <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
      {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squaremini' css_class="media-object"}
    </a>
  {elseif $node|has_attribute('immagini')}
    {def $image_rel = $node.data_map.immagini.content.relation_list[0]
         $image_node = fetch('content','node',hash('node_id',$image_rel.node_id))
    }
    <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
      {attribute_view_gui attribute=$image_node|attribute( 'image' ) href=false() image_class='squaremini' css_class="media-object"}
    </a>
    {undef $image_rel $image_node}
  {/if}

  <div class="media-body">

	<h4 class="media-title">
	  <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
	  {if $show_date}
		<small class="media-date">{$node.object.published|l10n('shortdate')}</small>
	  {/if}
	</h4>

  {if $node|has_abstract()}
    <p class="media-abstract">{$node|abstract()|oc_shorten( 150 )}</p>
  {/if}
	
  </div>

  <p class="goto">
    <a class="btn btn-primary btn-sm" href={$node.url_alias|ezurl()}>{"Read more"|i18n('design/pat_base/generic')}</a>
  </p>
</li>

{undef}
