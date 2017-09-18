{def $openpa= object_handler($block)}
{set_defaults(hash('show_title', true()))}
{def $bg_color_is_set = false()} 
{if $block.custom_attributes.bg_color|count_chars()|gt(3)} 
   {set $bg_color_is_set = true()}
{/if}

<div class="widget home_widget card-material lista_carousel"{if is_set($block.custom_attributes.bg_color)}
    style="background-color:{$block.custom_attributes.bg_color} !important"
{/if}>
{if and( $show_title, $block.name|ne('') )}
    <header>
          <div class="widget_title" {if is_set($block.custom_attributes.bg_color)} style="background-color:{$block.custom_attributes.bg_color} !important" {/if}>
            <h1>
                <a href={$openpa.root_node.url_alias|ezurl()}>{$block.name|wash()}</a>
            </h1>
        </div>
    </header>
{/if}
    {def $navigation_text = concat( "['", '<i class="fa fa-angle-left fa-5x"></i>', "','", '<i class="fa fa-angle-right fa-5x"></i>', "']")}
    <div class="{if and( $show_title, $block.name|ne('') )}widget_content {/if}carousel-both-control">
        {include name="carousel"
		 uri='design:atoms/carousel_pat.tpl'
		 items=$openpa.content
		 css_id=$block.id
		 root_node=$openpa.root_node
		 autoplay=10000
		 pagination=false()
		 navigation=true()
                 navigation_text=$navigation_text
		 items_per_row=1}
    </div>
    {undef $navigation_text}

</div>

{unset_defaults(array('show_title'))}