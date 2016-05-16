{literal}
<style>
.media-panel.video figure:after {
    content: '\f16a';
    color: white;
    font: normal normal normal 14px/1 FontAwesome;
    font-size: 60px;
    opacity: 0.7;
    margin: 0 auto;
    width: 100px;
    display: block;
    padding-top: 80px;
    text-align: center;
}
</style>
{/literal}

<div class="media-panel video">
  {if $node|has_attribute( 'image' )}
      <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
        <figure style="background: url( {$node.data_map.image.content.video_play.full_path|ezroot(no)} )"></figure>
      </a>
  {/if}
  
  {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

  <div class="media{if $node|has_attribute('image')} has-image{/if}">    
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

        <p style="text-transform: uppercase;">
            {if $node|has_attribute( 'tematica' )}
                {attribute_view_gui attribute=$node|attribute( 'tematica' )}
            {/if}
        </p>

    </div>
  </div>
</div>