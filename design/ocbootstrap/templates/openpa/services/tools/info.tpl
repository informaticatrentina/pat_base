<dl class="dl-horizontal">

  <dt>Ultima modifica di:</dt>
  <dd>
	{if $node.creator.main_node}
	<a href={$node.creator.main_node.url_alias|ezurl}>{$node.creator.name}</a> il {$node.object.modified|l10n(shortdatetime)}
	{else}
	?
	{/if}
  </dd>

  <dt>Creato da:</dt>
  <dd>
	{if and( $node.object.owner, $node.object.owner.main_node )}
	<a href={$node.object.owner.main_node.url_alias|ezurl}>{$node.object.owner.name}</a> il {$node.object.published|l10n(shortdatetime)}
	{else}
	?
	{/if}
  </dd>

  <dt>Nodo:</dt>
  <dd>{$node.node_id}</dd>

  <dt>Oggetto</dt>
  <dd>{$node.contentobject_id} ({$node.object.remote_id})</dd>
  
  <dt>Collocazioni:</dt>
  <dd>
    <ul class="list-unstyled">
    {foreach $node.object.assigned_nodes as $item}
      <li><a href={$item.url_alias|ezurl()}>{$item.path_with_names}</a> {if $item.node_id|eq($node.object.main_node_id)}(principale){/if}</li>
    {/foreach}
    </ul>
  </dd>  

  {def $sezione = fetch( 'section', 'object', hash( 'section_id', $node.object.section_id ))}
  <dt>Sezione: </dt>
  <dd>
    {if $node.can_edit}
      <form action={concat('content/edit/', $node.contentobject_id)|ezurl()} method="post">
      {def $sections=$node.object.allowed_assign_section_list $currentSectionName='unknown'}
      {foreach $sections as $sectionItem }
          {if eq( $sectionItem.id, $node.object.section_id )}
              {set $currentSectionName=$sectionItem.name}
          {/if}
      {/foreach}
      {undef $currentSectionName}
      <select id="SelectedSectionId" name="SelectedSectionId">
      {foreach $sections as $section}
          {if eq( $section.id, $node.object.section_id )}
          <option value="{$section.id}" selected="selected">{$section.name|wash}</option>
          {else}
          <option value="{$section.id}">{$section.name|wash}</option>
          {/if}
      {/foreach}
      </select>
      <input type="submit" value="{'Set'|i18n( 'design/admin/node/view/full' )}" name="SectionEditButton" class="button btn btn-xs" />
      <input type="hidden" value="{$node.url_alias}" name="RedirectRelativeURI">
      <input type="hidden" value="1" name="ChangeSectionOnly">
      </form>
    {else}
      {$sezione.name|wash}
    {/if}
  </dd>

  <dt>Tipo: </dt>
  <dd><a target="_blank" href="{concat('openpa/classes/', $node.class_identifier)|ezurl(no)}">{$node.class_name} ({$node.class_identifier} {$node.object.contentclass_id})</a></dd>

  {if $openpa.content_virtual.folder}
	  <dt>Folder virtuale:</dt>
	  <dd>
		  {$openpa.content_virtual.folder.classes|implode(', ')}
		  ({foreach $openpa.content_virtual.folder.subtree as $node_id}<a href="{concat( 'content/view/full/', $node_id)|ezurl(no)}">{$node_id}</a>{delimiter}, {/delimiter}{/foreach})
	  </dd>
  {/if}

  {if $openpa.content_virtual.calendar}
	  <dt>Calendario virtuale:</dt>
	  <dd>
		  ({foreach $openpa.content_virtual.calendar.subtree as $node_id}<a href="{concat( 'content/view/full/', $node_id)|ezurl(no)}">{$node_id}</a>{delimiter}, {/delimiter}{/foreach})
	  </dd>
  {/if}

  {if and( is_set( $node.data_map.data_iniziopubblicazione ), $node.data_map.data_iniziopubblicazione, $node.data_map.data_iniziopubblicazione.has_content, $node.data_map.data_iniziopubblicazione|gt(0) )}
	  <dt>{$node.data_map.data_iniziopubblicazione.contentclass_attribute_name}</dt>
	  <dd>{attribute_view_gui attribute=$node.data_map.data_iniziopubblicazione}</dd>
  {/if}

  {if and( is_set( $node.data_map.data_finepubblicazione ), $node.data_map.data_finepubblicazione, $node.data_map.data_finepubblicazione.has_content, $node.data_map.data_finepubblicazione|gt(0) )}
	  <dt>{$node.data_map.data_finepubblicazione.contentclass_attribute_name}</dt>
	  <dd>{attribute_view_gui attribute=$node.data_map.data_finepubblicazione}</dd>
  {/if}

  {if and( is_set( $node.data_map.data_archiviazione ), $node.data_map.data_archiviazione, $node.data_map.data_archiviazione.has_content, $node.data_map.data_archiviazione|gt(0) )}
	  <dt>{$node.data_map.data_archiviazione.contentclass_attribute_name}</dt>
	  <dd>{attribute_view_gui attribute=$node.data_map.data_archiviazione}</dd>
  {/if}

  {def $states = $node.object.allowed_assign_state_list}
  {if $states|count}
	  <dt>Stati:</dt>
	  <dd>
      {*if $node.can_edit}
        {def $enable_StateEditButton = false()}      
        {foreach $node.object.allowed_assign_state_list as $allowed_assign_state_info}
        <div class="block">
            <label for="SelectedStateIDList">{$allowed_assign_state_info.group.current_translation.name|wash}</label>
            <select id="SelectedStateIDList" name="SelectedStateIDList[]" {if $allowed_assign_state_info.states|count|eq(1)}disabled="disabled"{/if}>
            {if $allowed_assign_state_info.states}
                {set $enable_StateEditButton = true()}
            {/if}
            {foreach $allowed_assign_state_info.states as $state}
                <option value="{$state.id}" {if $node.object.state_id_array|contains($state.id)}selected="selected"{/if}>{$state.current_translation.name|wash}</option>
            {/foreach}
            </select>
        </div>
        {/foreach}      
        {if $enable_StateEditButton}
            <input type="submit" value="{'Set'|i18n( 'design/admin/node/view/full' )}" name="StateEditButton" class="button btn btn-xs" />      
        {/if}
      {else*}
        {foreach $states as $allowed_assign_state_info}{foreach $allowed_assign_state_info.states as $state}{if $node.object.state_id_array|contains($state.id)}{$allowed_assign_state_info.group.current_translation.name|wash()}/{$state.current_translation.name|wash}{/if}{/foreach}{delimiter}, {/delimiter}{/foreach}
      {*/if*}
    </dd>
  {/if}

</dl>

<hr />
<p>
  <a class="btn btn-sm btn-info" href="{concat('index/object/',$node.contentobject_id)|ezurl(no)}">Controlla indicizzazione contenuto</a>
  <a class="btn btn-sm btn-info" href="{concat('content/history/',$node.contentobject_id)|ezurl(no)}">Gestisci versioni</a>  
</p>