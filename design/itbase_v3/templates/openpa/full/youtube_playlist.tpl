{def $openpa = object_handler($node)}
{*if $openpa.content_tools.editor_tools}
  {include uri=$openpa.content_tools.template}
{/if*}

<div class="content-view-full class-video_playlist row childs-container">

  <div class="content-main wide">
      <div class="content-title">
        <h1>{$node.name|wash()}</h1>
      </div>

    {if $node.data_map.abstract.has_content}
        <div class="attribute-short float-break">
            {attribute_view_gui attribute=$node.data_map.abstract}
        </div>
    {/if}

    {if $node.object.data_map.description.has_content}
      <div class="attribute-long float-break">
        {attribute_view_gui attribute=$node.data_map.description}
      </div>
    {/if}

    {include uri='design:parts/children/panels.tpl' col_width=4 modulo=3}
    
  </div>
</div>
