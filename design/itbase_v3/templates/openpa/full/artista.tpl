{*
{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}
*}
{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}

{def $images = array()}
{def $video = array()}
{def $argomenti = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{if $node|has_attribute( 'video' )}
    {foreach $node.data_map.video.content.relation_list as $relation_item}
        {set $video = $video|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{def $matrix_link_has_content = false()}
{if $node|has_attribute( 'link' )}
    {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
        {foreach $row.columns as $index => $column}
            {if $column|ne('')}
                {set $matrix_link_has_content = true()}
            {/if}
        {/foreach}
    {/foreach}
{/if}

{def $has_sidebar = true()}
{if or(
$node|has_attribute( 'struttura' ),
$node|has_attribute( 'allegati' ),
$node|has_attribute( 'audio' ),
$node|has_attribute( 'geo' ),
gt($images|count,1),
$matrix_link_has_content
)}
    {set $has_sidebar = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">
        <div class="content-title">
            <div class="row">
                <div class="col-xs-6">
                    <span class="date">{include uri='design:parts/panel_node_date.tpl'} </span>
                </div>
                <div class="col-xs-6 text-right">  
                    {*<a href="javascript:void(0);" data-toggle="collapse" data-target="#sharebuttons">
                    <i class="fa fa-share-alt fa-2x share"  ></i>
                    </a>
                    <div id="sharebuttons" class="collapse">*}
                        {include uri='design:parts/social_buttons.tpl'}
                    {*</div>*}
                        
                </div>
            </div>  
            <h1>
                {$node.name|wash()}
            </h1>

              
            {if $node|has_attribute( 'soggetto' )}
                 <h3>
                    {include uri='design:parts/related-selection.tpl' attribute=$node|attribute( 'soggetto' ) separatore=' -'}
                </h3>
            {/if}
         
            <div class="row">
                <div class="col-xs-2 content-line">

                </div>
            </div>
        </div>
            
        {if $node|has_attribute( 'occupazione' )}
            <div class="description">
                {"Deals with"|i18n('design/pat_base/generic')} 
                {include uri='design:parts/related-selection.tpl' attribute=$node|attribute( 'occupazione' ) separatore=','}
               
            </div>
        {/if}
        
        {if $node|has_attribute( 'descrizione' )}
            <div class="description">            
                {attribute_view_gui attribute=$node|attribute( 'descrizione' )}
            </div>
        {/if}  
      
        {if gt($images|count,0)}
            <div class="main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>
        {/if}
        
        {include uri='design:parts/related-events.tpl'}


        <hr/>{*include uri='design:parts/social_buttons.tpl'*}

    </div>

    {if $has_sidebar}
        <div class="content-related">
           
            {include uri='design:parts/related-info.tpl'}                    
            
            {include uri='design:parts/related-artisti.tpl'}
            
            {include uri='design:parts/related-immagini.tpl'}
            {include uri='design:parts/related-video.tpl'}
            {include uri='design:parts/related-link.tpl'}          
            {include uri='design:parts/related-geo.tpl'}
            
            {include uri='design:parts/related-stampa.tpl' item=$node}
            {include uri='design:parts/related-script.tpl'}
            
        </div>
    {/if}


</div>

{include uri='design:atoms/related.tpl' item=$node}