{set-block scope=root variable=cache_ttl}600{/set-block}
{* Event - Full view *}

{def $from_year = cond( $node.data_map.from_time.has_content, $node.data_map.from_time.content.timestamp|datetime( custom, '%Y'), false() )
     $from_month = cond( $node.data_map.from_time.has_content, $node.data_map.from_time.content.timestamp|datetime( custom, '%m'), false() )
     $from_day = cond( $node.data_map.from_time.has_content, $node.data_map.from_time.content.timestamp|datetime( custom, '%j'), false() )
     $to_year = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp|datetime( custom, '%Y'), false() )
     $to_month = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp|datetime( custom, '%n'), false() )
     $to_day = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp|datetime( custom, '%j'), false() )
     $same_day = false()
}

{if and( $from_year|eq( $to_year ), $from_month|eq( $to_month ), $from_day|eq( $to_day ) )}
  {set $same_day = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">

  <article class="content-main">

    <header>
      <h1>{$node.name|wash()}</h1>
    </header>

    {if $node|has_attribute( 'intro' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'intro' )}
      </div>
    {/if}

    {if $node|has_attribute( 'immagini' )}
      {def $images = array()}
      {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
      {/foreach}
      {if $images}
        {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' )}
      {/if}
    {/if}

    {*include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )*}

    {if $node|has_attribute( 'body' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'body' )}
      </div>
    {/if}

    {if $node|has_attribute( 'attachment' )}
      <div class="attachment">
        {attribute_view_gui attribute=$node|attribute( 'attachment' )}
      </div>
    {/if}

  </article>

  <div class="content-related">

    {include uri='design:parts/event/detail.tpl'}

    {if gt($images|count,1)}
      <h2><i class="fa fa-camera"></i> Immagini</h2>
      {include uri='design:atoms/gallery.tpl' items=$images}
      {*if gt($images|count(),3)}
        {include uri='design:atoms/gallery.tpl' items=$images title="Immagini"}
      {else}
        {include uri='design:atoms/gallery.tpl' items=$images title="Immagini" thumbnail_class="squaremedium"}
      {/if*}
      {undef $images}
    {/if}

    {*include uri='design:parts/banners.tpl'*}

    {if $node|has_attribute( 'cooperative' )}
      <h2><i class="fa fa-flag"></i> Cooperative</h2>
      {attribute_view_gui attribute=$node.data_map.cooperative itemview=listitem show_link=true()}
    {/if}

    {if $node|has_attribute( 'convenzioni' )}
    <div class="convenzioni">
        <h2><i class="fa fa-exclamation-circle"></i> Convenzioni</h2>
        {attribute_view_gui attribute=$node.data_map.convenzioni itemview=listitem show_link=true()}
      </div>
    {/if}

    {if $node|has_attribute( 'Approfondimenti' )}
      <h2><i class="fa fa-file-o"></i> Approfondimenti</h2>
      {attribute_view_gui attribute=$node.data_map.approfondimenti itemview=listitem show_link=true()}
    {/if}


  </div>


</div>
