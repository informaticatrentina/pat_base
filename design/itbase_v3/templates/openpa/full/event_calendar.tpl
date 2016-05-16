{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

{* Event Calendar - Full view *}
{set-block scope=root variable=cache_ttl}400{/set-block}

{def $view = $node.data_map.view.class_content.options[$node.data_map.view.value[0]].name|downcase()}

{if is_set( $view_parameters.view )}
    {set $view = $view_parameters.view}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">
    <div class="content-main {if $view|ne('geocalendar')}wide{/if}">
        <div class="content-title">
            <h1>
                {$node.name|wash()}
            </h1>
        </div>

        <div class="row">
            <div class="col-xs-2 content-line">

            </div>
        </div>
            
        {include uri=concat("design:calendar/",$view,".tpl")}
    </div>

    {if $view|eq('geocalendar')}
        <div class="content-related">
            <div class="related-panel">
                <div class="row">
                    <div class="col-xs-8">
                        <h3>luoghi</h3>
                    </div>
                    <div class="col-xs-4 text-right">
                        <span class="fa-stack fa-3x related-icon">
                            <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                            <i class="fa fa-map-marker fa-stack-1x"></i>
                        </span>
                    </div>
                </div>

                {def $calendarData = calendar( $node, $view_parameters|merge( hash( 'interval', 'P1M', 'view', 'calendar' ) ) ) }
                <div id="map-{$node.node_id}" style="height: 200px; width: 100%"></div>

                <script>
                {literal}
                    var tiles = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
                    var map = L.map('{/literal}map-{$node.node_id}{literal}').addLayer(tiles);

                    map.scrollWheelZoom.disable();

                    var markers = L.markerClusterGroup();
                    {/literal}{foreach $calendarData.events as $mapNode}{literal}
                    if(true){
                        var longitude = {/literal}{$mapNode.node.data_map.geo.content.latitude}{literal};
                        var latitude = {/literal}{$mapNode.node.data_map.geo.content.longitude}{literal};
                        var address = '{/literal}{$mapNode.node.data_map.geo.content.address}{literal}';
                        var colore = {/literal}
                        {if $mapNode.node.data_map.color.content[0]|eq(0)}
                            '#f00';
                        {elseif $mapNode.node.data_map.color.content[0]|eq(1)}
                            '#0f0';
                        {elseif $mapNode.node.data_map.color.content[0]|eq(2)}
                            '#00f';
                        {elseif $mapNode.node.data_map.color.content[0]|eq(3)}
                            '#ff0';
                        {/if}
                        {literal}

                        var customIcon = L.MakiMarkers.icon({icon: "star", color: colore, size: "l"});

                        markers.addLayer(L.marker([longitude, latitude], {icon: customIcon}).bindPopup(address));

                    }
                    {/literal}{/foreach}{literal}

                    map.addLayer(markers);

                    if(markers.getLayers().length > 0){
                        map.fitBounds(markers.getBounds());
                    }
                    else{
                        map.setView([46.0805156,11.0853364], 12);
                    }

                {/literal}
                </script>
            </div>
                
            {include uri='design:parts/related-script.tpl'}
        </div>
    {/if}
    
</div>
