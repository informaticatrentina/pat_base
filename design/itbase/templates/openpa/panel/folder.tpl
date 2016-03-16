<div class="media-panel card-material">
    
  {if $node|has_attribute('image')}
      <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
        <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>
      </a>
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}">    
    <div class="caption">
      <h4 class="fw_medium color_dark">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a>
      </h4>
      <p class="abstract">
          {$node|attribute('short_name').data_text|wash()}
      </p>
      {*
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Leggi</a>
      </p>
      *}
    </div>
  </div>
</div>