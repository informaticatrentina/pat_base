{def $valid_nodes = $block.valid_nodes}

<div class="block-type-itemlist item-list">

  <div class="attribute-header">
    <h2>{$block.name|wash()}</h2>
  </div>

  <ul class="media-list">
    {foreach $valid_nodes as $_node}
      {node_view_gui content_node=$_node
      view="media-list_item"
      show_date=true()
      }
    {/foreach}
  </ul>

</div>

{undef $valid_nodes}
