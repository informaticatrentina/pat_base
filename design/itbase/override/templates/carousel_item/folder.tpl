{if and($node|has_attribute( 'image'),$node.data_map.image.content[$image_class])}
  {def $image = $node.data_map.image.content[$image_class]}
  <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" />
  {undef $image}
{*elseif $node|has_attribute('immagini')}
  {def $image_rel = $node.data_map.immagini.content.relation_list[0]
       $image_node = fetch('content','node',hash('node_id',$image_rel.node_id))
       $image = $image_node.data_map.image.content[$image_class]
  }
  <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" />
  {undef $image_rel $image_node $image*}

{/if}

<div class="carousel-caption">
  <h3><a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a></h3>
  {if $node.data_map.short_description.has_content}
    {attribute_view_gui attribute=$node.data_map.short_description}
  {/if}
</div>