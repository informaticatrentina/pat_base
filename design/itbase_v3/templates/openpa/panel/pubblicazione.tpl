<div class="media-panel pubblicazione">
    <div class="media">    
        <div class="caption">
            <h4 class="fw_medium color_dark">
                <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
                    {$node.name|wash()}
                    {if $node|has_attribute('numero')}
                        n° {attribute_view_gui attribute=$node.data_map.numero}
                    {/if}
                </a>
                <br>
                <small>
                    {if $node|has_attribute('mese')}
                        {attribute_view_gui attribute=$node.data_map.mese}
                    {/if}
                    {if $node|has_attribute('anno')}
                        {attribute_view_gui attribute=$node.data_map.anno}
                    {/if}
                </small>
            </h4>

            <div class="row">
                <div class="col-xs-5 media-line">

                </div>
            </div>
            
            <p class="abstract">
                {$node|abstract()|openpa_shorten(100)}
            </p>
            
            <a class="btn btn-default btn-xs" 
               href="{$openpa.content_link.full_link}" 
               title="{$node.name|wash()}" 
               style="margin-top: 10px; margin-bottom: 10px;">
                LEGGI
            </a>
            
            {if $node|has_attribute('image')}
                  {include uri='design:atoms/image.tpl' item=$node image_class=large href=$openpa.content_link.full_link alignment=center}
            {/if}
            
            <p>
                <small class="media-panel-date">{$node.object.published|l10n('date')}</small>
            </p>
            
            <p style="margin-top: 20px;">
                
                {if $node|has_attribute( 'sfoglia_online' )}
                    <a class="btn btn-default btn-xs" 
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

            {include uri='design:parts/related-item.tpl'}
        </div>
    </div>
</div>