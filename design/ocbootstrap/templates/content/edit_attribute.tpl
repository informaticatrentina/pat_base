{default $view_parameters            = array()
         $attribute_categorys        = ezini( 'ClassAttributeSettings', 'CategoryList', 'content.ini' )
         $attribute_default_category = ezini( 'ClassAttributeSettings', 'DefaultCategory', 'content.ini' )}

{def $count = 0}
{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
	{if $attribute_group|ne('hidden')}
		{set $count = $count|inc()}
	{/if}
{/foreach}
{def $chkNoteditableTab = 0}
{if $count|gt(1)}
	{set $count = 0}
	<ul class="nav nav-tabs">
	{set $count = 0}
	{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
            
		{if $attribute_group|ne('noteditable')}
			<li class="{if $count|eq(0)} active{/if}">
				<a data-toggle="tab" href="#attribute-group-{$attribute_group}">{$attribute_categorys[$attribute_group]}</a>
			</li>
			{set $count = $count|inc()}
                {else}
                    {def $chkNoteditableTab = 1}
		{/if}
	{/foreach}
        
	<li class="pull-right"><a data-toggle="tab" href="#contentactions">Informazioni generali</a></li>
	</ul>
{/if}

<div class="tab-content">
{set $count = 0}
{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
	<div class="clearfix attribute-edit tab-pane{if $count|eq($chkNoteditableTab)} active{/if}" id="attribute-group-{$attribute_group}">
            
	{set $count = $count|inc()}
        
        {foreach $content_attributes_grouped as $attribute_identifier => $attribute}
                
            {if $attribute_group|ne('noteditable')}

                    {def $contentclass_attribute = $attribute.contentclass_attribute}
                    <div class="row edit-row ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute_identifier}">
                    {* Show view GUI if we can't edit, otherwise: show edit GUI. *}
                    {if and( eq( $attribute.can_translate, 0 ), ne( $object.initial_language_code, $attribute.language_code ) )}
                        <div class="col-md-3">
                          <p>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                            {if $attribute.can_translate|not} <span class="nontranslatable">({'not translatable'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
                            {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                          </p>
                        </div>
                        <div class="col-md-9"> 
                          {if $is_translating_content}
                            <div class="original">
                            {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                            </div>
                          {else}
                            {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                          {/if}
                        </div>
                    {else}
                        {if $is_translating_content}
                            <div class="col-md-3">
                              <p{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                  {if $attribute.is_required} <span class="required" title="{'required'|i18n( 'design/admin/content/edit_attribute' )}">*</span>{/if}
                                  {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
                                  {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                              </p>
                            </div>
                            <div class="col-md-9">
                                <div class="well well-sm">
                                  {attribute_view_gui attribute_base=$attribute_base attribute=$from_content_attributes_grouped_data_map[$attribute_group][$attribute_identifier] view_parameters=$view_parameters image_class=medium}
                                </div>
                                <div>
                                  {if $attribute.display_info.edit.grouped_input}
                                      <fieldset>
                                      {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='form-control'}
                                      <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                      </fieldset>
                                  {else}
                                      {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='form-control'}
                                      <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                  {/if}
                                </div>
                            </div>
                        {else}
                            {if $attribute.display_info.edit.grouped_input}
                                <div class="col-md-3">
                                    <p{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                        {if $attribute.is_required} <span class="required" title="{'required'|i18n( 'design/admin/content/edit_attribute' )}">*</span>{/if}
                                        {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}                    
                                    </p>
                                </div>
                                <div class="col-md-9">
                                    {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                                    {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='form-control'}
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                </div>
                            {else}
                                <div class="col-md-3">
                                    <p{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                        {if $attribute.is_required} <span class="required" title="{'required'|i18n( 'design/admin/content/edit_attribute' )}">*</span>{/if}
                                        {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}                    
                                    </p>
                                </div>
                                <div class="col-md-9">
                                    {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                                    {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='form-control'}
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                </div>
                            {/if}
                        {/if}
                    {/if}
                    </div>
                    {undef $contentclass_attribute}           
            {else}
               
                {def $curDataType = ''}
                {def $curArySubFix = ''}
                {def $attributeContent = ''}
                {switch match=$attribute.data_type_string}
                    {case match='eztext'} 
                       
                        {def $curDataType = 'data_text'}
                        {def $attributeid = $attribute.id}
                        {def $attributeContent = $attribute.content|wash}
                        <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}" 
                            value="{$attributeContent}" />
                    {/case}
                    {case match='ezinteger'}
                        {def $curDataType = 'data_integer'}   
                        {def $attributeContent = $attribute.content|wash}
                        <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}" 
                            value="{$attributeContent}" />
                    {/case}
                    {case match='ezstring'}
                        {def $curDataType = 'data_text'}   
                        {def $attributeContent = $attribute.content|wash}
                         <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}" 
                            value="{$attributeContent}" />
                    {/case}
                    {case match='ezxmltext'}
                        {def $curDataType = 'data_text'}   
                        {def $attributeContent = $attribute.data_text|wash}
                         <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}" 
                            value="{$attributeContent}" />
                        {/case}
                    {case match='ezurl'}
                        {def $curDataType = 'ezurl_text'}   
                        {def $attributeContent = $attribute.data_text|wash}
                         <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}" 
                            value="{$attributeContent}" />
                        {def $curDataType = 'ezurl_url'}   
                        {def $attributeContent = $attribute.content|wash( xhtml )}
                         <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}" 
                            value="{$attributeContent}" />
                    {/case}
                    
                    {case match='ezobjectrelationlist'}
                        {def $curArySubFix ='[]'}
                        {def $curDataType = 'data_object_relation_list'}    
                        {def $related_object = fetch( 'content', 'related_objects', hash( 'object_id', $attribute.contentobject_id , 'all_relations', true() ))}
                        
                        {def $attributeContent = $related_object[0].id}
                        <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}{$curArySubFix}" 
                            value="{$attributeContent}" />
                        {*$related_object|attribute( 'show' )*}
                    {/case}
                    {case match='ezselection'}
                        {def $curDataType = 'ezselect_selected_array'}                        
                        {def $attributeContent = $attribute.content[0]|wash}
                        {def $curArySubFix ='[]'} 
                        <input 
                            type="hidden" 
                            name="{$attribute_base}_{$curDataType}_{$attribute.id}{$curArySubFix}" 
                            value="{$attributeContent}" />
                   {/case}   
                   {case match='ezdate'}  
                        
                         <input 
                            type="hidden" 
                            name="{$attribute_base}_date_day_{$attribute.id}{$curArySubFix}" 
                            value="{$attribute.content.day|wash}" />
                          <input 
                            type="hidden" 
                            name="{$attribute_base}_date_month_{$attribute.id}{$curArySubFix}" 
                            value="{$attribute.content.month|wash}" />
                           <input 
                            type="hidden" 
                            name="{$attribute_base}_date_year_{$attribute.id}{$curArySubFix}" 
                            value="{$attribute.content.year|wash}" />
                   {/case}
                   
                   
                    {case}
                        <font color='red' >Unidentified data_type:</font>{$attribute.data_type_string}<br />
                    {/case}
                {/switch}
            {*$attribute|attribute( 'show' )*}        
            {/if}                                
        {/foreach}      
        
     
        
        </div>
{/foreach}
    <div class="clearfix attribute-edit tab-pane" id="contentactions">
        {include uri="design:content/edit_right_menu.tpl"}
    </div>
</div>