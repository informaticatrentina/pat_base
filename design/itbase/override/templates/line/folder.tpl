
{if $open_folder}
    <div>
{else}
    <div class="content-view-line class-{$node.class_identifier} media">  
{/if}

{if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  
  <div class="media-body">
    {if $open_folder}
        {if $folder_level|eq(1)}
            <h2 class="media-heading m_bottom_10">
                <a class="text-primary" href={$node.url_alias|ezurl}>
                    {$node.name|wash}
                </a>
            </h2>
        {elseif $folder_level|eq(2)}
            <h3 class="media-heading">
                <a href={$node.url_alias|ezurl}>
                    {$node.name|wash}
                </a>
            </h3>
        {/if}
        
    {else}
        <h3 class="media-heading">
            <span class="fa fa-file-o"></span>
            <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
        </h3>
        {if $node.data_map.short_description.content.is_empty|not}
            {attribute_view_gui attribute=$node.data_map.short_description}
        {/if}
    {/if}
  </div>
  
  
</div>