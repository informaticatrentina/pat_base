<div class="media-panel">
    {if $is_block }
    {if $node|has_attribute( 'image' )}  
        <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
             {def $com_img = fetch('content','node',hash('node_id',$node.data_map.image.content.relation_list[0].node_id))}
              {def $com_img_url = $com_img|attribute('image').content['widemedium']}

              <figure style="background: url( {$com_img_url.url|ezroot(no)} )"></figure>
              {undef $com_img
                     $com_img_url}
        </a>
    {/if}
    <div class="carousel-caption">
      <h4>
          <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
              {$node.name|wash()}
          </a>
      </h4>
    </div>
    {else}
        {def $images = array()
             $index = 0}
        {foreach $node.data_map.image.content.relation_list as $relation_item}
            {if $index|ge(6)}
                {break}
            {/if}
            {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
            {set $index = $index|sum(1)}
        {/foreach}

        <div class="gallery-panel">
            <div class="row">
                <div class="col-xs-8">
                    <h3>
                        <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
                            {$node.name|wash()}
                        </a>
                    </h3>
                </div>
                <div class="col-xs-4 text-right">
                    <span class="fa-stack fa-3x related-icon">
                        <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                        <i class="fa fa-camera fa-stack-1x"></i>
                    </span>
                </div>
            </div>

            {include uri='design:atoms/gallery.tpl' items=$images}
        </div>

        {include uri='design:parts/related-script.tpl'}

        {include uri='design:parts/related-script.tpl'}
    {/if}
</div>