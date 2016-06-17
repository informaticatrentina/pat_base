{set_defaults( hash(
  'page_limit', 20,
  'view', 'line',
  'delimiter', '',
  'exclude_classes', openpaini( 'ExcludedClassesAsChild', 'FromFolder', array( 'image', 'infobox', 'global_layout' ) ),
  'include_classes', array(),
  'type', 'exclude',
  'fetch_type', 'list',
  'parent_node', $node,
  'image_class', 'small'
))}

{if $type|eq( 'exclude' )}
{def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
{else}
{def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
{/if}

{def $children_count = fetch( openpa, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $parent_node.node_id )|merge( $params ) )
   $children = fetch( openpa, $fetch_type, hash( 'parent_node_id', $parent_node.node_id,
                                                  'offset', $view_parameters.offset,
                                                  'sort_by', $parent_node.sort_array,
                                                  'limit', $page_limit )|merge( $params ) ) }

{def $classNameArray = array()}
{def $classArray = array()}

{set-block scope=root variable=cache_ttl}600{/set-block}
{* Event - Group By Class *}


<div class="content-view-full class-{$node.class_identifier} row">
    
    <div class="content-main wide">
        
        <div class="content-title">

            <h1>
                {$node.name|wash()}
            </h1>
            
            {if $node|has_attribute( 'short_description' )}
                  <div class="abstract">
                    {attribute_view_gui attribute=$node|attribute( 'short_description' )}
                  </div>
            {/if}
            
            <div class="row">
                <div class="col-xs-2 content-line">
                </div>
            </div>

            <h3>
                {if $node|has_attribute( 'short_title' )}
                {attribute_view_gui attribute=$node|attribute( 'short_title' )}
                {/if}
            </h3>
            
            {if $node|has_attribute( 'tags' )}
              <div class="tags">
                {foreach $node.data_map.tags.content.keywords as $keyword}
                  <span class="label label-primary">{$keyword}</span>
                {/foreach}
              </div>
            {/if}

            {if $node|has_attribute( 'description' )}
              <div class="description">
                {attribute_view_gui attribute=$node|attribute( 'description' )}
              </div>
            {/if}
        </div>
        
        
        {* Visualizzazione dei figli raggruppati per tipoligia di classe *}
        <div class="row">
   
                {if $children_count}
                  {* Individua tutti i tipi di classe da visualizzare*}
                  {foreach $children as $child }    
                    {set $classNameArray = $classNameArray|append($child.class_identifier)}
                  {/foreach}
                  {* distinct sui tipi di classe da visualizzare*}
                  {def $unique_classNameArray=$classNameArray|unique()}

                  {*per ogni tipo classe gli assega i figli*}  
                  {foreach $unique_classNameArray as $className }    
                        {def $tmpArray = array()}        
                        {foreach $children as $child } 
                            {* Crea un array con gli elementi della calasse che sta ciclando*}
                            {if $child.class_identifier|eq($className)}                
                                {*Se la classe corrisponde aggiunge il child all'aray corrente*}
                                {set $tmpArray = $tmpArray|append($child)}
                            {/if}
                        {/foreach}
                        {set $classArray = $classArray|append(hash($className, $tmpArray))}
                        {undef $tmpArray}
                  {/foreach}
                    
                    {* Stampa dei pannelli*}
                    <div class="content-view-children">         
                        {foreach $classArray as $childClassName }              
                            {foreach $childClassName as $index => $object} 
                                {* Inizio stampa pannello*}
                                <div class="content-related-folder">
                                    
                                    <div class="related-panel">
                                    <div class="row">
                                        <div class="related-panel-title col-xs-8 ">
                                            {* Lettura titolo del pannello da file ini*}
                                            {def $classTitle = ezini( 'GroupByClassTitle', $index, 'patbase.ini' )}
                                            {if $classTitle|is_null()}
                                                {set $classTitle = $index}
                                            {/if}                            
                                            {$classTitle}

                                            {* Lettura Icona del pannello da file ini*}                            
                                            {def $classIcon = ezini( 'GroupByClassIcons', $index, 'patbase.ini' )}
                                            {if $classIcon|is_null()}
                                                {set $classIcon = ezini( 'GroupByClassIcons', 'default', 'patbase.ini' )}
                                            {/if}

                                        </div>
                                        <div class="col-xs-4 text-right">
                                            <span class="fa-stack fa-3x related-icon">
                                                <i class="fa fa-circle fa-stack-2x fa-inverse"></i>                                
                                                <i class="{$classIcon} fa-stack-1x"></i>
                                            </span>
                                        </div>
                                    </div>

                                        {foreach $object as $node}                         
                                            <div class="row">
                                                <div class="related-panel-text col-xs-10">
                                                {if $index|eq( 'link_provvedimento' )}
                                                    {def $tipo_provvedimento = $node.data_map.tipo_provvedimento.class_content.options[$node.data_map.tipo_provvedimento.value[0]].name}
                                                    {def $cod_provvedimento = $tipo_provvedimento|explode('|')[0]|trim()}
                                                    <a 
                                                        href="{concat($node.data_map.base_url.content, 'scripts/VediProvvedimento.asp?PaginaRed=Doc&Modalita=', $cod_provvedimento, '&numero=', $node.data_map.numero_provvedimento.content, '&anno=', $node.data_map.anno_provvedimento.content, '&CodiceStruttura=', $node.data_map.codice_struttura.content)}" 
                                                            target="_blank">
                                                        {def $titoloProvvedimento = $node.name|explode('|')[1]|trim()}
                                                        {$titoloProvvedimento|wash}</a>
                                                {else}
                                               
                                                        <a href={$node.url_alias|ezurl}>{$node.name|wash}</a> 
                                                {/if}            
                                                </div>
                                                <div class="col-xs-2 text-right ">
                                                    <img class="related-panel-images" 
                                                         src='/extension/pat_base/design/itbase_v3/images/fa-arrow-circle-o-right.png'>                                                    
                                                </div>
                                            </div>
                                            
                                        {/foreach}
                                    </div>    
                                </div> 
                            {/foreach}             
                            {*childClassName|attribute( 'show' )*}
                        {/foreach}   
                   

                    {include name=navigator
                                   uri='design:navigator/google.tpl'
                                   page_uri=$node.url_alias
                                   item_count=$children_count
                                   view_parameters=$view_parameters
                                   item_limit=$page_limit}

                    {/if}
                    </div>

        </div>
        {* FINE Visualizzazione dei figli raggruppati per tipoligia di classe *}
        <hr/>
        {include uri='design:parts/social_buttons.tpl'}
        
    </div>
</div>
    
{include uri='design:parts/related-script.tpl'} 



{literal}
     <script>
        $('.content-view-children').masonry({
            // options
            itemSelector: '.content-related-folder'
        });
    </script> 
{/literal} 