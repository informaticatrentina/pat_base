<div class="media-panel card-material">
    
  
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
                  border-radius: 5px;
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
      <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>        
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}">   
    <div class="caption">
      <h4 class="fw_medium color_dark">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a>
      </h4>
      <p class="abstract">
          {$node|attribute('short_name').data_text|wash()}
      </p>
      
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}" {if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if}>Apri Link</a>
      </p>
      
    </div>
  </div>
</div>