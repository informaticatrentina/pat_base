{if $node|has_attribute('artisti')}
<div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>Vedi anche</h3>
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-bars fa-stack-1x"></i>
                </span>
            </div>
        </div>
        
        <ul class="list-unstyled">
       
                
            {attribute_view_gui attribute=$node|attribute('artisti') show_newline=true() show_pre=true()}
               
        </ul>
    </div>
 {/if}