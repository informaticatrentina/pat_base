<div id="map-{$mapNode.node_id}" style="height: {$mapHeight}px; width: 100%"></div>
            
<script>
{literal}
    var longitude = {/literal}{$mapNode.data_map.localizzazione.content.latitude}{literal};
    var latitude = {/literal}{$mapNode.data_map.localizzazione.content.longitude}{literal};
    var address = '{/literal}{$mapNode.data_map.localizzazione.content.address}{literal}';

    var map = L.map('{/literal}map-{$node.node_id}{literal}').setView([longitude, latitude], {/literal}{$mapZoom}{literal});
    map.scrollWheelZoom.disable();

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    var customIcon = L.MakiMarkers.icon({icon: "star", color: "#00f", size: "l"});
    
    L.marker([longitude, latitude], {icon: customIcon}).addTo(map)
        .bindPopup(address)
        .openPopup();
{/literal}
</script>