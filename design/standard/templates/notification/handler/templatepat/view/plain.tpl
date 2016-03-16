{set-block scope=root variable=subject}PAT - {$object.name|wash}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=content_type}text/html{/set-block}
{set-block variable=$content}
{if $object.data_map.occhiello.has_content}
<em>{attribute_view_gui attribute=$object.data_map.occhiello}</em><br />
{/if}

<h2 style="margin-top:5px;line-height: 1">{$object.name|wash}</h2>
{if $object.data_map.sottotitolo.has_content}
<h3>{attribute_view_gui attribute=$object.data_map.sottotitolo}</h3>
{/if}
{def $image = false()}
{if $object|has_attribute( 'immagini' )}
  {foreach $object.data_map.immagini.content.relation_list as $relation_item}
    {set $image = fetch('content','node',hash('node_id',$relation_item.node_id)).data_map.image.content['large']}
  {/foreach}
{/if}
{if $image}
  <div style="float: left; margin-bottom: 10px; margin-right: 10px">
    <img src="https://{ezini("SiteSettings","SiteURL")}{$image.url|ezroot(no)}" width="{$image.width}" height="{$image.height}" />
  </div>
{/if}
{attribute_view_gui attribute=$object.data_map.abstract}
<p><a href="https://{ezini("SiteSettings","SiteURL")}/content/view/full/{$object.main_node_id}">Leggi tutto il comunicato sul sito</a></p>
{/set-block}
{include uri="design:mail_pagelayout.tpl" content=$content}
