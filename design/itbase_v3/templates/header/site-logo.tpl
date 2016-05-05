<div style="position: absolute;
            top: 0;
            left: 0;

            height: 50px;
            width: 100%;

            color: white;
            background-color: rgba(0,0,0,0.6);
            z-index: 10;">
</div>

<div style="position: absolute;
            top: 50px;
            left: 0;

            width: 100%;
            
            z-index: 20;">
    <div class="row">
        <div class="col-xs-4">
            
        </div>
        <div class="col-xs-1" style="padding:0px;">
            <div style="position:absolute;
                        right:0px;
                        
                        width:0px;
                        height:0px;
                        border-top: 100px solid rgba(0,0,0,0.6);
                        border-left: 50px solid transparent;">
                
            </div>
        </div>
        <div class="col-xs-2 text-center"
             style="
                    height: 100px;
                    
                    color: white;
                    background-color: rgba(0,0,0,0.6);">
            <a href="http://www.provincia.tn.it" title="Provincia Autonoma di Trento">
                {if $root_node|attribute('logo').content.original.url}
                    <img style="width: 60px;
                                margin-top:-40px;"
                         src={$root_node|attribute('logo').content.original.url|ezroot()} 
                         alt="{$root_node.name}" />
                {/if}
            </a>
        </div>
        <div class="col-xs-1" style="padding:0px;">
            <div style="width:0px;
                        height:0px;
                        border-top: 100px solid rgba(0,0,0,0.6);
                        border-right: 50px solid transparent;">
                
            </div>
        </div>
        <div class="col-xs-4">
            
        </div>
    </div>
</div>
