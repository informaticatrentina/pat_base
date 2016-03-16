{if $openpa.content_contacts.has_content}
<div class="content-detail well m_top_20">
  <div class="row">
        {if $openpa.content_contacts.show_label}
            <div class="col-md-2">
                <strong>{$openpa.content_contacts.label}</strong>
            </div>
        {/if}
        <div class="col-md-{if $openpa.content_contacts.show_label}10{else}12{/if}">
          <ul class="list-unstyled">
          {foreach $openpa.content_contacts.attributes as $openpa_attribute}
            <li>
            {if $openpa_attribute.full.show_label}<strong>{$openpa_attribute.label}: </strong>{/if}
            {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.full.show_link|not, 'no-link', '')}
            </li>
          {/foreach}
          </ul>
        </div>
    </div>
</div>
{/if}