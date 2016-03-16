
{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}


{def $size = "billboard"
     $alternative_text = $node.object.data_map.name.content}

{if is_set( $node.object.data_map.image.content[$size].alternative_text )}
    {set $alternative_text=$node.object.data_map.image.content[$size].alternative_text}
{/if}

<div class="content-view-line class-{$node.class_identifier} media">  
<div class="media-body">
    {if $can_edit}
      <div >
        <a style="position: absolute;
                  left: 30px;
                  padding-top: 8px;
                  padding-bottom: 8px;
                  padding-left: 10px;
                  padding-right: 10px;
                  margin-top: 10px;
                  border-radius: 5px;
                  color: white;
                  background-color: rgba(0,0,0,0.8);"
                  
                  href={$node.url_alias|ezurl} >
            <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-pencil"></i>
            </h3>
        </a>
      </div>
    {/if}
    {if eq( $node.object.data_map.image_map.content, true() )}
        <img usemap="#banner_map" src={$node.object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$node.object.data_map.image.content[$size].width}" height="{$node.object.data_map.image.content[$size].height}" />
        {$node.object.data_map.image_map.content}
    {else}
        {if $node.object.data_map.url.content}
            <a href={$node.object.data_map.url.content|ezurl}>
                <img src={$node.object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$node.object.data_map.image.content[$size].width}" height="{$node.object.data_map.image.content[$size].height}" />
            </a>
        {else}
            <img src={$node.object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$node.object.data_map.image.content[$size].width}" height="{$node.object.data_map.image.content[$size].height}" />
        {/if}
    {/if}
</div>
</div>