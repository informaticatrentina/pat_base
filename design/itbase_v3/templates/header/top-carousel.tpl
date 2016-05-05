{set_defaults( hash(
    'i_view', 'carousel',
    'items', array(),
    'autoplay', 0,
    'items_per_row', 1,
    'image_class', 'carousel_top',
    'navigation', true(),
    'pagination', false(),
    'auto_height', false(),
    'top_pagination_position', false(),
    'navigation_text', concat( "['", '<i class="fa fa-angle-left"></i>', "','", '<i class="fa fa-angle-right"></i>', "']"),
    'css_id', $root_node.node_id,
    'evidenza', false()
))}


{if and( $root_node, $items )}
    {if $root_node}

    {ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
    {ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}

    <div id="carousel_{$css_id}" class="owl-carousel top-carousel">
        {foreach $items as $item}
            <div class="item" style='background-image: url({include uri='design:header/top-image.tpl' node=$item image_class=$image_class});'>
                {*Caption*}
                &nbsp;
            </div>
        {/foreach}
    </div>
    
    <script type="text/javascript">
        $(document).ready(function() {ldelim}
            $("#carousel_{$css_id}").owlCarousel({ldelim}
                items : 1,
                itemsDesktop : 1, // items between 1000px and 901px
                itemsDesktopSmall : 1, // betweem 900px and 601px
                itemsTablet: 1, // items between 600 and 0
                itemsMobile: 1, 
                autoPlay: 10000,
                navigation: true,
                navigationText: [
                    "<i class='fa fa-angle-left fa-5x'></i>",
                    "<i class='fa fa-angle-right fa-5x'></i>"
                ],
                pagination: false,
                mouseDrag: false
                {rdelim});
            {rdelim});
    </script>
    {/if}
{/if}

{unset_defaults( array('i_view','items','autoplay','items_per_row', 'image_class','navigation','pagination','navigation_text','css_id'))}
