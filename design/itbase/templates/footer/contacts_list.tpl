{def $contacts_list = footer('footer_contacts')}

<ul class="list-unstyled vertical_list">
    {if is_set($contacts_list.telefono)}
        <li>
            <a href="tel:{$contacts_list.telefono}">
                <i class="fa fa-phone-square"></i>
                {$contacts_list.telefono}
            </a>
        </li>
    {/if}
    {if is_set($contacts_list.fax)}
        <li>
            <a href="tel:{$contacts_list.fax}">
                <i class="fa fa-fax"></i>
                {$contacts_list.fax}
            </a>
        </li>
    {/if}
    {if is_set($contacts_list.email)}
        <li>
            <a href="tel:{$contacts_list.email}">
                <i class="fa fa-envelope-o"></i>
                {$contacts_list.email}
            </a>
        </li>
    {/if}
    {if is_set($contacts_list.pec)}
        <li>
            <a href="tel:{$contacts_list.pec}">
                <i class="fa fa-envelope"></i>
                {$contacts_list.pec}
            </a>
        </li>
    {/if}
    {if is_set($contacts_list.indirizzo)}
        <li>
            <a href="http://maps.google.com/maps?q={$contacts_list.indirizzo|urlencode}">
                <i class="fa fa-building"></i>
                {$contacts_list.indirizzo}
            </a>
        </li>
    {/if}
    {if is_set($contacts_list.web)}
        <li>
            <a href="{$contacts_list.web}">
                <i class="fa fa-link"></i>
                {def $linkParts = $contacts_list.web|explode('//')}
                {if is_set( $linkParts[1] )}
                    {$linkParts[1]}
                {/if}
            </a>
        </li>
    {/if}
</ul>