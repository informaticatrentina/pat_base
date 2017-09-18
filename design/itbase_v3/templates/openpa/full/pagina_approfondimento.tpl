

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

{def $has_sidebar = false()}
{if or(
$node|has_attribute( 'struttura' ),
$node|has_attribute( 'allegati' ),
$node|has_attribute( 'audio' ),
$node|has_attribute( 'fonte' ),
gt($video|count,1),
$node|has_attribute( 'geo' ),
gt($images|count,1),
$matrix_link_has_content
)}
    {set $has_sidebar = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">
        <div class="content-title">
            {if is_set( $view_parameters.anteprima )}
                <p>
                    <a href="{concat('/ufficiostampa/edit/', $node.object.id)|ezurl(no, full)}" class="btn btn-info btn-lg">Chiudi anteprima</a>
                </p>
            {/if}

            <div class="row">
                <div class="col-xs-6">
                    <span class="date">
                        {include uri='design:parts/panel_node_date.tpl'} 
                    </span>
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
                {if $node|has_attribute( 'occhiello' )}
                    <small style="font-weight: normal;color: #000">
                        {attribute_view_gui attribute=$node|attribute( 'occhiello' )}
                    </small><br />
                {/if}
                <div class="comunicato-title">
                    {$node.name|wash()}
                </div>
            </h1>
                
            <div class="row">
                <div class="col-xs-2 content-line">

                </div>
            </div>
                
            {if $node|has_attribute( 'titolo_breve' )}
                <h2>
                    {attribute_view_gui attribute=$node|attribute( 'titolo_breve' )}
                </h2>
            {/if}
            {if $node|has_attribute( 'descrizione_breve' )}
                <div class="description">
                    {attribute_view_gui attribute=$node|attribute( 'descrizione_breve' )}
                </div>
            {/if}
        </div>

        {if $node|has_attribute( 'abstract' )}
            <div class="comunicato-abstract">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
        {/if}

        {if gt($images|count,0)}
            <div class="main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>
        {/if}

        {*if $node|has_attribute( 'persone' )}
            {attribute_view_gui attribute=$node|attribute( 'persone' )}
        {/if*}
        
        {if $node|has_attribute( 'testo_completo' )}
            <div class="description">
                {attribute_view_gui attribute=$node|attribute( 'testo_completo' )}
            </div>
        {/if}
        
        {if or( $node|has_attribute( 'numero' ), $node|has_attribute( 'tematica' ) )}
            <p class="pull-right">
                {if $node|has_attribute( 'numero' )}
                    <span class="date label label-info">Comunicato {attribute_view_gui attribute=$node|attribute( 'numero' )}  </span>
                {/if}
                {if $node|has_attribute( 'tematica' )}
                    <span style="margin-left: 10px;"><i class="fa fa-tags"></i>{attribute_view_gui attribute=$node|attribute( 'tematica' )}</span>
                {/if}
            </p>
        {/if}
        
        <hr/>
        
    </div>

    {if $has_sidebar}
        <div class="content-related">
            {include uri='design:parts/related-struttura.tpl'}
            {include uri='design:parts/related-allegati.tpl'}
            {include uri='design:parts/related-audio.tpl'}
            {include uri='design:parts/related-immagini.tpl'}
            {include uri='design:parts/related-link.tpl'}
            {include uri='design:parts/related-fonte.tpl'}
            {include uri='design:parts/related-geo.tpl'}
            {if gt($video|count,0)}      
                {include uri='design:parts/related-video.tpl'}
            {/if}

 
            {if $node|has_attribute( 'argomento' )}
            <div class="tags">
               <h2><i class="fa fa-tags"></i> Argomento</h2>
               {attribute_view_gui attribute=$node|attribute( 'argomento' )}
            </div>
            {/if}
            
        </div>
    {/if}
</div>

{include uri='design:atoms/related.tpl' item=$node}