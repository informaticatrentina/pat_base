<div class="content-view-full class-{$node.class_identifier} row">

    {if or( $node|has_attribute( 'numero' ), $node|has_attribute( 'argomento' ) )}
        <p class="pull-right">
            {if $node|has_attribute( 'numero' )}
                <span class="date label label-info">Comunicato {attribute_view_gui attribute=$node|attribute( 'numero' )}  </span>
            {/if}
            {if $node|has_attribute( 'tematica' )}
                <span style="margin-left: 10px;"><i class="fa fa-tag"></i>{attribute_view_gui attribute=$node|attribute( 'tematica' )}</span>
            {/if}
        </p>
    {/if}

    <div class="content-title">
        <h1><i class="fa fa-file-audio-o"></i> {attribute_view_gui attribute=$node|attribute( 'titolo' )}</h1>
       <p>{attribute_view_gui attribute=$node|attribute( 'data' )}</p>

    </div>

    <div class="content-main">

        {def $audio_file = $node.data_map.file}

        {if $node|has_attribute( 'file' )}
            <div class="file">
                    {if $audio_file.has_content}
                        {include name=player
                        uri='design:atoms/new_player.tpl'
                        file=$audio_file
                        }
                    {/if}
            </div>
        {/if}

        {if $audio_file.has_content}
            <div class="file">
                <strong>Scarica l'audio:</strong>
                {attribute_view_gui attribute=$node|attribute( 'file' )}
            </div>
        {/if}

        <hr/>

        {if $node|has_attribute( 'abstract' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
        {/if}
         

    </div>

    <div class="content-related">
        
        {if $node|has_attribute( 'argomento' )}
              <div class="tags">
                   <h2><i class="fa fa-tags"></i> Argomenti</h2>
                   {attribute_view_gui attribute=$node|attribute( 'argomento' )}
              </div>
        {/if}
        
        {include uri='design:parts/social_buttons.tpl'}

    </div>
</div>

{include uri='design:atoms/related.tpl' item=$node}
