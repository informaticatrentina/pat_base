<div class="content-view-line class-{$node.class_identifier} media">

    {if $node|has_attribute( 'image' )}
        <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
        </a>
    {/if}
    <div class="media-body">
        <h3 class="media-heading">

            {def $titolo = ''}

            {if $node.data_map.titolo.content|ne('')}
                {set $titolo = $node.data_map.titolo.content}
            {else}
                {set $titolo = $node.name}
            {/if}

            {def $tipo_provvedimento = $node.data_map.tipo_provvedimento.class_content.options[$node.data_map.tipo_provvedimento.value[0]].name}
            {def $cod_provvedimento = $tipo_provvedimento|explode('|')[0]|trim()}

            {*<a href="{concat($node.data_map.base_url.content, 'scripts/VediProvvedimento.asp?PaginaRed=Doc&Modalita=', $cod_provvedimento, '&numero=', $node.data_map.numero_provvedimento.content, '&anno=', $node.data_map.anno_provvedimento.content, '&CodiceStruttura=', $node.data_map.codice_struttura.content)}" target="_blank"> *}
            <a href={$node.data_map.base_url.content} target="_blank">
                {$titolo} 
            </a>
        </h3>
        {if $node|has_abstract()}
            <div class="media-abstract">
                {$node|abstract()}
            </div>
        {/if}
        {if $node|has_attribute( 'tematica' )}
            {attribute_view_gui attribute=$node|attribute( 'tematica' )}
        {/if}
    </div>
</div>