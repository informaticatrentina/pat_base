<ul class="list-unstyled vertical_list">
    {def $footer_banners = footer('footer_banners')}

    {foreach $footer_banners as $banner}
        <li>
            <a href={attribute_view_gui attribute=$banner|attribute('url')}>
                {attribute_view_gui attribute=$banner|attribute('image')}
            </a>
        </li>
    {/foreach}
</ul>