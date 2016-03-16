{literal}
<style>
.media-panel.video figure:after {
    content: '\f01d';
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

        <div class="row">
            <div class="col-xs-10">
                <h4 class="fw_medium color_dark">
                    <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
                        {$node.name|openpa_shorten(60)|wash()}
                    </a>
                    <small>{$node.object.published|l10n('shortdate')}</small>
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

        <div class="row">
            <div class="col-xs-8">
                <p style="text-transform: uppercase;">
                    {if $node|has_attribute( 'argomento' )}
                        {attribute_view_gui attribute=$node|attribute( 'argomento' )}
                    {/if}
                </p>
            </div>
            <div class="col-xs-4">
                <p class="link">
                    <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{"Look"|i18n('design/pat_base/generic')}</a>
                </p>
            </div>
        </div>

    </div>
  </div>
</div>