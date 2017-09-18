{if or($node|has_attribute( 'telefono' ), $node|has_attribute( 'email' ))}
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>contatti</h3>
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-thumb-tack fa-stack-1x"></i>
                </span>
            </div>
        </div>
        <div  style="color: #333;">
            {if $node|has_attribute('telefono')}
            <p>
                <i class="fa fa-phone"></i>
                {attribute_view_gui attribute=$node|attribute('telefono')}
            </p>
            {/if}

            {if $node|has_attribute('email')}
            <p>
                <i class="fa fa-envelope"></i>
                {attribute_view_gui attribute=$node|attribute('email')}
            </p>
            {/if}
        </div>
    </div>
{/if}