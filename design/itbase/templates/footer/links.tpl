<ul class="list-unstyled vertical_list">
    {def $footer_links = footer('footer_links')}
    {foreach $footer_links as $link}
        <li>
            <a href={$link.data_map.location.content}>
                {$link.data_map.name.content}
                <i class="fa fa-angle-right"></i>
            </a>
        </li>
    {/foreach}
    {def $fedAuthFooterLink = ezini( 'FedAuth', 'HideFooterLink', 'browse.ini' )}
    {if $fedAuthFooterLink|ne('True')}
    <li>
        <a href={'ocfedauth/fedrequest'|ezurl()}>
            Autenticazione federata
            <i class="fa fa-external-link"></i>
        </a>
    </li>
    {/if}
</ul>
