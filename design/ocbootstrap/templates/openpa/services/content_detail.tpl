{if $openpa.content_detail.has_content}
<div class="content-detail">
{foreach $openpa.content_detail.attributes as $openpa_attribute}
    <div class="row">
        {if $openpa_attribute.full.show_label}
            <div class="col-md-3">
                <strong>{$openpa_attribute.label}</strong>
            </div>
        {/if}
        <div class="col-md-{if $openpa_attribute.full.show_label}9{else}12{/if}">
            {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.full.show_link|not, 'no-link', '')}
        </div>
    </div>
{/foreach}
</div>
{/if}