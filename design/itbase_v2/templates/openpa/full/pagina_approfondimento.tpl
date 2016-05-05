

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

    <div class="content-title">

        {if is_set( $view_parameters.anteprima )}
            <p>
                <a href="{concat('/ufficiostampa/edit/', $node.object.id)|ezurl(no, full)}" class="btn btn-info btn-lg">Chiudi anteprima</a>
            </p>
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

        {if $node|has_attribute( 'published' )}
            <span class="date">
                {$node|attribute( 'published' ).content.timestamp|l10n( 'date' )} 

                {def $OraPubblicazione = $node|attribute( 'published' ).content.timestamp|l10n( 'shorttime')}
                {if ne( $OraPubblicazione , '00:00')}
                    -  {$OraPubblicazione}
                {/if}   
            </span>
        {/if}

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

    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">

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
        
        <hr/>
        {include uri='design:parts/social_buttons.tpl' node=$node}

    </div>

    {if $has_sidebar}
        <div class="content-related">

            {if $node|has_attribute( 'struttura' )}
                <h2><i class="fa fa-sitemap"></i> Riferimento</h2>
                {attribute_view_gui attribute=$node|attribute( 'struttura' ) show_link=true()}
            {/if}

            {if $node|has_attribute( 'allegati' )}
                <h2><i class="fa fa-file-text"></i> Allegati</h2>
                {attribute_view_gui attribute=$node|attribute( 'allegati' )}
            {/if}

            {if $node|has_attribute( 'audio' )}
                <h2><i class="fa fa-volume-up"></i> Audio</h2>
                {attribute_view_gui attribute=$node|attribute( 'audio' )}
            {/if}

             {if gt($video|count,0)}                
                <h2><i class="fa fa-youtube-play"></i> Video</h2>
                {include uri='design:atoms/video_gallery.tpl' items=$video}
            {/if}

            {if gt($images|count,1)}
                <h2><i class="fa fa-camera"></i> Immagini</h2>
                {include uri='design:atoms/gallery.tpl' items=$images}
            {/if}

            {if $matrix_link_has_content}
                <h2><i class="fa fa-link"></i> Link</h2>
                {attribute_view_gui attribute=$node|attribute( 'link' )}
            {/if}

            {if $node|has_attribute( 'fonte' )}
                <h2><i class="fa fa-code-fork"></i> Fonte</h2>
                {attribute_view_gui attribute=$node|attribute( 'fonte' )}
            {/if}
 
            {if $node|has_attribute( 'argomento' )}
            <div class="tags">
               <h2><i class="fa fa-tags"></i> Argomento</h2>
               {attribute_view_gui attribute=$node|attribute( 'argomento' )}
            </div>
            {/if}
            {if $node|has_attribute( 'geo' )}
                <h2>
                    <i class="fa fa-map-marker"></i> Luogo
                    <a class="btn btn-sm btn-info pull-right" target="_blank" href="https://www.google.com/maps/dir//'{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude}'/@{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude},15z?hl=it">Come arrivare</a>
                </h2>
                {attribute_view_gui attribute=$node.data_map.geo zoom=3}
            {/if}
            <div>
                
                </br>
                <a class="btn btn-primary btn-lg"
                   title="{'Export'|i18n('design/standard/parts/website_toolbar')}"
                   href={concat('/content/view/pdf/', $node.node_id)|ezurl()}>
                    <i class="fa fa-print"></i>
                    Versione Stampabile
                </a>
            </div>
        </div>
    {/if}
</div>

{include uri='design:atoms/related.tpl' item=$node}