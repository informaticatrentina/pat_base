{if $openpa.content_infocollection.is_information_collector}
<div class="content-infocollection m_bottom_20">
    {include name=Validation uri='design:content/collectedinfo_validation.tpl'
             class='message-warning'
             validation=$validation
             collection_attributes=$collection_attributes}

    {foreach $openpa.content_infocollection.attributes as $attribute_handler}
        <div class="row m_bottom_20">
            <div class="col-md-3">
                <p class="text-right"><strong>{$attribute_handler.contentclass_attribute.name|wash()}</strong></p>
            </div>
            <div class="col-md-9">
                {attribute_view_gui attribute=$attribute_handler.contentobject_attribute}
            </div>
        </div>
    {/foreach}

    <div class="content-action clearfix">
        <input type="submit" class="btn btn-primary btn-lg pull-right" name="ActionCollectInformation" value="Invia" />
        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
        <input type="hidden" name="ViewMode" value="full" />
    </div>
</div>
{/if}