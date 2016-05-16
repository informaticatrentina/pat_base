{if $node|has_attribute( 'allegati' )}
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>allegati</h3>
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-paperclip fa-stack-1x"></i>
                </span>
            </div>
        </div>

        {attribute_view_gui attribute=$node|attribute( 'allegati' )}
    </div>
{/if}