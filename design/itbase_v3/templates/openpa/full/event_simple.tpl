{def $images = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{def $allegatiArray = array()}
{if $node|has_attribute( 'allegati' )}
    {foreach $node.data_map.allegati.content.relation_list as $relation_itemAllegati}
        {set $allegatiArray = $allegatiArray|append(fetch('content','node',hash('node_id',$relation_itemAllegati.node_id)))}
    {/foreach}
{/if}



{set-block scope=root variable=cache_ttl}600{/set-block}
{* Event - Full view *}

<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main body-event_simple">
        <div class="content-title">
            {if $node|has_attribute( 'argomento' )}
                <p class="pull-right">
                    {if $node|has_attribute( 'argomento' )}
                        <span style="margin-left: 10px;">{attribute_view_gui attribute=$node|attribute( 'argomento' )}</span>
                    {/if}
                </p>
            {/if}

            <h1>
                {$node.name|wash()}
            </h1>

            <div class="row">
                <div class="col-xs-2 content-line">

                </div>
            </div>

            <h3>
                {if $node|has_attribute( 'short_title' )}
                {attribute_view_gui attribute=$node|attribute( 'short_title' )}
                {/if}
            </h3>
        </div>
        
        {if $node|has_attribute( 'informazioni' )}
          <div class="description">
            {attribute_view_gui attribute=$node|attribute( 'informazioni' )}
          </div>
        {/if}
        
         {if gt($images|count,0)}
        <div class="main-image">
             <div class="main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>


        </div>
        {/if}
        <hr/>
        {include uri='design:parts/social_buttons.tpl'}
    </div>
       
    <div class="content-related">
        {include uri='design:parts/related-date.tpl'}
        {include uri='design:parts/related-immagini.tpl'}
        {include uri='design:parts/related-link.tpl' attribute_name='url'}
        {include uri='design:parts/related-allegati.tpl'}
        {include uri='design:parts/related-geo.tpl'}
        {include uri='design:parts/related-contatti.tpl'}
        {include uri='design:parts/related-script.tpl'}
    </div>
</div>
