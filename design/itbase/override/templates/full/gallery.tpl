     
 {set-block scope=root variable=cache_ttl}600{/set-block}
{* Event - Full view *}

<div class="content-view-full class-{$node.class_identifier} row">
    
    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}
            
        <div class="content-title">
           <h1>{$node.name|wash()}</h1>
           
            <div class="content-main">
            {def $images = array()}
            {foreach $node.data_map.image.content.relation_list as $relation_item}
                {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
            {/foreach}
        
            {if gt($images|count,0)}
                <div class="main-image">
                     <div class="main-image">
                        {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
                    </div>
                </div>
            {/if}
            <div class="short_description">
                {if $node|has_attribute( 'short_description' )}
                         {attribute_view_gui attribute=$node|attribute('short_description')}
                {/if}
            </div>
            <div class="description">
                {if $node|has_attribute( 'description' )}
                         {attribute_view_gui attribute=$node|attribute('description')}
                 {/if}
            </div>
        </div>
       
        <div class="content-related">
                        
            {if gt($images|count,0)}
                <div>
                    <h2><i class="fa fa-camera"></i> Immagini</h2>
                    {include uri='design:atoms/gallery.tpl' items=$images}
                </div>
            {/if}

     
        </div>
    </div>      
    </div>

