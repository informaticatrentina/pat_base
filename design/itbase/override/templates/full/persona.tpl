{*$node|attribute('show')*}
<div class="content-view-full class-folder row">
    
    <div class="nav-section">
        {*$node|attribute('show')*}
        
        {if $node.data_map.immagine.has_content}
            {attribute_view_gui attribute=$node|attribute('immagine')}
        {else}
            <span class="fa fa-stack fa-4x">
                <i class="fa fa-square fa-stack-2x"></i>
                <i class="fa fa-user fa-stack-1x fa-inverse"></i>
            </span>
        {/if}
    </div>
    
    <div class="content-main">
        <h4>
            <small>matricola:</small>
            {attribute_view_gui attribute=$node|attribute('matricola')}
        </h4>
        <h2>
            <small>nome e cognome:</small>
            {attribute_view_gui attribute=$node|attribute('nome')}
            {attribute_view_gui attribute=$node|attribute('cognome')}
        </h2>
        <h3>
            <small>telefono:</small>
            {attribute_view_gui attribute=$node|attribute('telefono')}
            (
            {attribute_view_gui attribute=$node|attribute('numero_breve')}
            )
        </h3>
        <h3>
            <small>e-mail:</small>
            {attribute_view_gui attribute=$node|attribute('email')}
        </h3>
        <h3>
            <small>fax:</small>
            {attribute_view_gui attribute=$node|attribute('fax')}
        </h3>
        {*
        <h3>
            <small>indirizzo</small>
            {attribute_view_gui attribute=$node|attribute('sede_lavoro')}
        </h3>
        *}
    </div>
    
</div>