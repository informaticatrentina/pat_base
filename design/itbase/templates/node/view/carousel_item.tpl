{if and($node|has_attribute( 'image'),$node.data_map.image.content[$image_class])}
    {def $image = $node.data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" />
    {undef $image}
{elseif $node|has_attribute('immagini')}
    {def $image_rel = $node.data_map.immagini.content.relation_list[0]}
    
    {def $image_node = fetch('content','node',hash('node_id',$image_rel.node_id))}

    {def $image = $image_node.data_map.image.content[$image_class]}         
         
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" />
    {undef $image_rel $image_node $image}
    
    {*foreach $node.data_map.immagini.content.relation_list as $relation_item}
      {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
    {if $images}
      {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' )}
    {/if*}
{/if}

<div class="carousel-caption">
    <h3>
        <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
    </h3>
    {if $node|has_attribute( 'short_description' )}
        {if $node.data_map.short_description.has_content}
            {attribute_view_gui attribute=$node.data_map.short_description}
        {/if}
    {/if}
</div>