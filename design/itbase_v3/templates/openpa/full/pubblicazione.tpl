
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

{def $has_sidebar = false()}
{if or(
    $node|has_attribute( 'allegati' ),
    gt($images|count,1),
    $matrix_link_has_content , 
    $node|has_attribute( 'sfoglia_online' ),
    $node|has_attribute( 'file' )
    )}
    {set $has_sidebar = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main{if $has_sidebar|not()} wide{/if} body-pubblicazione">
        <div class="row">
            <div class="col-md-6">
                {if $node|has_attribute( 'image' )}
                    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes='image-main'}
                {else}
                    <div class="figure image-main" style="height:200px;width:500px;">
                    </div>
                {/if}
            </div>
        </div>
        <div class="spacer">&nbsp;</div> 
        <div class="spacer">&nbsp;</div> 
        
        <h2>
            {$node.name|wash()}
        </h2>
        
        <div class="row">
            <div class="col-xs-2 content-line">

            </div>
        </div>
        <div class="row-pubblicazione">
            {if $node|has_attribute('anno')}
                <div>
                Anno {attribute_view_gui attribute=$node.data_map.anno}
                </div>
            {/if}
            {if $node|has_attribute('mese')}
                <div>
                    Mese {attribute_view_gui attribute=$node.data_map.mese}
                </div>
            {/if}
            {if $node|has_attribute('numero')}
                <div>
                    Numero {attribute_view_gui attribute=$node.data_map.numero}
                </div>
            {/if}
            <div>
                {def $file = $node|attribute( 'file' )}
                Documento <a href={concat("content/download/",$file.contentobject_id,"/",$file.id,"/file/",$file.content.original_filename)|ezurl}>
                    {$file.content.original_filename|wash(xhtml)} ({$file.content.filesize|si(byte)})              
                </a>
                {undef $file}
            </div>            
            <div>
                Data di pubblicazione {attribute_view_gui attribute=$node.data_map.data}            
            </div>
            <div class="spacer">&nbsp;</div> 
        
         </div>
         
            {if $node|has_attribute( 'abstract' )}
                <div class="abstract">
                    {attribute_view_gui attribute=$node|attribute( 'abstract' )}
                 </div>
            {/if}

            {if $node|has_attribute( 'sommario' )}
                <a name="sommario"></a>
                <div class="sommario-rivista" name="sommario">
                    <p>{attribute_view_gui attribute=$node|attribute( 'sommario' )}</p>
                </div>
            {/if}
            {if $node|has_attribute( 'descrizione' )}
                <div class="description">
                    {attribute_view_gui attribute=$node|attribute( 'descrizione' )}
                </div>
            {/if}
    </div>
    
    {if $has_sidebar}
        <div class="content-related">
            {include uri='design:parts/related-immagini.tpl'}
            {include uri='design:parts/related-allegati.tpl'}
            {include uri='design:parts/related-link.tpl'}
            {if $node|has_attribute( 'sfoglia_online' )}
                {include uri='design:parts/related-sfoglia.tpl'}
            {/if}
            {if $node|has_attribute( 'file' )}
                {include uri='design:parts/related-download.tpl'}
            {/if}
            
            
            {include uri='design:parts/related-script.tpl'}
        </div>
    {/if}
</div>
