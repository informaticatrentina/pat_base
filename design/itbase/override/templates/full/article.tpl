{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $images = array()}
{def $argomenti = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{def $matrix_link_has_content = false()}
{if $node|has_attribute( 'link' )}
    {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
        {foreach $row.columns as $index => $column}
            {if $column|ne('')}
                {set $matrix_link_has_content = true()}
            {/if}
        {/foreach}
    {/foreach}
{/if}

{def $has_sidebar = false()}
{if or( 
$node|has_attribute( 'struttura' ), 
$node|has_attribute( 'allegati' ), 
$node|has_attribute( 'audio' ), 
$node|has_attribute( 'link' ), 
$node|has_attribute( 'fonte' ), 
$node|has_attribute( 'geo' ), 
$node|has_attribute( 'pubblicazione' ), 
gt($images|count,1), $matrix_link_has_content )}
  {set $has_sidebar = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">

        {if $node|has_attribute( 'argomento' )}
            <p class="pull-right">
                {if $node|has_attribute( 'argomento' )}
                    <span style="margin-left: 10px;">{attribute_view_gui attribute=$node|attribute( 'argomento' )}</span>
                {/if}
            </p>
        {/if}

        <h1>
          {if $node.data_map.occhiello.has_content}
              <small style="font-weight: normal;color: #000">{attribute_view_gui attribute=$node.data_map.occhiello}</small><br />
          {/if}
          {$node.name|wash()}

          {*
          <small>
            <i class="fa fa-calendar"></i> {$node.object.published|l10n( 'shortdate' )}                    
            {include uri='design:atoms/autore.tpl' inline=true()}
          </small>*}
          
        </h1>
        {*<div class="publish-date">
            <small>{attribute_view_gui attribute=$node|attribute( 'publish_date' )}</small>
        </div>*}

    </div>

    <div class="content-main{if $has_sidebar|not()} wide{/if} body-article">
        
        {if $node|has_attribute( 'intro' )}
            <div class="abstract">
              {attribute_view_gui attribute=$node|attribute( 'intro' )}
            </div>
        {/if}

        {if gt($images|count,0)}
            <div class="main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>
        {/if}

        {if $node|has_attribute( 'url_video' )}
            <div class="video-wrapper">
                {$node.data_map.url_video.content|autoembed(array( '<div class="video-container">', '</div>' ), hash( 'width', '850' ) )}
            </div>        
        {/if}

        {if $node|has_attribute( 'body' )}
            <div class="descrizione">
              {if $images}
                <div class="object-left">
                  {include uri='design:atoms/image.tpl' item=$images[0] image_class=large caption=$images[0]|attribute( 'caption' ) css_classes='image-main'}
                </div>
              {/if}
              {attribute_view_gui attribute=$node|attribute( 'body' )}
            </div>
        {/if}
        
        {if or( $node.data_map.argomento.has_content, $node.data_map.tematica.has_content )}
          <div class="tags-container">
              {if $node.data_map.argomento.has_content}
                  <div>
                      <strong>Argomenti:</strong> {attribute_view_gui attribute=$node.data_map.argomento}
                  </div>
              {/if}

              {if $node.data_map.tematica.has_content}
                  <div>
                      <strong>Tematiche:</strong> {attribute_view_gui attribute=$node.data_map.tematica}
                  </div>
              {/if}
          </div>
        {/if}

        <hr />
        {include uri='design:parts/social_buttons.tpl'}

        {if $node|has_attribute( 'star_rating' )}
            <div class="rating">
                {attribute_view_gui attribute=$node|attribute( 'star_rating' )}
            </div>
        {/if}

        {*
        {if $node|has_attribute( 'comments' )}
            <div class="comments">
                <hr />
                <h3><i class="fa fa-comments"></i> Commenti</h3>
                {attribute_view_gui attribute=$node|attribute( 'comments' )}
            </div>
        {/if}
        *}

    </div>

    {if $has_sidebar}
        <div class="content-related">

            {if $node|has_attribute( 'pubblicazione' )}

                <h2><i class="fa fa-newspaper-o"></i> Rivista</h2>

                {def $rivista=fetch( content, object, hash( object_id, $node.object.data_map.pubblicazione.content.relation_list[0].contentobject_id ) )}

                <h4>
				{$rivista.name|wash()}
                <small style="text-transform: uppercase;">
            			{attribute_view_gui attribute=$rivista.data_map.mese} {attribute_view_gui attribute=$rivista.data_map.anno}
        		</small>
        		</h4>
                
                <a href="{$rivista.main_node.url_alias|ezurl("no")}">
                    <p>{attribute_view_gui attribute=$rivista|attribute( 'image' )}</p>
                </a>

                {if $rivista|has_attribute( 'sfoglia_online' )}
                    <p>
                        <a href="{$rivista.data_map.sfoglia_online.content}" target="_blank" class="btn btn-primary btn-info btn-lg"><i class="fa fa-tablet"></i> Sfoglia online</a>
                    </p>
                {/if}

            {/if}

            {if $node|has_attribute( 'struttura' )}
                <h2><i class="fa fa-sitemap"></i> Riferimento</h2>
                {attribute_view_gui attribute=$node|attribute( 'struttura' ) show_link=true()}
            {/if}

            {if $node|has_attribute( 'allegati' )}
                <h2><i class="fa fa-file-text"></i> Allegati</h2>
                {attribute_view_gui attribute=$node|attribute( 'allegati' )}
            {/if}

            {if $node|has_attribute( 'audio' )}
                <h2><i class="fa fa-volume-up"></i> Audio</h2>
                {attribute_view_gui attribute=$node|attribute( 'audio' )}
            {/if}

            {if gt($images|count,1)}
                {*<a href="{concat('Media/Immagini-rivista/(article_object_id)/',$node.object.id)|ezurl("no")}">*}
                    <h2><i class="fa fa-camera"></i> Immagini</h2>
                {*</a>*}
                {include uri='design:atoms/gallery.tpl' items=$images}
            {/if}

            {if $matrix_link_has_content}
                <h2><i class="fa fa-link"></i> Link</h2>
                <ul class="list-unstyled">
                {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
                  <li style="padding-bottom: 10px;">
                      <a href="{$row.columns[0]}">
                          {$row.columns[1]}
                      </a>
                  </li>
                {/foreach}
                </ul>
            {/if}

            {if $node|has_attribute( 'fonte' )}
                <h2><i class="fa fa-code-fork"></i> Fonte</h2>
                {attribute_view_gui attribute=$node|attribute( 'fonte' )}
            {/if}

            {if $node|has_attribute( 'geo' )}
                <h2>
                    <i class="fa fa-map-marker"></i> Luogo
                    <a class="btn btn-sm btn-info pull-right" target="_blank" href="https://www.google.com/maps/dir//'{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude}'/@{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude},15z?hl=it">Come arrivare</a>
                </h2>
                {attribute_view_gui attribute=$node.data_map.geo zoom=3}
            {/if}

        </div>
    {/if}
</div>


{include uri='design:atoms/related.tpl' item=$node}