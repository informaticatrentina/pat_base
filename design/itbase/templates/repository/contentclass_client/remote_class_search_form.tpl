{*
  client OCRepositoryContentClassClient
  class eZContentClass
  sort_form html tpl @todo
  published_form html tpl @todo
*}
<div class="repository_search">
    <form name="{concat('class_search_form_',$client.class.identifier)}" method="get" action="{$form_action}">

        {*include uri='design:class_search_form/query.tpl' client=$client input=$client.query_field*}
        <h4>
            {"Search"|i18n('design/pat_base/generic')} <small>{$client.class.identifier}</small>
        </h4>

        {foreach $attribute_fields as $field}
              {$field}
        {/foreach}

        {*include uri='design:class_search_form/sort.tpl' client=$client input=$client.sort_field}

        {include uri='design:class_search_form/publish_date.tpl' client=$client input=$client.published_field*}

        {foreach $parameters as $key => $value}
              <input type="hidden" name="{$key}" value="{$value}" />
        {/foreach}

        <input type="hidden" name="class_id" value="{$remote_class_id}" />  

        <button class="defaultbutton" type="submit">
            <i class="fa fa-search"></i>
            {'Search'|i18n('design/pat_base/generic')}
        </button>
    </form>
</div>