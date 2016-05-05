{*$node|attribute('show')*}
<div class="content-view-full class-folder row">
    
    <div class="nav-section">
        <span class="fa fa-stack fa-4x">
            <i class="fa fa-square fa-stack-2x"></i>
            <i class="fa fa-building-o fa-stack-1x fa-inverse"></i>
        </span>
    </div>
    
    <div class="content-main">
        <h2>
            <small>Ragione sociale</small>
            {attribute_view_gui attribute=$node|attribute('ragione_sociale')}
        </h2>
        <h3>
            <small>telefono:</small>
            {attribute_view_gui attribute=$node|attribute('telefono')}
        </h3>
        <h3>
            <small>e-mail:</small>
            {attribute_view_gui attribute=$node|attribute('email')}
        </h3>
        <h3>
            <small>fax:</small>
            {attribute_view_gui attribute=$node|attribute('fax')}
        </h3>
        <h3>
            <small>indirizzo:</small>
            {attribute_view_gui attribute=$node|attribute('indirizzo')}
        </h3>
    </div>
    
</div>