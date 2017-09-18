
    <div class="zone-layout-{$zone_layout|downcase()}row">
        <div class="col-lg-8 col-md-8 first_block">
            <section class="content-view-block">
                {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
                {foreach $zones[0].blocks as $block}
                    {include uri='design:parts/zone_block.tpl' zone=$zones[0]}
                {/foreach}
                {/if}
            </section>
        </div>
        <div class="col-lg-4 col-md-4 second_block">
            <aside>
                <section class="content-view-block content-view-aside">
                    {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
                    {foreach $zones[1].blocks as $block}
                        {include uri='design:parts/zone_block.tpl' zone=$zones[1]}
                    {/foreach}
                    {/if}
                </section>
            </aside>
        </div>
        <div class="col-lg-8 col-md-8 third_block">
            <section class="content-view-block">
                {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
                {foreach $zones[2].blocks as $block}
                    {include uri='design:parts/zone_block.tpl' zone=$zones[2]}
                {/foreach}
                {/if}
            </section>
        </div>
        <div class="col-lg-4 col-md-4 fourth_block">
            <aside>
                <section class="content-view-block content-view-aside">
                    {if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
                    {foreach $zones[3].blocks as $block}
                        {include uri='design:parts/zone_block.tpl' zone=$zones[3]}
                    {/foreach}
                    {/if}
                </section>
            </aside>
        </div>
    </div>
            
{literal}
    <script>
        $(document).ready(function(){
            if (window.matchMedia('(min-width: 992px)').matches) {
                var diffHeight = $(".second_block").height() - $(".first_block").height();
                var heightString = '-' + diffHeight + 'px';
                
                $(".third_block").css( { top: heightString } );
                
                
                $('#page').children('.container').each(function () {
                    if( $(this).attr('class') === 'container' ){
                        $(this).height( $(this).height() - diffHeight );
                    }
                });
                
                $('.content-main').height( $('.content-main').height() - diffHeight );
            }
            else{
                console.log( 'mobile!' );
            }
        });
    </script>
{/literal}