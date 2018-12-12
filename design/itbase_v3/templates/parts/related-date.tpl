{if $node|has_attribute( 'from_time' )}
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>{"date"|i18n('design/pat_base/generic')}</h3>                  
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-calendar fa-stack-1x"></i>
                </span>
            </div>
        </div>

        <small style="color: #333;">
            {'from'|i18n('design/pat_base/generic')} <b>{$node|attribute( 'from_time' ).content.timestamp|l10n(date)}</b>
            <br/>
            {if $node.data_map.to_time.has_content}
                {'to'|i18n('design/pat_base/generic')} <b>{$node|attribute( 'to_time' ).content.timestamp|l10n(date)}</b>
            {/if}
        </small>
        {if $node|has_attribute('note_orario')}
            <p>
                <small style="color: #333;">
                    {attribute_view_gui attribute=$node|attribute( 'note_orario' )}
                </small>
            </p>
        {/if}
    </div>
{/if}
