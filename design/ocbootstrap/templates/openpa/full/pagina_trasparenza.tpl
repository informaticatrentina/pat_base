{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}

{def $classi_trasparenza = array( 'pagina_trasparenza' )     
     $classi_note_trasparenza = array( 'nota_trasparenza' )     
     
     $nota = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                   'class_filter_type', 'include',
                                                   'class_filter_array', $classi_note_trasparenza,
                                                   'sort_by', array( 'published', false() ),
                                                   'limit', 1 ) )
     
     $conteggio_figli = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.object.main_node_id,
                                                              'sort_by', $node.sort_array,
                                                              'class_filter_type', 'exclude',
                                                              'class_filter_array', $classi_trasparenza|merge( $classi_note_trasparenza ) ) )
     
     $conteggio_figli_pagina_trasparenza = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                                 'sort_by', $node.sort_array,
                                                                                 'class_filter_type', 'include',
                                                                                 'class_filter_array', $classi_trasparenza ) )}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
      <h1>{$node.name|wash()}</h1>        
    </div>

    {if $show_left}
      {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">
    
            
        {* Guida al cittadino *}
        {include name = guida_al_cittadino
                 node = $node             
                 uri = 'design:openpa/full/parts/amminsitrazione_trasparente/guida_al_cittadino.tpl'}
                 
        {* Guida al redattore *}
        {include name = guida_al_cittadino
                 node = $node             
                 uri = 'design:openpa/full/parts/amminsitrazione_trasparente/guida_al_redattore.tpl'}
              
    
        {* Nota: una sola nota *}
        {if $nota|count()|gt(0)}
        <div class="block">
            {include name=edit node=$nota[0] uri='design:parts/openpa/edit_buttons.tpl'}    
            <em>{attribute_view_gui attribute=$nota[0].data_map.testo_nota}</em>
        </div>
        {/if}
        
        {* Figli *}
        <div class="attributi-base">
            
            {if $conteggio_figli_pagina_trasparenza|gt(0)}                
                {def $figli_pagina_trasparenza = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                                                 'sort_by', $node.sort_array,
                                                                                 'class_filter_type', 'include',
                                                                                 'class_filter_array', $classi_trasparenza ) )}                
                {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children.tpl'
                         nodes=$figli_pagina_trasparenza
                         nodes_count=$conteggio_figli_pagina_trasparenza}            
            
            {elseif $conteggio_figli|gt(0)}            
                {def $figli = fetch( 'content', 'list', hash( 'parent_node_id', $node.object.main_node_id,
                                                              'sort_by', $node.sort_array,                                                              
                                                              'class_filter_type', 'exclude',
                                                              'class_filter_array', $classi_trasparenza|merge( $classi_note_trasparenza ) ) )}            
                
                {if and( is_set( $node.data_map.fields ), $node.data_map.fields.has_content )}
				
				  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table_fields.tpl'                                 
						   nodes=$figli
						   nodes_count=$conteggio_figli
						   fields=$node.data_map.fields.content}
				
				{else}
				
				  {* In base al remoteid vengono caricate le visualizzazioni tabellari o normali *}
				  
				  {switch match=$node.object.remote_id}
					  
					  {* Consulenti e collaboratori *}
					  {case match='b5df51b035ee30375db371af76c3d9fb'} 
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table.tpl'                                 
								   nodes=$figli
								   nodes_count=$conteggio_figli
								   class='consulenza'}
					  {/case}
					  
					  {* Incarichi amminsitrativi di vertice *}
					  {case match='efc995388bebdd304f19eef17aab7e0d'} 
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table.tpl'
								   nodes=$figli
								   nodes_count=$conteggio_figli
								   class='dipendente'}
					  {/case}
					  
					  {* Dirigenti *}
					  {case match='9eed77856255692eca75cdb849540c23'} 
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table.tpl'
								   nodes=$figli
								   nodes_count=$conteggio_figli
								   class='dipendente'}
					  {/case}
					  
					  {* Tassi di assenza *}
					  {case match='c46fafba5730589c0b34a5fada7f3d07'} 
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table.tpl'
								   nodes=$figli
								   nodes_count=$conteggio_figli
								   class='tasso_assenza'}
					  {/case}
					  
					  {* Incarichi conferiti e autorizzati ai dipendenti *}
					  {case match='b7286a151f027977fa080f78817c895a'} 
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table.tpl'
								   nodes=$figli
								   nodes_count=$conteggio_figli
								   class='incarico'}
					  {/case}
					  
					  {* Atti di concessione *}
					  {case match='90b631e882ab0f966d03aababf3d9f15'} 
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children_table.tpl'
								   nodes=$figli
								   nodes_count=$conteggio_figli
								   class=array( 'sovvenzione_contributo', 'determinazione', 'deliberazione' )}
					  {/case}
						  
					  {* visualizzazione figli default *}
					  {case}
						  {include uri='design:openpa/full/parts/amminsitrazione_trasparente/children.tpl'
								   nodes=$figli
								   nodes_count=$conteggio_figli}
					  {/case}
				  {/switch}
				
				{/if}
            
            {elseif $nota|count()|eq(0)}
            {* se non c'è nemmeno la nota occorre esporre un alert *}
                <div class="alert alert-warning">
                    <p>Sezione in allestimento</p>
                </div>
                
            {/if}
        </div>

</div>
