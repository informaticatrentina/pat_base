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
            {attribute_view_gui attribute=$node|attribute('testo')}
        {/if}
    </div>
    <div class="content-related">
        <h2>
            <i class="fa fa-info"></i>
            {"Info"|i18n('design/itbase_v2/provvedimenti')}
        </h2>
        {def $curRiservato = $node.data_map.riservato.content}
        {if eq( $curRiservato , '1')} 
            <div class="message-error">{"ReservedAct"|i18n('design/itbase_v2/provvedimenti')}</div>
        {/if}  
        <ul class="list-unstyled">
            {if $node|has_attribute('struttura_competente')}
                <li>
                    <b>{"organizationAct"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('struttura_competente')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('competenza')}
                <li>
                    <b>{"Competence"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('competenza')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('numero')}
                <li>
                    <b>{"ActNumber"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('numero')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('anno')}
                <li>
                    <b>{"ActYear"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('anno')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('data')}
                <li>
                    <b>{"ActIniDate"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('data')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('data_pubblicazione')}
                <li>
                    <b>{"ActPublishedDate"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('data_pubblicazione')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute('proponente')}
                <li>
                    <b>{"proponent"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('proponente')}
                    </p>
                </li>
            {/if}    
            
            {if $node|has_attribute('classificazione_tipologia')}
                <li>
                    <b>{"classificationType"|i18n('design/itbase_v2/provvedimenti')}</b>
                    <p>
                        {attribute_view_gui attribute=$node|attribute('classificazione_tipologia')}
                    </p>
                </li>
            {/if}
            {if $node|has_attribute( 'tematica' )}
                <li>
                   <h2><i class="fa fa-tags"></i> {"issues"|i18n('design/itbase_v2/provvedimenti')}</h2>
                   {attribute_view_gui attribute=$node|attribute( 'tematica' )}
               </li>
            {/if}
             {if $node|has_attribute('link_al_provvedimento')}
                <h2>
                <i class="fa fa-file-text"></i>
                {"Document"|i18n('design/itbase_v2/provvedimenti')}
                </h2>
                <li>
                    <p>
                        <a class="fa fa-external-link" target="_blank" href="{$node|attribute('link_al_provvedimento').content}" >
                         {"source"|i18n('design/itbase_v2/provvedimenti')} 
                       </a> 
                    </p>
                    
                </li>
            {/if}
            {if $node|has_attribute('link_al_pdf')}
                 <li>
                   {if eq( $curRiservato , '0')} 
                    <p>
                        <a class="fa fa-file-pdf-o" target="_blank" href="{$node|attribute('link_al_pdf').content}" >
                         {"download"|i18n('design/itbase_v2/provvedimenti')}  
                       </a> 
                    </p>
                    {/if}
                </li>
            {/if}
            <li>
                <h2>
                <i class="fa fa-file-text"></i>
                {"attachments"|i18n('design/itbase_v2/provvedimenti')}  
                </h2>
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
                     {"anyAttachments"|i18n('design/itbase_v2/provvedimenti')}
                </p>
                {/if}
            </li>
        </ul>
    </div>
</div>