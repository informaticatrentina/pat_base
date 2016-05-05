<div class="media-panel card-material">

    
  {if $node|has_attribute( 'image' )}  
      <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
           {def $com_img = fetch('content','node',hash('node_id',$node.data_map.image.content.relation_list[0].node_id))}
            {def $com_img_url = $com_img|attribute('image').content['widemedium']}
            
            <figure style="background: url( {$com_img_url.url|ezroot(no)} )"></figure>
            {undef $com_img
                   $com_img_url}
          
            {*<figure style="background: url( {fetch('content','node',hash('node_id',$node.data_map.immagini.content.relation_list[0].node_id))|attribute('image').content.original.full_path|ezroot(no)} )"></figure>*}
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
      
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Apri</a>
      </p>
      
    </div>
  </div>
</div>