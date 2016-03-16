<div class="media-panel">
  {if $node|has_attribute('image')}
      <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>        
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}"> 
    <div class="caption">
      <h4 class="fw_medium color_dark">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a>
      </h4>
  
      <p class="f_size_medium m_bottom_10 ">{$node.object.published||l10n(date)}</p>
      
      <p class="abstract">
        {$node|abstract()|openpa_shorten(270)}        
      </p>
  
      {if or( count($openpa.content_related.info)|gt(0), $openpa.content_gallery.has_images, $node|has_attribute( 'file' ) )}        
        <ul class="fa-ul panel-story">
          {if $node|has_attribute( 'file' )}
            <li><i class="fa-li fa fa-paperclip"></i> {attribute_view_gui attribute=$node|attribute( 'file' )}</li>
          {/if}
          {if $openpa.content_gallery.has_images}
            <li><i class="fa-li fa fa-camera"></i> <a href="{$openpa.content_link.full_link}" title="{$openpa.content_gallery.title|wash()}">{$openpa.content_gallery.title|wash()}</a>
          {/if}
          {if count($openpa.content_related.info)|gt(0)}          
            <li><i class="fa-li fa fa-link"></i> 
              {foreach $openpa.content_related.info as $class_name => $infos}{foreach $infos as $info}{node_view_gui content_node=$info view=text_linked}{delimiter}, {/delimiter}{/foreach}{delimiter}, {/delimiter}{/foreach}
            </li>
          {/if}
        </ul>        
      {/if}
      
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{"Read"|i18n('design/pat_base/generic')}</a>
      </p>
  
    </div>
  </div>
</div>