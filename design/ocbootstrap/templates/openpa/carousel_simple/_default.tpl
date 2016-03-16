<div class="relative">
<h3><a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a></h3>
{*if $node.data_map.image.content[$image_class]}
    {def $image = $node.data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" class="img-responsive pull-left"/>
    {undef $image}
{/if*}
<p>{$node|abstract()|oc_shorten(150)}</p>
</div>