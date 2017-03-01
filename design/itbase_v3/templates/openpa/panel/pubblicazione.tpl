<div class="media-panel pubblicazione">
    <div class="media">    
        <div class="caption">
            <h1 class="fw_medium_pubblicazione color_dark ">
            <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
                {$node.name|wash()}
                {*if $node|has_attribute('numero')}
                    n° {attribute_view_gui attribute=$node.data_map.numero}
                {/if*}
            </a>
            {*<br>
            <small>
                {if $node|has_attribute('mese')}
                    {attribute_view_gui attribute=$node.data_map.mese}
                {/if}
                {if $node|has_attribute('anno')}
                    {attribute_view_gui attribute=$node.data_map.anno}
                {/if}
            </small>*}
            </h1>

            <div class="row">
                <div class="col-xs-5 media-line">

                </div>
            </div>
            <p class="abstract">
                {$node|abstract()|openpa_shorten(100)}
            </p>

            <div class="sommario-rivista" style="height: 32px;">
            {if $node|has_attribute( 'sommario' )}
                <a class="btn btn-default btn-xs_thiny" 
                href="{$openpa.content_link.full_link}#sommario" 
                title="{$node.name|wash()}" 
                style="margin-top: 10px; margin-bottom: 10px;">
                IN  QUESTO NUMERO
            </a>
            {/if}  
            </div>

            {if $node|has_attribute('image')}
                  {include uri='design:atoms/image.tpl' item=$node havefigure=false() image_class=large href=$openpa.content_link.full_link alignment=left}
            {/if}

            <p class="media-panel-date-padding-bottom">
                <small class="media-panel-date-medium">
                    {def $dataPublicazione = $node|attribute( 'data' )}
                    {$dataPublicazione.content.timestamp|l10n(date)}
                </small>
            </p>

            <p style="margin-top: 20px;">

                {if $node|has_attribute( 'sfoglia_online' )}
                    <a class="btn btn-default btn-xs_thiny" 
                        href="{$node.object.data_map.sfoglia_online.content}" 
                        target="_blank">
                         SFOGLIA ONLINE
                     </a>
                {/if}
                {if $node|has_attribute( 'file' )}
                    &nbsp;
                    {def $file = $node|attribute( 'file' )}
                    <a href={concat("content/download/",$file.contentobject_id,"/",$file.id,"/file/",$file.content.original_filename)|ezurl}>
                        <i class="fa fa-download"></i>
                    </a>
                    {undef $file}
                {/if}
            </p>
        </div>
    </div>
</div>