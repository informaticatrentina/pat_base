{* :: INFOTN :: *}

<div class="row">
    <div class="col-md-2">
        {attribute_view_gui attribute=$nodechild|attribute('icona') image_class='infoboximage'}
    </div>

    <div class="col-md-10">
        {if $current_user.is_logged_in}
            <a href={$nodechild.url_alias|ezurl()}>
        {/if}
            <h3>
                {$nodechild.name|wash()}

                <small>
                    {if $nodechild|has_attribute('versione')}
                        {attribute_view_gui attribute=$nodechild|attribute('versione')}
                    {/if}
                </small>
            </h3>
        {if $current_user.is_logged_in}   
            </a>
        {/if}

        <p class="text-justify">
            {attribute_view_gui attribute=$nodechild|attribute('descrizione')}
        </p>
        
        {if $nodechild|has_attribute('link')}
            <p>
                {*attribute_view_gui attribute=$nodechild|attribute('link')*}
                {include uri='design:atoms/link.tpl' link=$nodechild|attribute( 'link' )}
            </p>
        {/if}
        
        {if $nodechild|has_attribute('file')}
            <p>{include uri='design:atoms/file.tpl' size=btn-xs file=$nodechild|attribute( 'file' )}</p>
        {/if}
        
        {if $nodechild|has_attribute('data_aggiornamento')}
            <p>
                <small>
                    Aggiornato al:
                    {attribute_view_gui attribute=$nodechild|attribute('data_aggiornamento')}
                </small>
            </p>
        {/if}
    </div>
</div>

{*---LINEA DI SEPARAZIONE---*}
<div class="row"><div class="col-sm-12"><hr></div></div>