     
{set-block scope=root variable=cache_ttl}600{/set-block}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}
                                                 
{* Event - Full view *}                                                 
<div class="content-view-full class-{$node.class_identifier} row">
    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}
           
    <div class="content-main body-gallery">
        <div class="content-title">
            <h1>{$node.name|wash()}</h1>
        </div>
            
        {def $images = array()}
        {foreach $node.data_map.image.content.relation_list as $relation_item}
            {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
        {/foreach}

        {if gt($images|count,0)}    
                {ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
                {ezcss_require( array( 'plugins/owl-carousel/owl.transitions.css' , 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}

                <div id='carousel_{$node.object.id}' class='owl-carousel top-carousel'>
                    {def $caption=''}    
                    {def $credits=''}
                    {foreach $images as $item}
                        {set $caption=''}    
                        {set $credits=''}
                        <div class="item">
                            {if $item|has_attribute( 'caption' )}
                            {set $caption = $item.data_map.caption.data_text|wash()}    
                            {/if}
                            {if $item|has_attribute( 'credits' )}
                                {if $item.data_map.caption.has_content}             
                                    {set $credits = concat( ' - ' ,  $item.data_map.credits.data_text|wash())}
                                {else}
                                    {set $credits = $item.data_map.credits.data_text|wash()}
                                {/if}
                            {/if}
                         
                            
                            {include uri='design:atoms/image.tpl' item=$item image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$caption credits=$credits alignment=center}
                        </div>
                    {/foreach}

                </div>
        {/if}
        
        <div class="short_description">
            {if $node|has_attribute( 'short_description' )}
                     {attribute_view_gui attribute=$node|attribute('short_description')}
            {/if}
        </div>
        <div class="description">
            {if $node|has_attribute( 'description' )}
                     {attribute_view_gui attribute=$node|attribute('description')}
             {/if}
        </div>
    </div>
    <div class="content-related">

        {include uri='design:parts/related-immagini.tpl' can_edit=$can_edit url_alias=$node.url_alias|ezurl(no)}
        {include uri='design:parts/related-script.tpl'}
        
        {*if gt($images|count,0)}
            <div>
                <h2><i class="fa fa-camera"></i> Immagini</h2>
                {include uri='design:atoms/gallery.tpl' items=$images}
            </div>
        {/if*}
    </div> 
</div>
    
<script type="text/javascript">
        $(document).ready(function() {ldelim}
            $("#carousel_{$node.object.id}").owlCarousel({ldelim}
                items : 1,
                itemsDesktop : 1, // items between 1000px and 901px
                itemsDesktopSmall : 1, // betweem 900px and 601px
                itemsTablet: 1, // items between 600 and 0
                itemsMobile: 1,
                navigation: true,
		navigationText: [
                    "<i class='fa fa-angle-left fa-4x'></i>",
                    "<i class='fa fa-angle-right fa-4x'></i>"
                ],
                pagination: false,
                mouseDrag: false,
                {if count($images)|gt(1)}
                transitionStyle: "fade",
                {/if}
                 autoHeight : true
		{rdelim}); 

        {rdelim});
    </script>   
   
    
{literal}
<style>
    div[id|="carousel_{/literal}{$node.object.id}{literal}"] .owl-controls{
       position: absolute;
       width: 99% !important; 
       top: 42% !important; 
   } 
   div[id|="carousel_{/literal}{$node.object.id}{literal}"] .owl-buttons div{ /* left arrow */
       width: 55px; 
       overflow: hidden !important;   
       margin: 0 !important;
       float: left;    
      
       background:none !important; 
   } 
   div[id|="carousel_{/literal}{$node.object.id}{literal}"] .owl-buttons .owl-next{ /* right arrow */
       float: right;   
      
   }

      div[id|="carousel_{/literal}{$node.object.id}{literal}"] > div:hover + div {
          color: white !important;
      }
      div[id|="carousel_{/literal}{$node.object.id}{literal}"] > div:hover + div { 
          color: white !important;
      }
 </style>
 {/literal}
