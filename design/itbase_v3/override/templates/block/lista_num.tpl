{def $openpa = object_handler($block)}

{set_defaults( hash(
    'sort', 'name',
    'limit', 24,
    'depth', 1,
    'include_classes', false(),
    'exclude_classes', false(),

    'show_title', true(), 
    'items_per_row', 2
) ) }

{def $bg_color_is_set = false()} 
{if $block.custom_attributes.bg_color|count_chars()|gt(3)} 
   {set $bg_color_is_set = true()}
{/if}

{* sovrascrivo fetch di openpa poiché l'ordinamento non funziona *}
{if $block.custom_attributes.livello_profondita}
    {set $depth = $block.custom_attributes.livello_profondita}
{/if}

{if $block.custom_attributes.limite}
    {set $limit = $block.custom_attributes.limite}
{/if}

{if $block.custom_attributes.includi_classi}
    {set $include_classes = $block.custom_attributes.includi_classi|explode(',')}
{/if}

{if $block.custom_attributes.escludi_classi}
    {set $exclude_classes = $block.custom_attributes.escludi_classi|explode(',')}
{/if}

{def $sort_array = array( 'name', true())}

{if $block.custom_attributes.ordinamento}
    {set $sort = $block.custom_attributes.ordinamento}

    {switch match=$sort}
        {case match='name'}
            {set $sort_array = array( 'name', true())}
        {/case}
        {case match='pubblicato'}
            {set $sort_array = array( 'published', false())}
        {/case}
        {case match='published'}
            {set $sort_array = array( 'published', false())}
        {/case}
        {case match='modificato'}
            {set $sort_array = array( 'modified', false())}
        {/case}
        {case match='modified'}
            {set $sort_array = array( 'modified', false())}
        {/case}
        {case match='priority'}
            {set $sort_array = array( 'priority', true())}
        {/case}
    {/switch}
{/if}

{def $block_node = fetch('content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )
     $items = array()}

{if $include_classes}
    {set $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                 'sort_by', $sort_array,
                                                 'class_filter_type', 'include',
                                                 'class_filter_array', $include_classes,
                                                 'limit', $limit,
                                                 'depth', $depth ) ) }
{elseif $exclude_classes}
    {set $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                 'sort_by', $sort_array,
                                                 'class_filter_type', 'exclude',
                                                 'class_filter_array', $exclude_classes,
                                                 'limit', $limit,
                                                 'depth', $depth ) ) }
{else}
    {set $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                 'sort_by', $sort_array,
                                                 'limit', $limit,
                                                 'depth', $depth ) ) }
{/if}

<div class="widget home_widget card-material relative carousel-top-control panels-container {if or( $show_title|not(), $block.name|eq('') )}title-placeholder{/if} {$block.view}"
     {if is_set($block.custom_attributes.bg_color)}
    style="background-color:{$block.custom_attributes.bg_color} !important"
{/if}
>

{if and( $show_title, $block.name|ne('') )}
<header>
    <div class="widget_title" {if is_set($block.custom_attributes.bg_color)} style="background-color:{$block.custom_attributes.bg_color} !important" {/if}>
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
         items=$items
         root_node=$openpa.root_node
         i_view=panel
         autoplay=0
         image_class=squaremedium
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
