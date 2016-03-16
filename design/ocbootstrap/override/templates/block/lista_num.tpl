{def $openpa = object_handler($block)}
{set_defaults(hash('show_title', true(), 'items_per_row', 2))}

<div class="card-material relative carousel-top-control panels-container {if or( $show_title|not(), $block.name|eq('') )}title-placeholder{/if} {$block.view}">

{if and( $show_title, $block.name|ne('') )}
    <h3 class="widget_title">
	  {if $openpa.root_node}<a href={$openpa.root_node.url_alias|ezurl()}>{/if}
	  {$block.name|wash()}
	  {if $openpa.root_node}</a>{/if}
	</h3>
{/if}

{set $items_per_row = 1}

{if and(is_set($block.custom_attributes.columns), $block.custom_attributes.columns|ne(''))}
    {set $items_per_row = $block.custom_attributes.columns}
{/if}

{include uri='design:atoms/carousel.tpl'
         css_id=$block.id
         items=$openpa.content
         root_node=$openpa.root_node
         i_view=panel
         autoplay=0
         image_class=squaremedium
         auto_height=true()
         items_per_row=$items_per_row}
</div>
{unset_defaults(array('show_title','items_per_row'))}
