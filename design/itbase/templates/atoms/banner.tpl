{set_defaults( hash(
'item', false(),
'caption', false()
))}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $item ) )}

{if $item}
<div class="card-material banner">
    {*if $item|ne('')}
        <header>
            <h3 class="widget_title">
                {$item.name|wash()}
            </h3>
        </header>
    {/if*}
  {def $target_url = $item.data_map.url.content
       $external_url = true()}

  {if gt($item.data_map.internal_link.content.relation_list|count(),0)}
    {*$item.data_map.internal_link.content.relation_list|attribute(show)*}
    {def $obj = fetch('content','object',hash('object_id',$item.data_map.internal_link.content.relation_list[0].contentobject_id))}
    {set $target_url = $obj.main_node.url_alias|ezurl(no)
         $external_url = false()}
    {*set $target_url = fetch('content','object',hash('object_id',$item.data_map.internal_link.content.id)).main_node.url_alias|ezurl(no)*}
  {/if}

  {if $can_edit}
      <div >
        <a style="position: absolute;
                  right: 30px;
                  padding-top: 8px;
                  padding-bottom: 8px;
                  padding-left: 10px;
                  padding-right: 10px;
                  margin-top: 10px;
                  border-radius: 5px;
                  color: white;
                  background-color: rgba(0,0,0,0.8);"
                  
                  href={$item.url_alias|ezurl} >
            <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-pencil"></i>
            </h3>
        </a>
      </div>
  {/if}
  
  {if gt($target_url|count(),0)}
    <a class="figcontainer" href="{$target_url}" {if $external_url}target="_blank"{/if} title="{$item.name|wash()}">
      <img src={$item.data_map.image.content['original'].url|ezroot} class="img-responsive" alt="{$item.name|wash()}">
      {if $caption}
	      <div class="caption" >{$item.name|oc_shorten(28,'...')}</div>
      {else}
        <div class="sr-only">{$item.name|wash()}</div>
      {/if}
      {*if $item.data_map.caption.has_content}
        <div class="legend" >{$item.data_map.caption.content|oc_shorten(28,'...')}</div>
      {/if*}
    </a>
  {else}
  <span class="figcontainer">
    <img src={$item.data_map.image.content['original'].url|ezroot} alt="{$item.name|wash()}">
    {if $caption}
	    <div class="caption" >{$item.name|oc_shorten(28,'...')}</div>
    {else}
      <div class="sr-only">{$item.name|wash()}</div>
    {/if}
    {*if $item.data_map.caption.has_content}
      <div class="legend" >{$item.data_map.caption.content|oc_shorten(28,'...')}</div>
    {/if*}
  </span>
  {/if}

  {undef $target_url}
</div>
{/if}