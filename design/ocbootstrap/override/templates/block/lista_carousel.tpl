{def $openpa= object_handler($block)}
{set_defaults(hash('show_title', true()))}

{def $items = array()
     $limite = $block.custom_attributes.limite}

{if $block.custom_attributes.super_node_id|is_set}
    {def $super_items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.super_node_id
                                                     , 'sort_by', array( 'priority', true() ) ) )}
                        
    {foreach $super_items as $item max $limite}
        {set $items = $items|append($item)}
    {/foreach}
    {undef $super_items}                                           
{/if}

{foreach $openpa.content as $item}
    {def $add_item = true()}
    {foreach $items as $__item}
        {if $item.contentobject_id|eq($__item.contentobject_id)}
            {set $add_item = false()}
        {/if}
    {/foreach}
    
    {if $add_item}
        {set $items = $items|append($item)}
    {/if}
    
    {if count($items)|ge($limite)}
        {break}
    {/if}
{/foreach}

{if and( $show_title, $block.name|ne('') )}
<div class="widget">
    <div class="widget_title">
        <h3>
            <a href={$openpa.root_node.url_alias|ezurl()}>{$block.name|wash()}</a>
        </h3>
    </div>
{/if}
    <div class="{if and( $show_title, $block.name|ne('') )}widget_content {/if}carousel-both-control card-material">
        {include name="carousel"
		  uri='design:atoms/carousel_pat.tpl'
		  items=$items
		  css_id=$block.id
		  root_node=$openpa.root_node
		  autoplay=10000
		  pagination=true()
		  navigation= false()
		  items_per_row=1}
    </div>

{if and( $show_title, $block.name|ne('') )}
</div>
{/if}

{unset_defaults(array('show_title'))}