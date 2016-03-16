<div class="media-panel">
  {if $node|has_attribute('image')}
      <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>        
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}">    
    <div class="caption">
      <h4 class="fw_medium color_dark">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a>
      </h4>
  
      <p class="abstract">
        {$node|abstract()}
      </p>
  
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{"Read"|i18n('design/pat_base/generic')}</a>
      </p>
  
    </div>
  </div>
</div>