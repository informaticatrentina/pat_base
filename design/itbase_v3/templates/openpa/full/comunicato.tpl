{*
{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}
*}

{def $images = array()}
{def $argomenti = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
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

<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">
        <div class="content-title">
            {if $node|has_attribute( 'published' )}
                <span class="date">{$node|attribute( 'published' ).content.timestamp|l10n( 'date' )} </span>
            {/if}

            <h1>
                {if $node|has_attribute( 'occhiello' )}
                    <small style="font-weight: normal;color: #000">
                        {attribute_view_gui attribute=$node|attribute( 'occhiello' )}
                    </small><br />
                {/if}
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
        
        {if or( $node|has_attribute( 'numero' ), $node|has_attribute( 'argomento' ) )}
            <p class="pull-right">
                {if and($node|has_attribute( 'numero' ), $node|attribute( 'numero' ).data_int|ne(0) ) }
                    <span>Comunicato {attribute_view_gui attribute=$node|attribute( 'numero' )}</span>
                {/if}
                {if $node|has_attribute( 'argomento' )}
                    <span style="margin-left: 10px;">{attribute_view_gui attribute=$node|attribute( 'argomento' )}</span>
                {/if}
            </p>
        {/if}
        
        <hr/>{include uri='design:parts/social_buttons.tpl'}

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
            {include uri='design:parts/related-script.tpl'}
       
            </br>
            <a class="btn btn-primary btn-lg"
                title="{'Export'|i18n('design/standard/parts/website_toolbar')}"
                href={concat('/content/view/pdf/', $node.node_id)|ezurl()}>
                 <i class="fa fa-print"></i>
                 Versione Stampabile
         </a>
        </div>
    {/if}


</div>

{include uri='design:atoms/related.tpl' item=$node}