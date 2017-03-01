{set_defaults( hash(  
  'thumbnail_class', 'relatedthumb',
  'wide_class', 'imagefullwide',
  'items', array(),
  'fluid', false(),
  'mode', 'strip',
  'link_node', false(),
  'node_id', $node.node_id
))}

<div class="gallery gallery-{$mode}" id="galleryBlueimp{$node_id}">
 {foreach $items as $item}
    {*{$item.data_map.image.content.video_play.url|*}
    {*$item|attribute('show')*}
    {if $can_edit}
            <span class="gallery-edit-pencil"
                  onclick="document.getElementById('ContentObjectedit{$item.object.id}').submit(); event.stopPropagation();">
                <h3 style="margin-bottom: 0px; 
                           margin-top: 0px;">
                    <i class="fa fa-pencil"></i>
                </h3>
                </span>  
        {/if}  
        <a class="gallery-strip-thumbnail {$thumbnail_class}" href={$item.url|ezurl()} >
        {if $item|has_attribute( 'image' )}
            {attribute_view_gui attribute=$item|attribute('image') image_class=$thumbnail_class fluid=$fluid}
        {else}
            <img src='/extension/pat_base/design/itbase_v3/images/videoImgAnteprimaDefault.png' image_class=$thumbnail_class >
        {/if} 
    </a>        
{/foreach}   

{if $can_edit}
    {foreach $items as $item}
       <form method="post" action={"content/action"|ezurl} name="ContentObjectedit{$item.object.id}" id="ContentObjectedit{$item.object.id}">
            <input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />       
            <input type="hidden" name="EditButton">
            <input type="hidden" name="HasMainAssignment" value="1">
            <input type="hidden" name="ContentObjectID" value="{$item.object.id}" />
            <input type="hidden" name="NodeID" value="{$item.node_id}" />
            <input type="hidden" name="ContentNodeID" value="{$item.node_id}" />	
            <input type="hidden" name="RedirectIfDiscarded" value="{$node.url_alias}" />		
            <input type="hidden" name="RedirectURIAfterPublish" value="{$node.url_alias}" />
        </form> 
    {/foreach}
{/if}  
</div>

