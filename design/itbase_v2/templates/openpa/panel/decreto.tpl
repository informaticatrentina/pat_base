<div class="media-panel">
  {if $node|has_attribute('image')}
      <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>        
  {/if}
  
  {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

  <div class="media{if $node|has_attribute('image')} has-image{/if}">    
    <div class="caption">
        
      <div class="row">
            <div class="col-xs-10">
                <h4 class="fw_medium color_dark">
                    <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
                        {$node.name|openpa_shorten(60)|wash()}
                    </a>
                    {*<small>{$node.object.published|l10n('shortdate')}</small>*}
                </h4>
            </div>
            <div class="col-xs-2">
                <h1 style="margin-top: -5px;">
                    <i class="fa {$icon} d_inline_middle"></i>
                </h1>
            </div>
        </div>
  
      <p class="abstract" >
        {$node.data_map.oggetto.content|openpa_shorten(270)}
      </p>
  
     
     <div class="row">
          <div class="col-xs-7">
            <p style="text-transform: uppercase;">
                      {if $node|has_attribute( 'tematica' )}
                          <i class="fa fa-tags"></i>
                          {attribute_view_gui attribute=$node|attribute( 'tematica' )}
                      {/if}
            </p>
          </div>
          <div class="col-xs-5">
            <p class="link">
              <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{"FullText"|i18n('design/pat_base/generic')}</a>
            </p>
        </div>
      </div>
            
    </div>
  </div>
</div>