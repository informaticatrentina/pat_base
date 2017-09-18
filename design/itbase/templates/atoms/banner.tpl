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
    
  {* Se ci sono i permessi aggiunta icona all'edit del banner *}
  {if $can_edit}
      <div >
        <a class="edit-pencil" style="cursor: pointer;" onclick="document.getElementById('ContentObjectedit{$item.object.id}').submit(); event.stopPropagation();" >
            <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-pencil"></i>
            </h3>
        </a>
      </div>
  {/if}
  {* Se il link è sterno viene aggiunta in centro un'icona *}
  {if $external_url}
      <div >
        <a id="ext_url{$item.main_node_id|wash()}" class="external-url" href="{$target_url}" {if $external_url}target="_blank"{/if} title="{$item.name|wash()}">
                <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>
            </h3>
        </a>
      </div>
  {/if}
  
  {if gt($target_url|count(),0)}
    <a class="figcontainer" href="{$target_url}" {if $external_url}target="_blank"{/if} title="{$item.name|wash()}">
      <img id="image_id{$item.main_node_id|wash()}" src={$item.data_map.image.content['original'].url|ezroot} class="img-responsive" alt="{$item.name|wash()}">
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
    <img id="image_id{$item.main_node_id|wash()}" src={$item.data_map.image.content['original'].url|ezroot} alt="{$item.name|wash()}">
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

{* Se il link è sterno viene aggiunta in centro un'icona *}
{if $external_url}
    {literal}
    <script>
        $(window).load(function(){
            
            $heightDiv = $('#image_id{/literal}{$item.main_node_id|wash()}{literal}').height();             
            $heightLink = $('#ext_url{/literal}{$item.main_node_id|wash()}{literal}').height();     
            $('#ext_url{/literal}{$item.main_node_id|wash()}{literal}').css( "margin-top", ($heightDiv/2)-(18) );

        });

    </script>
     {/literal}
 {/if}
 
{* Form per puntare direttamente all'edit del banner *}
{if $can_edit}
    <form method="post" action={"content/action"|ezurl} name="ContentObjectedit{$item.object.id}" id="ContentObjectedit{$item.object.id}">
            <input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />       
            <input type="hidden" name="EditButton">
            <input type="hidden" name="HasMainAssignment" value="1">
            <input type="hidden" name="ContentObjectID" value="{$item.object.id}" />
            <input type="hidden" name="NodeID" value="{$item.node_id}" />
            <input type="hidden" name="ContentNodeID" value="{$item.node_id}" />	
            <input type="hidden" name="RedirectIfDiscarded" value="/" />		
            <input type="hidden" name="RedirectURIAfterPublish" value="/" />
        </form>  
{/if}    