{def $_redirect = false()}
{if ezhttp_hasvariable( 'RedirectURIAfterPublish', 'session' )}
    {set $_redirect = ezhttp( 'RedirectURIAfterPublish', 'session' )}
{elseif ezhttp_hasvariable( 'LastAccessesURI', 'session' )}
    {set $_redirect = ezhttp( 'LastAccessesURI', 'session' )}
{elseif $object.main_node_id}
    {set $_redirect = concat( 'content/view/full/', $object.main_node_id )}
{elseif ezhttp( 'url', 'get', true() )}
    {set $_redirect = ezhttp( 'url', 'get' )}
{/if}

{def $tab = ''}
{if and( ezhttp_hasvariable( 'tab', 'get' ), is_set( $view_parameters.tab )|not() )}    
    {set $_redirect = concat( $_redirect, '/(tab)/', ezhttp( 'tab', 'get' ) )}
{/if}

<form class="edit" enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>
    
	{include uri='design:parts/website_toolbar_edit.tpl'}

  {include uri="design:content/edit_validation.tpl"}
    
  <div class='page-header page-header-with-buttons'>
    <span class="btn btn-sm btn-link pull-right">
        {def $language_index = 0
             $from_language_index = 0
             $translation_list = $content_version.translation_list}
    
        {foreach $translation_list as $index => $translation}
           {if eq( $edit_language, $translation.language_code )}
              {set $language_index = $index}
           {/if}
        {/foreach}
    
        {if $is_translating_content}
    
            {def $from_language_object = $object.languages[$from_language]}
    
            {'Translating content from %from_lang to %to_lang'|i18n( 'design/ezwebin/content/edit',, hash(
                '%from_lang', concat( $from_language_object.name, '&nbsp;<img src="', $from_language_object.locale|flag_icon, '" style="vertical-align: middle;" alt="', $from_language_object.locale, '" />' ),
                '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" style="vertical-align: middle;" alt="', $translation_list[$language_index].language_code, '" />' ) ) )}
        {else}
            {'Content in %language'|i18n( 'design/ezwebin/content/edit',, hash( '%language', $translation_list[$language_index].locale.intl_language_name ))}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" style="vertical-align: middle;" alt="{$translation_list[$language_index].language_code}" />
        {/if}
    </span>

      <h1>
        <i class='icon-edit'></i>
        <span>Modifica {$object.name|wash}</span>
        <small>{$class.name|wash}</small>
    </h1>
  </div>
    
  <div class="row">
    <div class="col-md-12">
      {if ezini_hasvariable( 'EditSettings', 'AdditionalTemplates', 'content.ini' )}
        {foreach ezini( 'EditSettings', 'AdditionalTemplates', 'content.ini' ) as $additional_tpl}
          {include uri=concat( 'design:', $additional_tpl )}
        {/foreach}
      {/if}
            
      {include uri="design:content/edit_attribute.tpl"}
    
      {def $draft_button_label = 'Salva bozza'
           $undo_button_label = 'Annulla'}
      
      {if eq( $object.content_class.identifier , 'comunicato')}
            {set $draft_button_label = 'Salva in bozze personali'}
          
            {def $current_version = $object.versions[$object.current.version]}
            
            {if is_set($current_version)}
                {if $current_version.status|eq(0)}
                    {set $undo_button_label = 'Elimina bozza'}
                {/if}
            {/if}
      {/if}

      
      <div class="buttonblock">
          <input class="btn btn-lg btn-success pull-right" type="submit" name="PublishButton" value="Salva" />
          <input class="btn btn-lg btn-warning pull-right" type="submit" name="StoreButton" value="{$draft_button_label}" />
          <input class="btn btn-lg btn-danger" type="submit" name="DiscardButton" value="{$undo_button_label}" />
          <input type="hidden" name="DiscardConfirm" value="0" />
          <input type="hidden" name="RedirectIfDiscarded" value="{if ezhttp_hasvariable( 'RedirectIfDiscarded', 'session' )}{ezhttp( 'RedirectIfDiscarded', 'session' )}{else}{$_redirect}{/if}" />
          <input type="hidden" name="RedirectURIAfterPublish" value="{$_redirect}" />
      </div>
    </div>        
  </div>   


{undef $_redirect}

{run-once}
{literal}
<script>
var select_to_string = function(element , removeArg = false) {

  var newValue = $(element).val();
  var $input = $(element).next();
  if (removeArg == true){   
       $input.val('');
  }
  if (newValue.length > 0) {        
    var current = $input.val().length > 0 ? $input.val().split(',') : [];  
    current.push(newValue);
    function unique(array){
      return array.filter(function(el, index, arr) {
          return index == arr.indexOf(el);
      });
    }
    $input.val(unique(current).join(','));
  }else{
    $input.val('');
  }
}
</script>
{/literal}
{/run-once}
