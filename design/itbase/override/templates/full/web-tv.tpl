{def $openpa = object_handler($node)}
{*if $openpa.content_tools.editor_tools}
  {include uri=$openpa.content_tools.template}
{/if*}

<div class="content-view-full class-folder row">

    <div class="content-title">
      <h1><i class="fa fa-youtube-play"></i> {$node.name|wash()}</h1>
    </div>

    <div class="content-main wide">

        {if $node|has_attribute( 'image' )}
            {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes="image-main"}
        {/if}

        {if $node|has_attribute( 'tags' )}
            <div class="tags">
                {foreach $node.data_map.tags.content.keywords as $keyword}
                    <span class="label label-primary">{$keyword}</span>
                {/foreach}
            </div>
        {/if}

        {if $node|has_attribute( 'description' )}
            <div class="description">
                {attribute_view_gui attribute=$node|attribute( 'description' )}
            </div>
        {/if}
        
        {include uri=$openpa.control_children.template page_limit = 20 show_short_description=1}

    </div>

    {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
    {*include uri='design:parts/content-related.tpl'*}

</div>
