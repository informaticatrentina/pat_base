{if $node|has_attribute( 'from_time' )}
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>date</h3>
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-calendar fa-stack-1x"></i>
                </span>
            </div>
        </div>

        <small style="color: #333;">
            da <b>{attribute_view_gui attribute=$node|attribute( 'from_time' )}</b>
            <br/>
            {if $node.data_map.to_time.has_content}
                a <b>{attribute_view_gui attribute=$node|attribute( 'to_time' )}</b>
            {/if}
        </small>
    </div>
{/if}
