{* https://github.com/blueimp/Gallery vedi anche page_extra.tpl *}
{ezscript_require( array( "ezjsc::jquery", "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( "plugins/blueimp/blueimp-gallery.css" ) )}

{set_defaults( hash(  
  'thumbnail_class', 'relatedthumb',
  'wide_class', 'imagefullwide',
  'items', array(),
  'fluid', false(),
  'mode', 'strip',
  'link_node', false(),
  'node_id', $node.node_id,
  'pullleft', false()
))}
{def $caption=''}    
{def $credits=''}
{def $titolo =''}
<div class="{if $can_edit}row {/if} gallery gallery-{$mode}" id="galleryBlueimp{$node_id}">

    {foreach $items as $item}
      
    {if $can_edit}<div class="col-xs-6"> {/if}
    {set $caption=''}    
    {set $credits=''}
    {set $titolo = $item.name|wash()} 
   
    {if $item|has_attribute( 'caption' )}
      {set $caption = $item.data_map.caption.data_text|wash()}    
    {/if}
    {if $item|has_attribute( 'credits' )}
        {if $item.data_map.caption.has_content}             
            {set $credits = concat( ' -#### ' ,  $item.data_map.credits.data_text|wash() , ' ')}
        {else}
            {set $credits = concat( '####' , $item.data_map.credits.data_text|wash())}
        {/if}
    {/if}
    {*  Se possibile attiva il pulsante di edit *}        
    {if $can_edit}
        <span class="gallery-edit-pencil"
                  onclick="document.getElementById('ContentObjectedit{$item.object.id}').submit(); event.stopPropagation();">
            <h3 style="margin-bottom: 0px; 
                       margin-top: 0px;">
                <i class="fa fa-pencil"></i>
            </h3>
        </span>  
    {/if}
    <a class="gallery-strip-thumbnail {$thumbnail_class} {$pullleft}"
    {if $link_node|not()}
       href={$item|attribute('image').content[$wide_class].url|ezroot} 
       title="{$titolo}" 
       data-description="{$caption} {$credits}" data-gallery
    {else}
        href={$node.url_alias|ezurl()} onclick="event.stopPropagation();"
    {/if}
        >
        {attribute_view_gui attribute=$item|attribute('image') image_class=$thumbnail_class fluid=$fluid}
    </a>
    
    {if $can_edit}</div> {/if}
    
    {/foreach}
</div>
{undef $caption}
{undef $credits}
{undef $titolo}  

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
    bottom:0px;
    width:100%;    
    color: #fff;    
    font-size: 20px;
    line-height: 30px;
    color: #fff;
    text-shadow: 0 0 2px #000;
    opacity: 0.8;
    text-align: left;
    display: none;
  }
  .blueimp-gallery-controls > .description, .blueimp-gallery-controls > .example {
    display: block;
  }
</style>

<script>

   document.getElementById('galleryBlueimp{/literal}{$node_id}{literal}').onclick = function (event) {
    event = event || window.event;
    
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
                    node[0].appendChild(boldHTML(text));
                    node[0].appendChild(italicHTML(text));
                }
                console.log(index);               
            };
        initializeAdditional(index, 'data-description', '.description', self);
        initializeAdditional(index, 'data-example', '.example', self);
        
        // Allineamento didascalia
        var img_src = self.list[index];
        var img = new Image();
        img.src = img_src;
        
        img.onload = function() {
            var captionMargin = ($(window).width()-this.width)/2.0;
            var captionBottom = (($(window).height()-this.height)/2.0)-50;
            
            if(captionBottom >= 0){
                $(".blueimp-gallery > .description, .blueimp-gallery > .example").css('margin-left',captionMargin+'px');
                $(".blueimp-gallery > .description, .blueimp-gallery > .example").css('bottom',captionBottom+'px');
                
                $(".blueimp-gallery-controls > .title").css('top',captionBottom+'px');
                $(".blueimp-gallery-controls > .title").css('margin-left',captionMargin+'px');
                $(".blueimp-gallery-controls > .title").css('left','0px');
            }
            else{
                $(".blueimp-gallery > .description, .blueimp-gallery > .example").css('text-align', 'center');
            }
            console.log('image width: ' + this.width);
        };
        
      }
    },
    links = this.getElementsByTagName('a');
        
    blueimp.Gallery(links, options);
    };

    function italicHTML(text) {
        var posX = text.indexOf('####');       
        if(posX > 0){            
            var res = text.split("####");
            text = res[1];            
        }    
        else
            text = '';
        
        var element = document.createElement("i");
        element.innerHTML = text;
        return element;
    }
    function boldHTML(text) {
        var posX = text.indexOf('####');       
        if(posX > 0){            
            var res = text.split("####");
            text = res[0];            
        }          
        var element = document.createElement("x");
        element.innerHTML = text;
        return element;
    }
    
</script>
{/literal}