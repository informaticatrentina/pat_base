<div class="card-material media-panel">

    {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

  <div class="media">
    <div class="caption">

      <div class="row">
        <div class="col-xs-10">
          <h4 class="fw_medium color_dark">
            {*<a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">*}
              {$node.name|openpa_shorten(60)|wash()}
            {*</a>*}
          </h4>
        </div>
        <div class="col-xs-2">
          <h1 style="margin-top: -5px;">
            <i class="fa {$icon} d_inline_middle"></i>
          </h1>
        </div>
      </div>

      <p class="abstract">
        {*$node|abstract()|openpa_shorten(300)*}
        {*
        {if $node|has_attribute( 'matricola' )}
            <i class="fa fa-user text-primary"></i>&nbsp;&nbsp; {attribute_view_gui attribute=$node|attribute('matricola')}
        {/if}
        
        <br/>
        *}
        {if $node|has_attribute( 'telefono' )}
            <i class="fa fa-phone text-primary"></i>&nbsp;&nbsp; {attribute_view_gui attribute=$node|attribute('telefono')}
            {if $node|has_attribute( 'numero_breve' )}
            	&nbsp; (
            	{attribute_view_gui attribute=$node|attribute('numero_breve')}
            	)
            {/if}
        {/if}
        <br/>
        {if $node|has_attribute( 'email' )}
            <i class="fa fa-envelope text-primary"></i>&nbsp;&nbsp; {attribute_view_gui attribute=$node|attribute('email')}
        {/if}
        <br/>
        {if $node|has_attribute( 'fax' )}
            <i class="fa fa-fax text-primary"></i>&nbsp;&nbsp; {attribute_view_gui attribute=$node|attribute('fax')}
        {/if}
      </p>

      {*
      <div class="row">
        <div class="col-xs-8">
            {if $node|has_attribute( 'argomento' )}
            <p>
              {attribute_view_gui attribute=$node|attribute( 'argomento' )}
            </p>
            {/if}
        </div>
        <div class="col-xs-4">
          <p class="link"><a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Visualizza</a></p>
        </div>
      </div>
      *}

    </div>
  </div>
</div>