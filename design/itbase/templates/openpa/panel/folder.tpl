<div class="media-panel card-material">
    
  {if $node|has_attribute('image')}
      <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
        <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>
      </a>
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}">    
    <div class="caption">
        {if and(is_set($show_childs), $show_childs|eq('yes'))|not }
          <h4 class="fw_medium color_dark">
              <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
                    {$node.name|openpa_shorten(60)|wash()}
              </a>
          </h4>
        {/if}
      {if or(is_set($show_abstract)|not, $show_abstract|eq('yes'))}
            <p class="abstract">
                {$node|attribute('short_name').data_text|wash()}
            </p>
      {/if}
      
      {* Children *}
      {if and(is_set($show_childs), $show_childs|eq('yes'))}
          <p>
              {attribute_view_gui attribute=$node|attribute('description')}
          </p>
          
          {def $children_count = fetch( openpa, 'list_count', hash( 'parent_node_id', $node.node_id ) )
               $children       = fetch( openpa, 'list', hash( 'parent_node_id', $node.node_id
                                                            , 'sort_by', $node.sort_array
                                                            , 'limit', $childs_limit) ) }
                                                               
                                                               
            {if $children_count}
                {foreach $children as $child}
                    {node_view_gui content_node=$child view=line}
                {/foreach}
            {/if}
            <br/>
            {if and(is_set($childs_limit), $childs_limit|ne(''))}
                <div class='text-right' style="margin-top: 5px;">
                    <a class="btn btn-sm btn-primary" href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
                        {'Show all'|i18n('design/pat_base/generic')}...
                    </a>
                </div>
            {/if}
      {/if}
      
      {*
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Leggi</a>
      </p>
      *}
    </div>
  </div>
</div>