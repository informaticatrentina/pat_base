{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

{def $root_node_id = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}
{def $node = fetch( 'content', 'node', hash( 'node_id',  $root_node_id) )}

<div class="card-material">
    <header>
        <h2>
            {$block.name|wash()}
        </h2>
    </header>
    <hr>
    <div class="row">
        <div class="col-sm-7">
            {include uri='design:parts/map.tpl' mapNode=$node mapHeight=400 mapZoom=17}
        </div>
        <div class="col-sm-5">
            <h3>STRUTTURA DI SUPPORTO</h3>
            {def $contacts_list = footer('footer_contacts')}
            
            <p>
                <ul>
                    {if is_set($contacts_list.indirizzo)}
                        <li>{$contacts_list.indirizzo}</li>
                    {/if}
                    {if is_set($contacts_list.telefono)}
                        <li>{$contacts_list.telefono}</li>
                    {/if}
                    {if is_set($contacts_list.email)}
                        <li>{$contacts_list.email}</li>
                    {/if}
                    {if is_set($contacts_list.pec)}
                        <li>{$contacts_list.pec}</li>
                    {/if}
                </ul>
            </p>
            <h3>COORDINAMENTO</h3>
            <p>
                {$block.custom_attributes.coordinamento}
            </p>
            
            <h3>SEGRETERIA</h3>
            <p>
                {$block.custom_attributes.segreteria}
            </p>
        </div>
        
    </div>
</div>