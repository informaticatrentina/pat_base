<div class="media-panel">
  {if $node|has_attribute( 'immagini' )}  
      <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
           {def $com_img = fetch('content','node',hash('node_id',$node.data_map.immagini.content.relation_list[0].node_id))}
            {def $com_img_url = $com_img|attribute('image').content['widemedium']}
            
            <figure style="background: url( {$com_img_url.url|ezroot(no)} )"></figure>
            {undef $com_img
                   $com_img_url}
      </a>
  {/if}
  
  {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

  <div class="media{if $node|has_attribute('immagini')} has-image{/if}">    
    <div class="caption">
        <p>
            <small class="media-panel-date">{$node.object.published|l10n('date')}</small>
        </p>
        <p>
            <h4 class="fw_medium color_dark">
                <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
                    {$node.name|wash()}
                </a>
            </h4>
        </p>
        
        <div class="row">
            <div class="col-xs-5 media-line">
                
            </div>
        </div>
        
        <p class="abstract">
            {$node|abstract()|openpa_shorten(200)}
        </p>
        
        {include uri='design:parts/related-item.tpl'}

    </div>
  </div>
</div>