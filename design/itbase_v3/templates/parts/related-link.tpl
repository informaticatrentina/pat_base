{set_defaults( hash(
    'attribute_name', 'link',
))}

{if $node|has_attribute( $attribute_name )}
    {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
        {foreach $row.columns as $index => $column}
            {if $column|ne('')}
                {set $matrix_link_has_content = true()}
            {/if}
        {/foreach}
    {/foreach}
    {if $matrix_link_has_content}
        <div class="related-panel">
            <div class="row">
                <div class="col-xs-8">
                    <h3>link</h3>
                </div>
                <div class="col-xs-4 text-right">
                    <span class="fa-stack fa-3x related-icon">
                        <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                        <i class="fa fa-link fa-stack-1x"></i>
                    </span>
                </div>
            </div>

            {attribute_view_gui attribute=$node|attribute( $attribute_name )}
        </div>
    {/if}
{/if}