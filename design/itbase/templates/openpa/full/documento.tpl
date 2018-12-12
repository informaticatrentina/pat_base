

<div class="content-view-full row">
    <div class="content-title">
        <h1>
            {$node.name|wash()}
        </h1>
    </div>
    <div class="content-main">
         <p class="abstract">
            {$node|abstract()|openpa_shorten(200)}
        </p>
    
         
        <div class="row">
            <div class="col-xs-5 media-line">          
            </div>
        </div>   
        
        {if $node|has_attribute( 'file' )}
            <div class="media-panel" style="padding-top: 100px;padding-bottom: 100px;">
            <strong>Scarica File: <i class="fa fa-file-text"></i>   
            {attribute_view_gui attribute=$node|attribute( 'file' )}
            </strong>
            </p>
            </div>
        {/if}
 
        {if $node|has_attribute( 'link' )}
            Link al File:    
            {attribute_view_gui attribute=$node|attribute( 'link' )}
            </p>
                
        {/if}
        {if $node|has_attribute( 'descrizione' )}
           
            {attribute_view_gui attribute=$node|attribute( 'descrizione' )}
            </p>
                
        {/if}
        <p>
            <small class="media-panel-date">
                {*include uri='design:parts/panel_node_date.tpl'*}
            </small>
        </p>
    </div>
        
    <div class="content-related">
        <h2>
            <i class="fa fa-info"></i>
            Informazioni
        </h2>
            {if $node|has_attribute( 'servizio' )}
               {def $servizio=''}
                <p> Servizio
                {foreach $node.data_map.servizio.content.relation_list as $relation_item}
                   {set $servizio = fetch('content','node',hash('node_id',$relation_item.node_id)))}
                   <strong>{$servizio.name}</strong><br/>
                {/foreach}
                {undef servizio}
                </p>
            {/if}
          {if $node|has_attribute( 'data_inizio_validita' )}
                <p> Inizio validità
                {attribute_view_gui attribute=$node|attribute( 'data_inizio_validita' )}
                </p>
            {/if}
              {if $node|has_attribute( 'data_fine_validita' )}
                 <p> Fine validità
                {attribute_view_gui attribute=$node|attribute( 'data_fine_validita' )}
                </p>
            {/if}
              {if $node|has_attribute( 'data_iniziopubblicazione' )}
                <p> Pubblicazione
                {attribute_view_gui attribute=$node|attribute( 'data_iniziopubblicazione' )}
                </p>
            {/if}
            {if $node|has_attribute( 'data_archiviazione' )}
                <p> Data Archiviazione 
                {attribute_view_gui attribute=$node|attribute( 'data_archiviazione' )}
                </p>
            {/if}
            
            
            {if $node|has_attribute( 'riferimento' )}
            Riferimenti:    
            {attribute_view_gui attribute=$node|attribute( 'riferimento' )}
            </p>
                
        {/if}
    </div>
</div>