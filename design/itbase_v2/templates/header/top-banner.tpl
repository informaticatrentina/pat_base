{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}

{def $header_image = '"/ptn/header_image"'}
{if $root_node|attribute('header_image').content.original.url}
    {set $header_image = $root_node|attribute('header_image').content.original.url|ezroot()}
{/if}

<div class="top-banner-small top-banner" style='background-image: url({$header_image})'>
    {include uri='design:header/user-menu.tpl'}
    <div class="site-logo">
        <a href="http://www.provincia.tn.it" title="Provincia Autonoma di Trento">
            {if $root_node|attribute('logo').content.original.url}
                <img src={$root_node|attribute('logo').content.original.url|ezroot()} alt="{$root_node.name}" />
            {/if}
        </a>
        {*
        <div>
            PROVINCIA AUTONOMA<br/>
            DI TRENTO
        </div>
        *}
    </div>
    <div class="site-title row">
        <div class="col-sm-offset-2 col-sm-10">
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
                
{undef $header_image}
    