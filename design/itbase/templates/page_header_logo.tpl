{def $media_node_id = ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' )}
{def $media_list=fetch( 'content', 'list', hash( 'parent_node_id', $media_node_id ) )}


{foreach $media_list as $media}
    {if and($media.name|eq('Logo'), $media.class_identifier|eq('image'))}
        {def $logo_image = $media}
    {/if}
{/foreach}

<a href="{'/'|ezurl( 'no' )}" title="{ezini('SiteSettings','SiteName')|wash}" class="logo">
    {if is_set($logo_image)}
        {attribute_view_gui attribute=$logo_image|attribute('image') image_class=site_logo alt_text=ezini('SiteSettings','SiteName')|wash}
    {else}
        <img class="img-responsive" src="{'logo.png'|ezimage( 'no' )}" alt="{ezini('SiteSettings','SiteName')|wash}" />
    {/if}
</a>
