<div class="media-panel">
    
    {if $node|has_attribute('image')}
        <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>        
    {/if}

    {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

    {def $titolo = ''}

    {if $node.data_map.titolo.content|ne('')}
        {set $titolo = $node.data_map.titolo.content}
    {else}
        {set $titolo = $node.name}
    {/if}
  
    <div class="media{if $node|has_attribute('image')} has-image{/if}">    
      <div class="caption">

        <div class="row">
              <div class="col-xs-10">
                  <h4 class="fw_medium color_dark">
                      <a href={$node.data_map.base_url.content} target="_blank" title="{$titolo|wash()}">
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

        <p class="abstract">
          {$node|abstract()|openpa_shorten(270)}
        </p>

        <p class="link">
            <a href={$node.data_map.base_url.content} target="_blank" title="{$titolo|wash()}">{"GoToOriginal"|i18n('design/pat_base/generic')}</a>
        </p>

      </div>
    </div>
</div>