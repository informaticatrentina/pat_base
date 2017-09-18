{def $node=fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}
  
{def $attribute_filter = array( array( 'comunicato/in_punto', "=", "1" ) )} 
{def $ilPunto = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                              'attribute_filter', $attribute_filter,
                                              'sort_by', hash( 'published', 'desc' ) ,

<div class="media-panel">
  {if $ilPunto|has_attribute( 'immagini' )}  
      <figure style="background: url( {fetch('content','node',hash('node_id',$ilPunto.data_map.immagini.content.relation_list[0].node_id))|attribute('image').content.imagefull.full_path|ezroot(no)} )"></figure>
  {/if}

  <div class="media">    
    <div class="caption">
	  <div class="pull-right text-center">

          <img src={'images/il-punto.png'|ezdesign(no)} />
      {*
      <i class="fa fa-coffee fa-3x text-primary"></i>
      <br /><strong class="text-primary">IL PUNTO</strong>
      *}
    </div>
	  <h4 class="fw_medium color_dark">
		<small>{$ilPunto.data_map.data.content.timestamp|l10n('date')}</small><br />
		 {attribute_view_gui attribute=$ilPunto.data_map.titolo}		
	  </h4>
        <small>{$ilPunto.object.published|l10n('shortdate')}</small>
      {attribute_view_gui attribute=$ilPunto.data_map.testo}
    </div>
  </div>
</div>
