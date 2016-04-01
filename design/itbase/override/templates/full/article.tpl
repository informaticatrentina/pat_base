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
$node|has_attribute( 'fonte' ),
$node|has_attribute( 'geo' ),
gt($images|count,1), $matrix_link_has_content
)}
    {set $has_sidebar = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">


    <div class="content-title">

        {*
        {if is_set( $view_parameters.anteprima )}
            <p>
                <a href="{concat(ezurl(no), '/ufficiostampa/edit/', $node.object.id)}" class="btn btn-info btn-lg">Chiudi anteprima</a>
            </p>
        {/if}
        *}

        {if or( $node|has_attribute( 'numero' ), $node|has_attribute( 'argomento' ) )}
            <p class="pull-right">
                {if $node|has_attribute( 'numero' )}
                    <span class="date label label-info">Comunicato {attribute_view_gui attribute=$node|attribute( 'numero' )}  </span>
                {/if}
                {if $node|has_attribute( 'argomento' )}
                    <span style="margin-left: 10px;">{attribute_view_gui attribute=$node|attribute( 'argomento' )}</span>
                {/if}
            </p>
        {/if}

        {if $node|has_attribute( 'published' )}
            <span class="date">{$node|attribute( 'published' ).content.timestamp|l10n( 'date' )} </span>
        {/if}

        <h1>
            {if $node|has_attribute( 'occhiello' )}
                <small style="font-weight: normal;color: #000">
                    {attribute_view_gui attribute=$node|attribute( 'occhiello' )}
                </small><br />
            {/if}
            {$node.name|wash()}
        </h1>

        {if $node|has_attribute( 'sottotitolo' )}
            <h2>
                {attribute_view_gui attribute=$node|attribute( 'sottotitolo' )}
            </h2>
        {/if}

    </div>

    <div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">

        {if $node|has_attribute( 'abstract' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
        {/if}

        {if gt($images|count,0)}
            <div class="main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>
        {/if}

        {*if $node|has_attribute( 'persone' )}
            {attribute_view_gui attribute=$node|attribute( 'persone' )}
        {/if*}
        
        {if $node|has_attribute( 'body' )}
            <div class="description">
                {attribute_view_gui attribute=$node|attribute( 'body' )}
            </div>
        {/if}
        
         {if $node.data_map.tags.has_content }
          <div class="tags-container">
              {if $node.data_map.tags.has_content}
                  <div>
                      <strong>Tags:</strong> {attribute_view_gui attribute=$node.data_map.tags}
                  </div>
              {/if}
          </div>
        {/if}
        
        <hr/>{include uri='design:parts/social_buttons.tpl'}

    </div>

    {if $has_sidebar}
        <div class="content-related">

            {if $node|has_attribute( 'allegati' )}
                <h2><i class="fa fa-file-text"></i> Allegati</h2>
                {attribute_view_gui attribute=$node|attribute( 'allegati' )}
            {/if}


            {if gt($images|count,1)}
                <h2><i class="fa fa-camera"></i> Immagini</h2>
                {include uri='design:atoms/gallery.tpl' items=$images}
            {/if}

            {if $matrix_link_has_content}
                <h2><i class="fa fa-link"></i> Link</h2>
                {*attribute_view_gui attribute=$node|attribute( 'link' )*}
                <ul  class="list-unstyled">{foreach $node|attribute( 'link' ).content.rows.sequential as $row}
                <li style="padding-bottom: 10px;">
                {foreach $row.columns as $index => $column}                  
                    {if $column|ne('')}
                        {if eq( $index, '0')}                           
                            <a href="{$column}" target="_blank">
                        {/if}
                        {if eq( $index, '1')}
                            {$column}
                        {/if}
                    {/if}                   
                {/foreach}
                </a>
                 </li>
                {/foreach}
            {/if}
            </ul>

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