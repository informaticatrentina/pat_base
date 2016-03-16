{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}
{default enable_help=true() enable_link=true() canonical_link=true()}

{if is_set($module_result.content_info.persistent_variable.site_title)}
    {set scope=root site_title=$module_result.content_info.persistent_variable.site_title}
{else}
    {let name=Path
         path=$module_result.path
         reverse_path=array()}
      {if is_set($pagedata.path_array)}
        {set path=$pagedata.path_array}
      {elseif is_set($module_result.title_path)}
        {set path=$module_result.title_path}
      {/if}
      {section loop=$:path}
        {set reverse_path=$:reverse_path|array_prepend($:item)}
      {/section}

    {set-block scope=root variable=site_title}
    {section loop=$Path:reverse_path}{$:item.text|wash}{delimiter} / {/delimiter}{/section} - {$root_node|attribute('short_name').data_text}
    {/set-block}

    {/let}
    
    {* Solo name comunicato se il nodo è un comunicato *}
    {if is_set($module_result.node_id)}
        {def $title_node = fetch('content', 'node', hash('node_id', $module_result.node_id))}
        
        {if $title_node.object.class_identifier|eq('comunicato')}
            {set $site_title = $title_node.name}
        {/if}
    {/if}
    
{/if}
    <title>{$site_title}</title>

    {if and(is_set($#Header:extra_data),is_array($#Header:extra_data))}
      {section name=ExtraData loop=$#Header:extra_data}
      {$:item}
      {/section}
    {/if}

    {* check if we need a http-equiv refresh *}
    {if $site.redirect}
    <meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />

    {/if}
    {foreach $site.http_equiv as $key => $item}
        <meta name="{$key|wash}" content="{$item|wash}" />

    {/foreach}
    {foreach $site.meta as $key => $item}
    {if is_set( $module_result.content_info.persistent_variable[$key] )}
        <meta name="{$key|wash}" content="{$module_result.content_info.persistent_variable[$key]|wash}" />
    {else}
        <meta name="{$key|wash}" content="{$item|wash}" />
    {/if}

    {/foreach}

    {* Facebook Meta Data*}
    {if is_set($title_node)}
        {if $title_node.object.class_identifier|eq('comunicato')}
            {include uri="design:parts/comunicato_og.tpl" node=$title_node}
        {elseif $title_node.object.class_identifier|eq('article')}
            {include uri="design:parts/article_og.tpl" node=$title_node}
        {elseif $title_node.object.class_identifier|eq('audio')}
            {include uri="design:parts/audio_og.tpl" node=$title_node}
        {elseif $title_node.object.class_identifier|eq('video')}
            {include uri="design:parts/video_og.tpl" node=$title_node}
        {/if}
    {/if}
    
    {undef $title_node}
    
    <meta name="generator" content="eZ Publish" />

{if $canonical_link}
    {include uri="design:canonical_link.tpl"}
{/if}

{if $enable_link}
    {include uri="design:link.tpl" enable_help=$enable_help enable_link=$enable_link}
{/if}

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes">    
<!-- Site: {ezsys( 'hostname' )} -->
{if ezsys( 'hostname' )|contains( 'opencontent' )}<meta name="robots" content="NOINDEX,NOFOLLOW" />{/if}


{/default}
