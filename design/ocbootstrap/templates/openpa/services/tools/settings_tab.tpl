{def $isHideTopMenu = openpaini( 'TopMenu', 'NascondiNodi', array() )|contains( $node.node_id )
	 $canHideInTopMenu = and( openpaini( 'TopMenu', 'IdentificatoriMenu', array() )|contains( $node.class_identifier ), $node.depth|le(4) )
	 $isHideSideMenu = openpaini( 'SideMenu', 'NascondiNodi', array() )|contains( $node.node_id )
	 $canHideInSideMenu = and( openpaini( 'SideMenu', 'IdentificatoriMenu', array() )|contains( $node.class_identifier ), $node.depth|le(4) )}
	 
{if or($isHideTopMenu, $canHideInTopMenu, $isHideSideMenu, $canHideInSideMenu)}
<li><a href="#settings" role="tab" data-toggle="tab">Configurazioni</a></li>		
{/if}