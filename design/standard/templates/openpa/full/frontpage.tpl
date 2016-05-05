{* Front page - Full view *}

{if $node.data_map.page.has_content}

  {attribute_view_gui attribute=$node.data_map.page}

{else}

  <div class="content-view-full class-{$node.contentclass_identifier} row">
  {include uri='design:nav/nav-section.tpl'}

  <div class="content-main">

    <h1>{$node.name|wash()}</h1>

    {if $node|has_attribute( 'riferimenti_normativi' )}
      <div class="riferimenti-normativi">
        {attribute_view_gui attribute=$node|attribute( 'riferimenti_normativi' )}
      </div>
    {/if}

    {include uri='design:parts/children.tpl' view='line'}
  </div>

{/if}