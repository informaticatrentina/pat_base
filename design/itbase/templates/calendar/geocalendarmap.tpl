{def $calendarData = calendar( $node, $view_parameters|merge( hash( 'interval', 'P1M', 'view', 'calendar' ) ) ) }

{run-once}

{def $domain=ezsys( 'hostname' )|explode('.')|implode('_')}

<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
<script type="text/javascript">

{literal}
/* <![CDATA[ */
function eZGmapCalendar_MapView(  ) {
    {/literal}
    var locations = [
        {def $index=1}
        
        {foreach $calendarData.events as $event}
            {if $event.node|has_attribute( 'geo') }
                [
                '{$event.name|wash()}',
                {$event.node.data_map.geo.content.latitude},
                {$event.node.data_map.geo.content.longitude},
                {$index},
                {if $event.node.data_map.color.content[0]|eq(0)}
                    'red-dot'
                {elseif $event.node.data_map.color.content[0]|eq(1)}
                    'green-dot'
                {elseif $event.node.data_map.color.content[0]|eq(2)}
                    'blue-dot'
                {elseif $event.node.data_map.color.content[0]|eq(3)}
                    'yellow-dot'
                {/if}
                ],
                
                {set $index = $index|sum(1)}
            {/if}
        {/foreach}
            
        {undef $index}
    ];
    {literal}
    
    var myLatlng = new google.maps.LatLng(46.07323062540838, 11.1181640625);
    
    var mapOptions = {
        zoom: 7,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(document.getElementById( 'ezgml-map-calendar' ), mapOptions);

    var marker, i;
    
    for(i = 0; i<locations.length; i++){
        image = "http://maps.google.com/mapfiles/ms/icons/" + locations[i][4] + ".png";
        
        marker = new google.maps.Marker({
            position: new google.maps.LatLng( locations[i][1], locations[i][2] ),
            map: map,
            title: locations[i][0],
            animation: google.maps.Animation.DROP,
            icon: new google.maps.MarkerImage( image )
        });
    }
}
/* ]]> */
{/literal}

</script>
{/run-once}

<script type="text/javascript">
    <!--
    google.maps.event.addDomListener(window
    , 'load'
    , function(){ldelim} eZGmapCalendar_MapView(  ) {rdelim});
    -->
</script>

<div id="ezgml-map-calendar" style="width: 100%; height: 320px;"></div>
