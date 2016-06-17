{* https://github.com/blueimp/Gallery vedi anche page_extra.tpl *}
{ezscript_require( array( "ezjsc::jquery", "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( "plugins/blueimp/blueimp-gallery.css" ) )}

{set_defaults( hash(  
  'thumbnail_class', 'squarethumb',
  'wide_class', 'imagefullwide',
  'items', array(),
  'fluid', false(),
  'mode', 'strip'
))}

<div class="gallery gallery-{$mode}" id="galleryBlueimp{$node_id}" >
  {if $title}
    <h2>{$title}</h2>
  {/if}
  
  {foreach $items as $item}
    {def $caption=''}    
    {def $credits=''}
    {def $titolo = $item.name|wash()}    
    {if $item|has_attribute( 'caption' )}
      {set $caption = $item.data_map.caption.data_text|wash()}    
    {/if}
    {if $item|has_attribute( 'credits' )}
        {if $item.data_map.caption.has_content}             
            {set $credits = concat( ' - ' , $item.data_map.credits.data_text|wash())}
        {else}
            {set $credits = $item.data_map.credits.data_text|wash()}
        {/if}
    {/if}
    
    <a class="gallery-strip-thumbnail" href={$item|attribute('image').content[$wide_class].url|ezroot} title="{$titolo}" data-description="{$caption} {$credits}" data-gallery>
        {attribute_view_gui attribute=$item|attribute('image') image_class=$thumbnail_class fluid=$fluid}
        
    </a>
    {*  Se possibile attiva il pulsante di edit *}        
    {if $can_edit}
        <span style="position: absolute;                  
                  padding-top: 8px;
                  padding-bottom: 8px;
                  padding-left: 10px;
                  padding-right: 10px;
                  margin-top: 2px;
                  margin-left: -45px;
                  color: white;
                  background-color: rgba(0,0,0,0.8);
                  cursor: pointer;"
                  onclick="document.getElementById('ContentObjectedit{$item.object.id}').submit(); event.stopPropagation();">
            <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-pencil"></i>
            </h3>
        </span>  
    {/if}
    {undef $caption}
    {/foreach}
</div>

{if $can_edit}
    {foreach $items as $item}
       <form method="post" action={"content/action"|ezurl} name="ContentObjectedit{$item.object.id}" id="ContentObjectedit{$item.object.id}">
            <input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />       
            <input type="hidden" name="EditButton">
            <input type="hidden" name="HasMainAssignment" value="1">
            <input type="hidden" name="ContentObjectID" value="{$item.object.id}" />
            <input type="hidden" name="NodeID" value="{$item.node_id}" />
            <input type="hidden" name="ContentNodeID" value="{$item.node_id}" />	
            <input type="hidden" name="RedirectIfDiscarded" value="{$url_alias}" />		
            <input type="hidden" name="RedirectURIAfterPublish" value="{$url_alias}" />
        </form> 
    {/foreach}
{/if}  
        
{literal}
<style>
    .blueimp-gallery > .description, .blueimp-gallery > .example {
    position:fixed;
    bottom:30px;
    width:100%;    
    color: #fff;    
    font-size: 20px;
    line-height: 30px;
    color: #fff;
    text-shadow: 0 0 2px #000;
    opacity: 0.8;
    text-align: center;
    display: none;
  }
  .blueimp-gallery-controls > .description, .blueimp-gallery-controls > .example {
    display: block;
  }
</style>

<script>

   document.getElementById('galleryBlueimp{/literal}{$node_id}{literal}').onclick = function (event) {
    event = event || window.event;
    var curIndex = 0;
    var target = event.target || event.srcElement,
        link = target.src ? target.parentNode : target,
        options = {
            index: link, event: event, hidePageScrollbars: false ,
            onslide: function (index, slide) {
            self = this;
            
            var initializeAdditional = function (index, data, klass, self) {
                var text = self.list[index].getAttribute(data),
                    node = self.container.find(klass);
                    node.empty();
                    
                if (text) {
                    node[0].appendChild(document.createTextNode(text));
                }
                console.log(index);               
            };
        initializeAdditional(index, 'data-description', '.description', self);
        initializeAdditional(index, 'data-example', '.example', self);
      }
    },
    links = this.getElementsByTagName('a');
    
    var availHeight = window.screen.availHeight;
    var availWidth = window.screen.availWidth;
    var parent = document.getElementById("blueimp-gallery_slide");    
    var imgChild = parent.getElementsByTagName('div');     
    blueimp.Gallery(links, options);
    };

</script>
{/literal}