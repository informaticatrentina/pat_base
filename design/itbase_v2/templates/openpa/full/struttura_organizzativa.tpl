<div class="content-view-full class-struttura_organizzativa row">

  <div class="content-main wide">
  
    <div class="content-title">
        {if $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
          <h1>{$node.name|wash()}</h1>
        {/if}
    </div>
    
    <div class="content-main" style="margin-top: 40px">
        {if $node|has_attribute( 'declaratoria' )}
            {attribute_view_gui attribute=$node|attribute( 'declaratoria' )}
        {/if}
    </div>
    
    <div class="content-related">
        {if $node|has_attribute( 'geo' )}
            <h2>
                <i class="fa fa-map-marker"></i> Luogo
                <a class="btn btn-sm btn-info pull-right" target="_blank" href="https://www.google.com/maps/dir//'{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude}'/@{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude},15z?hl=it">Come arrivare</a>
            </h2>
            {attribute_view_gui attribute=$node.data_map.geo zoom=3}
        {/if}
        
        <h2>
            <i class="fa fa-user"></i>
            Contatti
        </h2>
        {*TODO: Fare controlli, incapsulare*}
        <ul class="list-unstyled">
            {if $node|has_attribute( 'indirizzo' )}
                <li>
                    <i class="fa fa-location-arrow"></i>
                    &nbsp;
                    {attribute_view_gui attribute=$node|attribute( 'indirizzo' )}
                </li>
            {/if}
            {if $node|has_attribute( 'telefono' )}
                <li>
                    <i class="fa fa-phone"></i>
                    &nbsp;
                    {attribute_view_gui attribute=$node|attribute( 'telefono' )}
                    {*attribute_view_gui attribute=$node|attribute( 'telefono2' )*}
                </li>
            {/if}
            {if $node|has_attribute( 'fax' )}
                <li>
                    <i class="fa fa-fax"></i>
                    &nbsp;
                    {attribute_view_gui attribute=$node|attribute( 'fax' )}
                </li>
            {/if}
            {if $node|has_attribute( 'email' )}
                <li>
                    <i class="fa fa-envelope"></i>
                    &nbsp;
                    {attribute_view_gui attribute=$node|attribute( 'email' )}
                </li>
            {/if}
        </ul>
    </div>
    
  </div>
  
</div>