<div class="media-panel">

    {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

  <div class="media">
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
          <h1 style="margin-top: -5px;"><i class="fa {$icon} d_inline_middle"></i></h1>
        </div>
      </div>

      <p class="abstract">
          {$node|abstract()|openpa_shorten(300)}
      </p>

      <div class="row">
        <div class="col-xs-8">
            {if $node|has_attribute( 'tematica' )}
            <p>
              {attribute_view_gui attribute=$node|attribute( 'tematica' )}
            </p>
            {/if}
        </div>
        <div class="col-xs-4">
          <p class="link"><a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{"Listen"|i18n('design/pat_base/generic')}</a></p>
        </div>
      </div>

    </div>
  </div>
</div>