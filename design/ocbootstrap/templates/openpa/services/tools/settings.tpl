{def $isHideTopMenu = openpaini( 'TopMenu', 'NascondiNodi', array() )|contains( $node.node_id )
	 $canHideInTopMenu = and( openpaini( 'TopMenu', 'IdentificatoriMenu', array() )|contains( $node.class_identifier ), $node.depth|le(4) )
	 $isHideSideMenu = openpaini( 'SideMenu', 'NascondiNodi', array() )|contains( $node.node_id )
	 $canHideInSideMenu = and( openpaini( 'SideMenu', 'IdentificatoriMenu', array() )|contains( $node.class_identifier ), $node.depth|le(4) )
   $ignoreVirtual = openpaini( 'Menu', 'IgnoraVirtualizzazioneNodi', array() )|contains( $node.node_id )}

<div class="alert alert-warning">
  <strong>Attenzione: </strong> per visualizzare le modifiche è necessario rigenerare i menu
</div>

<p>  
  {if and( $canHideInTopMenu, $isHideTopMenu|not() )}
	<a class="btn btn-sm btn-danger" href="{concat('openpa/settings/hide_in_topmenu/',$node.node_id)|ezurl(no)}">Nascondi dal menu orizzontale</a>
  {/if}
  {if $isHideTopMenu}
	<a class="btn btn-sm btn-success" href="{concat('openpa/settings/show_in_topmenu/',$node.node_id)|ezurl(no)}">Mostra nel menu orizzontale</a>
  {/if}

  {if and( $canHideInSideMenu, $isHideSideMenu|not() )}
	<a class="btn btn-sm btn-danger" href="{concat('openpa/settings/hide_in_sidemenu/',$node.node_id)|ezurl(no)}">Nascondi dal menu laterale</a>
  {/if}
  {if $isHideSideMenu}
	<a class="btn btn-sm btn-success" href="{concat('openpa/settings/show_in_sidemenu/',$node.node_id)|ezurl(no)}">Mostra nel menu laterale</a>
  {/if}
  
  {if $ignoreVirtual}
  {else}
    <a class="btn btn-sm btn-info" href="{concat('openpa/settings/ignore_virtual/',$node.node_id)|ezurl(no)}">Ignora virtualizzazione nel menu</a>
  {/if}
</p>