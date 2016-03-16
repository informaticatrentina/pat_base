{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

<div class="card-material center-block">
    <div class="row">
    <div class="col-lg-8">   
    
        <h1>
            {attribute_view_gui attribute=$node|attribute('titolo')}
        </h1>
            <div> &nbsp; </div>
            {if $node|has_attribute('immagine_associazione')}
            <div class="img-responsive center-block">                
                {attribute_view_gui attribute=$node|attribute('immagine_associazione') alignment="center" }
            </div>          
            {/if}
             <div> &nbsp; </div>
            <p class=" text-left"  >
                {if $node|has_attribute( 'descrizione' )}
                     {attribute_view_gui attribute=$node|attribute('descrizione')}
                {/if}
            </p>
    </div>    
            
    <div class="col-lg-4">
    
        <h2>
            <i class="fa fa-info"></i>
            Indirizzo
        </h2>
        <ul>
            {if $node|has_attribute( 'indirizzo' )}
                 <li>{attribute_view_gui attribute=$node|attribute('indirizzo')}</li>
            {/if}
            {if $node|has_attribute( 'via' )}
                      <li>{attribute_view_gui attribute=$node|attribute('via')} </li>
            {/if}
            {if $node|has_attribute( 'telefono' )}
                     <li>Telefono: {attribute_view_gui attribute=$node|attribute('telefono')} </li>
            {/if}
               {if $node|has_attribute( 'fax' )}
                     <li>Fax: {attribute_view_gui attribute=$node|attribute('fax')} </li>
            {/if}
            {if $node|has_attribute( 'email' )}
            <li>Email: {attribute_view_gui attribute=$node|attribute('email')} </li>
            {/if}
            {if $node|has_attribute( 'pec' )}
                     <li>Pec: {attribute_view_gui attribute=$node|attribute('pec')} </li>
            {/if}
            <div> &nbsp; </div>
            {include uri='design:parts/map.tpl' mapNode=$node mapHeight=300 mapZoom=17}   
       <hr>

            {def $images = array()}
            {foreach $node.data_map.immagini.content.relation_list as $relation_item}
                {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
            {/foreach}
            {if gt($images|count,0)}
                <div>
                    <h2><i class="fa fa-camera"></i> Immagini</h2>
                    {include uri='design:atoms/gallery.tpl' items=$images}
                </div>
            {/if}
           <div>
            {def $matrix_link_has_content = false()}
            {if $node|has_attribute( 'link' )}
            <hr>
            <h2><i class="fa fa-link"></i> Link</h2>
            <ul>{foreach $node|attribute( 'link' ).content.rows.sequential as $row}
                <li>
                {foreach $row.columns as $index => $column}                  
                    {if $column|ne('')}
                        {if eq( $index, '0')}                           
                            <a href="{$column}" target="_blank">
                        {/if}
                        {if eq( $index, '1')}
                            {$column}
                        {/if}
                    {/if}                   
                {/foreach}
                </a>
                 </li>
            {/foreach}
            {/if}
            </ul>
            </div>
    </div>  
            
    <div class="col-lg-12" >
        <div>
            
            <hr>
             <div class="abstract" style="font-size :0.9em;">
                {if $node|has_attribute( 'attivita' )}
                     {attribute_view_gui attribute=$node|attribute('attivita')}
                {/if}
            </div>          
        </div>
    </div>    
    </div>        
            
</div>