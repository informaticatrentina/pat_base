
{def $current_user = fetch( 'user', 'current_user' )
    $is_admin = false()}

{if $current_user.is_logged_in}
   {foreach $current_user.roles as $role}
       {if $role.name|eq('Administrator')}
           {set $is_admin = true()}
       {/if}
   {/foreach}
{/if}


<div class="media-panel">
  {if $node|has_attribute( 'image' )}
      <figure style="background: url( {$node.data_map.image.content.imagefull.full_path|ezroot(no)} )"></figure>
  {/if}

  {def $icon = ezini( 'ClassIcons', $node.object.class_identifier, 'fa_icons.ini.append.php' )}

  <div class="media{if $node|has_attribute('image')} has-image{/if}">
    <div class="caption">

      <h4 class="fw_medium color_dark">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
              {$node.name|openpa_shorten(60)|wash()}
          </a>
          {if $node.children_count|gt(0)}<small>{$node.children_count} video</small>{/if}
          <small>{$node.object.published|l10n('shortdate')}</small>
      </h4>
  
      <p class="abstract">
        {if $node.children_count|gt(0)}
            <div class="clearfix">
                {def $limit = 1}
                {foreach $node.children as $child}
                    <a href="{if is_set( $child.url_alias )}{$child.url_alias|ezurl('no')}{else}#{/if}" class="pull-left" style="margin-right: 1px; margin-bottom: 1px;">
                        {attribute_view_gui attribute=$child.object.data_map.image image_class="widemini"}
                    </a>
                    {if eq($limit,6)}{break}{/if}
                    {set $limit=inc( $limit )}
                {/foreach}
            </div>
        {/if}
      </p>

        <div class="row">
            <div id="forcePlaylist{$node.node_id}" class="col-xs-8">
                {if $is_admin}
                    {*if patstampa('youtubeplaylist', $node.node_id)}
                        <div class="label label-success">Importazione riprogrammata</div>
                    {else*}
                        <button id="forcePlaylistImport{$node.node_id}" class="btn btn-primary">
                            Importa nuovi video
                        </button>
                    {*/if*}
                {/if}
            </div>
            <div class="col-xs-4">
                <p class="link">
                    <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Guarda</a>
                </p>
            </div>
        </div>

    </div>
  </div>
</div>
      
{if $is_admin}
    <script>
        {literal}
        $("#forcePlaylistImport{/literal}{$node.node_id}{literal}").click(function() {
            {/literal}
            var base_url = {concat('/ptn/force_playlist_import/',$node.node_id)|ezurl()};
            var node_id = {$node.node_id};
            {literal}

            var request = $.ajax({
                url: base_url,
                type: "GET", 
                async: false,
                dataType: "json"
            });

            request.done(function( msg ) {
                
                if(msg.playlistImportForced){
                    $("#forcePlaylist" + node_id).html( "<div class=\"label label-success\">Importazione riprogrammata</div>" );
                }
                else{
                   $("#forcePlaylist" + node_id).html( "<div class=\"label label-danger\">Problemi in riprogrammazione</div>" );
           
                }
                
            });

            request.fail(function(jqXHR, textStatus) {
                $("#forcePlaylist" + node_id).html( "<div class=\"label label-danger\">Request failed: " + textStatus + "</div>" );
            });
        });
        {/literal}
    </script>
{/if}
                
{undef $current_user
       $is_admin}