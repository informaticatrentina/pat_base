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
$node|has_attribute( 'fonte' ),
$node|has_attribute( 'geo' ),
gt($images|count,1),
$matrix_link_has_content
)}
    {set $has_sidebar = true()}
{/if}

{*Numero Comunicato:{$node|attribute( 'numero' ).data_int*}
    
<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">
        <div class="content-title">
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

            {if $node|has_attribute( 'occhiello' )}
                <div class="occhiello">
                    <h3>
                        {attribute_view_gui attribute=$node|attribute( 'occhiello' )}
                    </h3>
                </div>
            {/if}         
            <h1>
                {$node.name|wash()}
            </h1>
            {if $node|has_attribute( 'sottotitolo' )}
                <h3>
                    {attribute_view_gui attribute=$node|attribute( 'sottotitolo' )}
                </h3>
            {/if}
            
            
            <div class="row">
                <div class="col-xs-2 content-line">

                </div>
            </div>
        </div>

        {if $node|has_attribute( 'abstract' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
        {/if}

        {if $node|has_attribute( 'testo_completo' )}
            <div class="description">
                {attribute_view_gui attribute=$node|attribute( 'testo_completo' )}
            </div>
        {/if}
        
        {if gt($images|count,0)}
            <div class="main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>
        {/if}

        <div class="row">
            <div class="col-xs-6 fonte">
                {if $node|has_attribute( 'fonte' )}
                    FONTE
                    {attribute_view_gui attribute=$node|attribute( 'fonte' )}
                {/if}
            </div>
            <div class="col-xs-6 text-right">
                {if $node|has_attribute( 'numero' )}
                    {if and($node|has_attribute( 'numero' ), $node|attribute( 'numero' ).data_int|ne(0) ) }
                        <span class="numero-comunicato">Comunicato {attribute_view_gui attribute=$node|attribute( 'numero' )}</span>
                    {/if}
                {/if}
            </div>
        </div>
        {if or( $node|has_attribute( 'argomento' ), $node|has_attribute( 'tematica' ) )}
            <p class="pull-right">
                {if $node|has_attribute( 'argomento' )}
                    {attribute_view_gui attribute=$node|attribute( 'argomento' )}
                {/if}
                {if $node|has_attribute( 'tematica' )}
                    {attribute_view_gui attribute=$node|attribute( 'tematica' )}
                {/if}
            </p>
        {/if}
        <hr/>{*include uri='design:parts/social_buttons.tpl'*}

    </div>

    {if $has_sidebar}
        <div class="content-related">
            {include uri='design:parts/related-struttura.tpl'}
            {include uri='design:parts/related-allegati.tpl'}
            {include uri='design:parts/related-audio.tpl'}
            {include uri='design:parts/related-immagini.tpl'}
            {include uri='design:parts/related-video.tpl'}
            {include uri='design:parts/related-link.tpl'}
            {*include uri='design:parts/related-fonte.tpl'*}
            {include uri='design:parts/related-geo.tpl'}
            
            {include uri='design:parts/related-stampa.tpl' item=$node}
            {include uri='design:parts/related-script.tpl'}
            
        </div>
    {/if}


</div>

{include uri='design:atoms/related.tpl' item=$node}