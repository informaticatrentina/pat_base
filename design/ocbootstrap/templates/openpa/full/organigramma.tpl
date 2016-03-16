{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">

        {include uri=$openpa.content_main.template}

        <ul class="org-chart">
          <li>
            <div class="vcard">{ezini( 'SiteSettings', 'SiteName' )}</div>
        
        {def $OrganigrammaCustomNodes = openpaini( 'Nodi', 'OrganigrammaCustomNodes', array() )
             $ServiziIndipendenti = openpaini( 'Nodi', 'ServiziIndipendenti' )
             $Aree = openpaini( 'Nodi', 'Aree' )
             $children=''
             $servizi_area=''}
        
        {if count( $OrganigrammaCustomNodes )|gt(0)}
          <ul>
          {foreach $OrganigrammaCustomNodes as $OrganigrammaCustomNodeId }
            <li>
              <div class="vcard">{node_view_gui view='toolline' content_node=fetch( content, node, hash( node_id, $OrganigrammaCustomNodeId ) )}</div>            
            </li>
          {/foreach}
          </ul>
        {/if}
        
        {if $ServiziIndipendenti}
          {set $children=fetch('content', 'list',hash('parent_node_id', $ServiziIndipendenti, 
                                                      'class_filter_type', 'include',
                                                      'class_filter_array', array('servizio'), 
                                                      'sort_by', array('priority', true()) ))}
          {if $children|count()|gt(0)}
              <ul>
              {foreach $children as $child }
                  <li>
                      <div class="vcard">{node_view_gui view='toolline' content_node=$child.object.main_node}</div>
                      {include node=$child title=false() title=false() icon=false() uri='design:parts/articolazioni_interne.tpl'}
                  </li>
              {/foreach}
              </ul>
          {/if}
        {/if}
        
        {if $Aree}
          {set $children=fetch('content', 'list',hash('parent_node_id', $Aree,
                                                      'class_filter_type', 'include',
                                                      'class_filter_array', array('servizio'), 
                                                      'sort_by', array('priority', true())  ))}
          {if $children|count()|gt(0)}
              <ul>
              {foreach $children as $child }
                  <li>
                      <div class="vcard">{node_view_gui view='toolline' content_node=$child}</div>
                      {include node=$child title=false() icon=false() no_servizi=true uri='design:parts/articolazioni_interne.tpl'}
                      {set $servizi_area=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $child.contentobject_id,
                                                                                          'attribute_identifier', 'servizio/area',
                                                                                          'sort_by', array('name', true())))}
                      {if count($servizi_area)|gt(0)}        
                          <ul class="servizio_area">
                              {foreach $servizi_area as $servizio}
                                  {if $servizio.id|ne($child.contentobject_id)}
                                      {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array() )|contains($servizio.section_id)}
                                          <li>
                                              <div class="vcard">{node_view_gui view='toolline' content_node=$servizio.main_node}</div>
                                              {include node=$servizio.main_node title=false() icon=false() uri='design:parts/articolazioni_interne.tpl'}
                                          </li>
                                      {/if}
                                  {/if}
                              {/foreach}
                          </ul>    
                      {/if}
                  </li>
              {/foreach}
              </ul>
          {/if}
        {/if}

          </li>
        </ul>

    </div>

    {if $openpa.control_menu.show_extra_menu}
      {include uri='design:openpa/full/parts/section_right.tpl'}
    {/if}

</div>
