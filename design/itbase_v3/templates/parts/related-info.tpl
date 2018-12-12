{if or($node|has_attribute( 'telefono' ), $node|has_attribute( 'email' ) , $node|has_attribute( 'indirizzo' ) )}
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                 <h3>{"events"|i18n('design/pat_base/generic')}</h3>                
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-info fa-stack-1x"></i>
                </span>
            </div>
        </div>

        {if $node|has_attribute('indirizzo')}
            
            <div class="row fw_medium color_dark">
                <div class="col-xs-1">
                    <i class="fa fa-thumb-tack"></i>
                </div>
                <div class="col-xs-11" style="padding-bottom: 10px" >
                    {attribute_view_gui attribute=$node|attribute('indirizzo')}
                    <br>
                </div>
            </div>
            
        {/if}
                
        {if $node|has_attribute('telefono')}
            
            <div class="row fw_medium color_dark">
                <div class="col-xs-1">
                    <i class="fa fa-phone"></i>
                </div>
                 <div class="col-xs-11" style="padding-bottom: 10px" >
                    {attribute_view_gui attribute=$node|attribute('telefono')}
                </div>
            </div>
                
        {/if}       
                
        {if $node|has_attribute('mobile')}
            
            <div class="row fw_medium color_dark">
                <div class="col-xs-1">
                    <i class="fa fa-mobile"></i>
                </div>
                 <div class="col-xs-11" style="padding-bottom: 10px" >
                    {attribute_view_gui attribute=$node|attribute('mobile')}
                </div>
            </div>
                
        {/if}       

                
        {if $node|has_attribute('fax')}
            
            <div class="row fw_medium color_dark">
                <div class="col-xs-1">
                    <i class="fa fa-fax"></i>
                </div>
                 <div class="col-xs-11" style="padding-bottom: 10px" >
                    {attribute_view_gui attribute=$node|attribute('fax')}
                </div>
            </div>
                
        {/if}       

        {if $node|has_attribute('indirizzo_email')}
           
            <div class="row fw_medium color_dark">
                <div class="col-xs-1">
                      <i class="fa fa-envelope"></i>
                </div>
                 <div class="col-xs-11" style="padding-bottom: 10px" >
                    <a href="mailto:{$node.object.data_map.indirizzo_email.content}">
                        {attribute_view_gui attribute=$node|attribute('indirizzo_email')}
                    </a>
                </div>
            </div>
                
        {/if}   
        {if $node|has_attribute('email')}
     
            <div class="row fw_medium color_dark">
                <div class="col-xs-1">
                      <i class="fa fa-envelope"></i>
                </div>
                 <div class="col-xs-11" style="padding-bottom: 10px" >
                    <a href="mailto:{$node.object.data_map.email.content}">
                        {attribute_view_gui attribute=$node|attribute('email')}
                    </a>
                </div>
            </div>
                
        {/if}       
        
    </div>
{/if}