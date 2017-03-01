<style type="text/css">
   .img-responsive  {literal}{
        margin-top: 10px;
        margin-bottom: 10px;
    }{/literal}    
</style>

{def $valid_nodes = $block.valid_nodes}
{def $show_p_date = true()}

<div class="block-type-itemlist item-list">

  <div class="attribute-header">
    <h2>{$block.name|wash()}</h2>
  </div>
    {if eq($block.custom_attributes.number , 1)}
        {set $show_p_date = false()}
    {/if}
  <ul class="media-list">
    {foreach $valid_nodes as $_node}
      {node_view_gui content_node=$_node
      view="media-list_item"
      show_date=$show_p_date
      }
    {/foreach}
  </ul>

</div>

{undef $valid_nodes}
