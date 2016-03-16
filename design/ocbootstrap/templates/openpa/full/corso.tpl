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

        {*include uri=$openpa.content_detail.template}

        {include uri=$openpa.content_infocollection.template*}

		
		<h3>Edizioni</h3>
		{def $parameters = hash(
		  'subtree', array( $node.node_id ),
		  'classes', array( 'edizione' ),
		  'class_names', array( "Edizione corso di formazione" ),
		  'fields', array( 'name_t', 'attr_from_time_dt', 'attr_quota_t', 'attr_stato_iscrizioni_t', 'main_url_alias_ms' ),
		  'keys', array( "Edizione", "Data", "Quota", "Stato iscrizioni" ),
		  'filters', array( concat( '-meta_id_si:', $node.contentobject_id ) ),
		  'table_id', concat( 'childOf-', $node.node_id ),
		)}
		
		<div class='row'>
		  <div class='col-sm-12'>
			  {include uri='design:datatable/view.tpl'
					   subtree=$parameters.subtree
					   classes=$parameters.classes
					   class_names=$parameters.class_names
					   fields=$parameters.fields
					   keys=$parameters.keys
					   filters=$parameters.filters
					   table_id=$parameters.table_id} 
		  </div>
		</div>

        {if $openpa.content_date.show_date}
            <p class="pull-right">{include uri=$openpa.content_date.template}</p>
        {/if}
    </div>

</div>


{if $openpa.content_date.show_date}
  <div class="row"><div class="col-md-12">
    <p class="pull-right">{include uri=$openpa.content_date.template}</p>
  </div></div>
{/if}