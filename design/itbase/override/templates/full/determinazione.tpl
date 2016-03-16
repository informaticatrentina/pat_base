<div class="content-view-full row">
    <div class="content-title">
        <h1>
            {$node.name|wash()}
        </h1>
    </div>
    <div class="content-main">
        {if $node|has_attribute('oggetto')}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute('oggetto')}
            </div>
        {/if}
        {if $node|has_attribute('testo')}
            <div class="well small">
                {attribute_view_gui attribute=$node|attribute('testo')}
            </div>
        {/if}
    </div>
    <div class="content-related">
        <h2>
            <i class="fa fa-info"></i>
            Informazioni
        </h2>
        {def $curRiservato = $node.data_map.riservato.content}
        {if eq( $curRiservato , '1')} 
            <div class="message-error">Documento Riservato</div>
        {/if} 
        <ul class="list-unstyled">
            {if $node|has_attribute('struttura_competente')}
                <li>
                    <b>Struttura competente</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('struttura_competente')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('competenza')}
                <li>
                    <b>Competenza</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('competenza')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('numero')}
                <li>
                    <b>Numero della delibera</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('numero')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('anno')}
                <li>
                    <b>Anno della delibera</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('anno')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('data')}
                <li>
                    <b>Data di adozione</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('data')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('data_pubblicazione')}
                <li>
                    <b>Data di pubblicazione</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('data_pubblicazione')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('proponente')}
                <li>
                    <b>Proponente</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('proponente')}
                    </p>
                </li>
            {/if}            
            {*
            {if $node|has_attribute('riferimento')}
                <li>
                    <b>Riferimento</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('riferimento')}
                    </p>
                </li>
            {/if}
            *}
            {if $node|has_attribute('classificazione_tipologia')}
                <li>
                    <b>Classificazione tipologia</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('classificazione_tipologia')}
                    </p>
                </li>
            {/if}
            
            {if $node|has_attribute('link_al_provvedimento')}
                <li>
                    <p>
                        <a class="fa fa-external-link" target="_blank" href="{$node|attribute('link_al_provvedimento').content}" >
                         Originale
                       </a> 
                    </p>
                    
                </li>
            {/if}
            {if $node|has_attribute('link_al_pdf')}
                 <li>
                    {if eq( $curRiservato , '0')} 
                    <p>
                        <a class="fa fa-file-pdf-o" target="_blank" href="{$node|attribute('link_al_pdf').content}" >
                         Download
                       </a> 
                    </p>
                    {/if}
                </li>
            {/if}
            <li>
                <b>Allegati</b>
                {if $node|has_attribute('allegati')}
                
                        {def $curAllegati = $node|attribute('allegati').content}
                        {def $curList=$curAllegati|explode('$')}
                        {foreach $curList as $object}
                            {if $object}
                                {def $curHref=$object|explode('|')}
                                <p><a class="fa fa-file-pdf-o" href="{$curHref[1]}" >
                                {$curHref[0]}</a></p>
                             {/if}                       
                        {/foreach}
                {else}
                <p>
                    Nessun Allegato
                </p>
                {/if}
            </li>
    
        </ul>
    </div>
</div>