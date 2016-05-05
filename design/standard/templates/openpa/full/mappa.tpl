{* includo i js e i css necessari *}
{ezscript_require( array( 'leaflet.js') )}
{ezcss_require( array( 'leaflet.css' ) )}
{ezcss_require( array( 'map.css' ) )}

{init($node.node_id)}

<div class="content-view-full class-{$node.class_identifier}">

  <div class="content-main">
    <h1>{$node.name|wash()}</h1>

    {if $node.data_map.short_description.has_content}
      <div class="abstract">
        {attribute_view_gui attribute=$node.data_map.short_description}
      </div>
    {/if}

    <div id="map-{$node.node_id}" style="height: {$node.data_map.map_height.data_int}px;"></div>

    {if $node.data_map.short_description.has_content}
      <div class="body">
        {attribute_view_gui attribute=$node.data_map.description}
      </div>
    {/if}

    {* prendo i punti della geolocalizzazione *}
    {def $markerArray = getGeoDataAsArray()}

    {* prendo i punti appositamente formattati per il fitBounds *}
    {def $arrayForFitBounds = getGeoDataForFitBounds()}

    <script>
        var map = L.map('map-{$node.node_id}');

        {* fix per chiamata ajax da frontend *}
        L.Icon.Default.imagePath = {'javascript/images'|ezdesign()};

        {* scorro tutti i markers  *}
        {if is_set($markerArray)}

            {foreach $markerArray as $child}

                {* creo i markers sulla mappa *}
                var marker = L.marker([{$child.lat},{$child.lon}]).addTo(map);

                marker.bindPopup("<a href='{$child.urlAlias}'>{$child.popupMsg|wash('xhtml')}</a>");

            {/foreach}

        {/if}

        {* centro la mappa in un intorno dei markers *}
        map.fitBounds({$arrayForFitBounds});

        {* carico il layer di openstreetmap *}
        {literal}
            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 18
            }).addTo(map);
        {/literal}

    </script>

  </div>


    <div class="content-related">

        {* prendo i punti della geolocalizzazione *}
        {def $geoChildrenArray = getGeoChildren()}

        {if is_set($geoChildrenArray)}

            <ul>
                {foreach $geoChildrenArray as $child}

                    <li>
                        <a href="{$child.url_alias|ezurl("no")}">
                            {$child.name}
                        </a>
                    </li>

                {/foreach}
            </ul>
        {/if}


    </div>

</div>