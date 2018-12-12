
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>{"entity info"|i18n('design/pat_base/generic')}</h3>                    
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-info fa-stack-1x"></i>
                </span>
            </div>
        </div>

         {if $node|has_attribute('ente')}
            
            <div class="row fw_medium color_dark">
                <div class="col-xs-12" style="padding-bottom: 10px" >
                    {attribute_view_gui attribute=$node|attribute('ente')}
                </div>
            </div>
                
        {/if}        
                
        {if $node|has_attribute('sede')}
            
            <div class="row fw_medium color_dark">
                <div class="col-xs-12" style="padding-bottom: 10px" >
                    {attribute_view_gui attribute=$node|attribute('sede')}
                </div>
            </div>
                
        {/if}       
                
      
        
    </div>
