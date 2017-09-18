{def $openpa = object_handler($block)}
{set_defaults(hash('show_title', true(), 'items_per_row', 2))}

{def $bg_color_is_set = false()} 
{if $block.custom_attributes.bg_color|count_chars()|gt(3)} 
   {set $bg_color_is_set = true()}
{/if}

<div class="widget home_widget card-material relative carousel-top-control panels-container {if or( $show_title|not(), $block.name|eq('') )}title-placeholder{/if} {$block.view}"
{if is_set($block.custom_attributes.bg_color)}
    style="background-color:{$block.custom_attributes.bg_color} !important"
{/if}
>
    
{if and( $show_title, $block.name|ne('') )}
<header>
    <div class="widget_title"
        {if is_set($block.custom_attributes.bg_color)}
            style="background-color:{$block.custom_attributes.bg_color} !important"
        {/if}>
        <h1>
            {if $openpa.root_node}<a href={$openpa.root_node.url_alias|ezurl()}>{/if}
            {$block.name|wash()}
            {if $openpa.root_node}</a>{/if}
        </h1>
    </div>
</header>
{/if}

{set $items_per_row = 1}

{if and(is_set($block.custom_attributes.columns), $block.custom_attributes.columns|ne(''))}
    {set $items_per_row = $block.custom_attributes.columns}
{/if}

{include uri='design:atoms/carousel_pat.tpl'
         css_id=$block.id
         items=$openpa.content
         root_node=$openpa.root_node
         i_view=panel
         autoplay=0
         image_class=responsive
         auto_height=true()
         items_per_row=$items_per_row
         bg_color_is_set=$bg_color_is_set
         is_block=true()}
         
         {if and(is_set($block.custom_attributes.show_all_btn), $block.custom_attributes.show_all_btn|eq('SI'))}
            <div class="text-right">
               {if $openpa.root_node}<a class="btn btn-sm btn-primary" href={$openpa.root_node.url_alias|ezurl()}>{/if}
                  {'Show all'|i18n('design/pat_base/generic')}...
               {if $openpa.root_node}</a>{/if}
            </div>
         {/if}
</div>
{unset_defaults(array('show_title','items_per_row'))}
