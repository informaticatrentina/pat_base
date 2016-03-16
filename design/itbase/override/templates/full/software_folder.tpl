{* :: INFOTN :: *}

<div class="content-view-full class-folder row">
    {if and( $node.parent_node_id|ne(1), $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
      {include uri='design:nav/nav-section.tpl'}
    {/if}

    <div class="content-main">
        {if $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
            <h1>{$node.name|wash()}</h1>
        {/if}
        
        {if $node|has_attribute( 'short_description' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'short_description' )}
            </div>
        {/if}
        
        {if $node|has_attribute( 'image' )}
            {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes="image-main"}
        {/if}
        
        {*TAGS non visualizzati*}
        
        {if $node|has_attribute( 'description' )}
          <div class="description">
            {attribute_view_gui attribute=$node|attribute( 'description' )}
          </div>
        {/if}
        
        {******VISUALIZZO LA LISTA DEI SOFTWARE******}
        
        {*Cerco l'utente collegato*}
        {def $current_user = fetch( 'user', 'current_user' )}
        
        <h2>Software Specialistico</h2>
        {foreach $node.children as $nodechild}
            {def $tipologia_sw = $nodechild.object.data_map.tipologia_software.content.0}
            
            
            {if $tipologia_sw|eq(0)}
                {include uri='design:node/view/software.tpl' nodechild=$nodechild}
            {/if}
        {/foreach}
        
        <h2>Software Generico</h2>
        {foreach $node.children as $nodechild}
            {def $tipologia_sw = $nodechild.object.data_map.tipologia_software.content.0}
            
            {if $tipologia_sw|eq(1)}
                {include uri='design:node/view/software.tpl' nodechild=$nodechild}
            {/if}
        {/foreach}
    </div>
</div>
    