<div class="relative">

{def $images = array()}
{foreach $node.data_map.immagini.content.relation_list as $relation_item}
    {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
{/foreach}

{if $images}
    {def $image = $images[0].data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>
    {undef $image}
{else}
  <img src={'placeholder.png'|ezimage} width="1200" height="800" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>    
{/if}


<div class="carousel-caption">
    <h3>	
      <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>	
    </h3>
    <p>{$node|abstract()|oc_shorten(200)}</p>
</div>
</div>