<div class="container">
{include name=Validation uri='design:content/collectedinfo_validation.tpl'
		 class='message-warning'
		 validation=$validation collection_attributes=$collection_attributes}

<form method="post" action={"content/action"|ezurl}>

{foreach $node.object.contentobject_attributes as $attribute}
  {if $attribute.is_information_collector}
  <div class="row attribute-{$attribute.contentclass_attribute_identifier}">                
	 <div class="col-md-4">
	   <p><strong>{$attribute.contentclass_attribute_name}</strong></p>
	 </div>
	 <div class="col-md-8">
	  {attribute_view_gui attribute=$attribute}
	 </div>
  </div>   
  {/if}
{/foreach}

<div class="content-action">
   <input type="submit" class="btn btn-primary btn-large" name="ActionCollectInformation" value="{"Send form"|i18n("design/ezwebin/full/feedback_form")}" />
   <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
   <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
   <input type="hidden" name="ViewMode" value="full" />
</div>
   
</form>