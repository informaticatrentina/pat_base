<div class="media-panel">
  {def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}
  {if $can_edit}
      <div >
        <a style="position: absolute;
                  right: 30px;
                  padding-top: 8px;
                  padding-bottom: 8px;
                  padding-left: 10px;
                  padding-right: 10px;
                  margin-top: 10px;
                  color: white;
                  background-color: rgba(0,0,0,0.8);"
                  
                  href={$node.url_alias|ezurl} >
            <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-pencil"></i>
            </h3>
        </a>
      </div>
  {/if}    
  {if $node|has_attribute('image')}
      <a href="{$node.data_map.location.content}" target="_blank" title="{$node.name|wash()}">
        <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>
      </a>
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}">   
    <div class="caption">
        <p>
          <h4 class="fw_medium color_dark">
              <a href="{$node.data_map.location.content}" target="_blank" title="{$node.name|wash()}">
                  {$node.name|openpa_shorten(60)|wash()}
              </a>
          </h4>
        </p>
      
        <div class="row">
            <div class="col-xs-5 media-line">
                
            </div>
        </div>
        
      <p class="abstract">
          {if $node|has_attribute('description')}
              {attribute_view_gui attribute=$node|attribute('description')}
            {*$node|attribute('description').data_text|openpashorten(200)|wash()*}
          {/if}
      </p>
    </div>
  </div>
</div>