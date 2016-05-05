{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}

{def $images = array()}

{if gt($root_node.data_map.immagini.content.relation_list|count, 0)}
    {foreach $root_node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{else}
    {set $images|append('"/ptn/header_image"')}
{/if}

<div class="top-banner-small top-banner-v3">
    {include uri='design:header/site-logo.tpl' root_node=$root_node}
    {include uri='design:header/top-carousel.tpl' items=$images root_node=$root_node}
    {include uri='design:header/user-menu.tpl'}
    
    <div class="row">
        <div class="col-xs-12 text-center">
            <h1>
                {if $root_node|has_attribute('short_name')}
                    <a href={"/"|ezurl} title="{$root_node|attribute('short_name').data_text}">
                        {$root_node|attribute('short_name').data_text}
                    </a>
                {else}
                    <a href={"/"|ezurl} title="{$root_node.name}">
                        {$root_node.name}
                    </a>
                {/if}
            </h1>
        </div>
    </div>
</div>
                
{undef $images}
    