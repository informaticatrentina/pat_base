{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

{def $root_node_id = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}
{def $node = fetch( 'content', 'node', hash( 'node_id',  $root_node_id) )}

<div class="card-material home_widget">
    <header>
        <h2>
            {$block.name|wash()}
        </h2>
    </header>
    <div class="row">
        <div class="col-sm-7">
            {include uri='design:parts/map.tpl' mapNode=$node mapHeight=400 mapZoom=17}
        </div>
        <div class="col-sm-5">
            {def $contacts_list = footer('footer_contacts')}
            
            <p>
                {if is_set($contacts_list.indirizzo)}
                    {$contacts_list.indirizzo}
                {/if}
            </p>
            <p>
                {if is_set($contacts_list.telefono)}
                    {$contacts_list.telefono}
                {/if}
            </p>
            <p>
                {if is_set($contacts_list.email)}
                    {$contacts_list.email}
                {/if}
            </p>
            <p>
                {if is_set($contacts_list.pec)}
                    {$contacts_list.pec}
                {/if}
            </p>
            <p>
                {$block.custom_attributes.note}
            </p>
        </div>
        
    </div>
</div>