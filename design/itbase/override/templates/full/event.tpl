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
            <h3>
                {if $node|has_attribute( 'short_title' )}
                {attribute_view_gui attribute=$node|attribute( 'short_title' )}
                {/if}
            </h3>
    </div>     
    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">
        
       
        
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
        <h3>
            <i class="fa fa-calendar"></i>
            Date
        </h3>
        da {attribute_view_gui attribute=$node|attribute( 'from_time' )}
        <br/>
        {if $node.data_map.to_time.has_content}
        a {attribute_view_gui attribute=$node|attribute( 'to_time' )}
        {/if}
        
        {if gt($images|count,0)}
            <h2><i class="fa fa-camera"></i> Immagini</h2>
            {include uri='design:atoms/gallery.tpl' items=$images}
        {/if}
        
        {if $node.data_map.url.has_content}
            <h2><i class="fa fa-link"></i> Link</h2>
            {attribute_view_gui attribute=$node|attribute( 'url' )}
        {/if}
        
        {if gt($allegatiArray|count,0)}
            <h2><i class="fa fa-paperclip"></i> Allegati</h2>
            {attribute_view_gui attribute=$node|attribute( 'allegati' )}
        {/if}
       
        <h3>
            <i class="fa fa-map-marker"></i>
            Luogo
        </h3>
        {if $node.data_map.indirizzo.has_content}
        <p>
            <strong>{attribute_view_gui attribute=$node|attribute('indirizzo')}</strong>
        </p>
        {/if}
        {attribute_view_gui attribute=$node.data_map.geo zoom=3}
        
        {if $node.data_map.telefono.has_content or $node.data_map.email.has_content}
            <h3>
                <i class="fa fa-thumb-tack"></i>
                Contatti
            </h3>
            {if $node.data_map.telefono.has_content}
            <p>
                <i class="fa fa-phone"></i>
                {attribute_view_gui attribute=$node|attribute('telefono')}
            </p>
            {/if}
            {if $node.data_map.email.has_content}
            <p>
                <i class="fa fa-envelope"></i>
                {attribute_view_gui attribute=$node|attribute('email')}
            </p>
            {/if}
        </div>
    {/if}


</div>
