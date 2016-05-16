{if $node|has_attribute( 'geo' )}
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>luogo</h3>
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-map-marker fa-stack-1x"></i>
                </span>
            </div>
        </div>
        {if $node|has_attribute( 'indirizzo' )}
            <small style='color: #333;'>
                {attribute_view_gui attribute=$node|attribute('indirizzo')}
            </small>
        {/if}
        {attribute_view_gui attribute=$node.data_map.geo zoom=3}
    </div>
{/if}