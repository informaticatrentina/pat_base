{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $images = array()}
{def $argomenti = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{def $matrix_link_has_content = false()}
{if $node|has_attribute( 'link' )}
    {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
        {foreach $row.columns as $index => $column}
            {if $column|ne('')}
                {set $matrix_link_has_content = true()}
            {/if}
        {/foreach}
    {/foreach}
{/if}

{def $has_sidebar = false()}
{if or(
$node|has_attribute( 'struttura' ),
$node|has_attribute( 'allegati' ),
$node|has_attribute( 'audio' ),
$node|has_attribute( 'fonte' ),
$node|has_attribute( 'geo' ),
gt($images|count,1),
$matrix_link_has_content
)}
    {set $has_sidebar = true()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">
	<div class="content-title">
	</div>
	
	<div class="content-main{if $has_sidebar|not()} wide{/if} body-comunicato">
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-8 col-lg-5">
				{if $node|has_attribute('image')}
					{attribute_view_gui attribute=$node|attribute('image')}
				{else}
					&nbsp;
				{/if}
			</div>
			<div class="col-xs-6 col-md-4 col-lg-7">
				{if and($node|has_attribute('cognome'), $node|has_attribute('nome'))}
					{attribute_view_gui attribute=$node|attribute('cognome')} &nbsp; {attribute_view_gui attribute=$node|attribute('nome')}
				{/if}
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-8 col-lg-5">
				&nbsp;
			</div>
			<div class="col-xs-6 col-md-4 col-lg-7">
				{if $node|has_attribute('telefono')}
					Telefono:&nbsp;{attribute_view_gui attribute=$node|attribute('telefono')}
				{else}
					&nbsp;
				{/if}
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-8 col-lg-5">
				&nbsp;
			</div>
			<div class="col-xs-6 col-md-4 col-lg-7">
				{if $node|has_attribute('email')}
					Email:&nbsp;{attribute_view_gui attribute=$node|attribute('email')}
				{else}
					&nbsp;
				{/if}
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-8 col-lg-5">
				&nbsp;
			</div>
			<div class="col-xs-6 col-md-4 col-lg-7">
				{if $node|has_attribute('curriculum_vitae')}
					{attribute_view_gui attribute=$node|attribute('curriculum_vitae')}
				{else}
					&nbsp;
				{/if}
			</div>
		</div>	
			
			
{*	This code part is completely comment included HTML
		{if $node|has_attribute('cognome')}
			<div class="">			
				{attribute_view_gui attribute=$node|attribute('cognome')}
			</div>
		{/if}
		{if $node|has_attribute('ruolo')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('ruolo')}
			</div>
		{/if}
		{if $node|has_attribute('abstract')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('abstract')}
			</div>
		{/if}
		{if $node|has_attribute('area')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('area')}
			</div>
		{/if}
		{if $node|has_attribute('image')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('image')}
			</div>
		{/if}
		{if $node|has_attribute('area')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('area')}
			</div>
		{/if}
		{if $node|has_attribute('servizio')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('servizio')}
			</div>
		{/if}
		{if $node|has_attribute('ufficio')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('ufficio')}
			</div>
		{/if}
		{if $node|has_attribute('struttura')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('struttura')}
			</div>
		{/if}
		{if $node|has_attribute('userid')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('userid')}
			</div>
		{/if}
		{if $node|has_attribute('telefono')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('telefono')}
			</div>
		{/if}
		{if $node|has_attribute('cellulare')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('cellulare')}
			</div>
		{/if}
		{if $node|has_attribute('fax')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('fax')}
			</div>
		{/if}
		{if $node|has_attribute('email')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('email')}
			</div>
		{/if}
		{if $node|has_attribute('curriculum_vitae')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('curriculum_vitae')}
			</div>
		{/if}
		{if $node|has_attribute('dichiarazione_incompatibilita')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('dichiarazione_imcompatibilita')}
			</div>
		{/if}
		{if $node|has_attribute('incarico_dirigenziale')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('incarico_dirigenziale')}
			</div>
		{/if}
		{if $node|has_attribute('compensi')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('compensi')}
			</div>
		{/if}
		{if $node|has_attribute('atti')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('atti')}
			</div>
		{/if}
		{if $node|has_attribute('atti_testo')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('atti_testo')}
			</div>
		{/if}
		{if $node|has_attribute('matricola')}
			<div class="">
				{attribute_view_gui attribute=$node|attribute('matricola')}
			</div>
		{/if}
*}
		<hr/>{include uri='design:parts/social_buttons.tpl'}
	</div>
</div>