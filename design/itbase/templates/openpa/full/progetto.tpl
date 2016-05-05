{*$node|attribute('show')*}
<div class="content-view-full class-folder row">
    
    <div class="nav-section">
        <span class="fa fa-stack fa-4x">
            <i class="fa fa-square fa-stack-2x"></i>
            <i class="fa fa-gears fa-stack-1x fa-inverse"></i>
        </span>
    </div>
    
    <div class="content-main">
        <h2>
            <small>Titolo:</small>
            {attribute_view_gui attribute=$node|attribute('titolo')}
            
            <p>
                {attribute_view_gui attribute=$node|attribute('abstract')}
            </p>
        </h2>
        <h3>
            <small>descrizione:</small>
            {attribute_view_gui attribute=$node|attribute('descrizione')}
        </h3>
        <h3>
            <small>data partenza:</small>
            {attribute_view_gui attribute=$node|attribute('data_partenza')}
        </h3>
        <h3>
            <small>data scadenza:</small>
            {attribute_view_gui attribute=$node|attribute('data_scadenza')}
        </h3>
        <h3>
            <small>obiettivi:</small>
            {attribute_view_gui attribute=$node|attribute('obiettivi')}
        </h3>
        <h3>
            <small>fasi:</small>
            {attribute_view_gui attribute=$node|attribute('fasi')}
        </h3>
        <h3>
            <small>per saperne di più:</small>
            {attribute_view_gui attribute=$node|attribute('per_saperne_piu')}
        </h3>
        <h3>
            <small>dicono di noi:</small>
            {attribute_view_gui attribute=$node|attribute('dicono_di_noi')}
        </h3>
        <h3>
            <small>attori coinvolti:</small>
            {attribute_view_gui attribute=$node|attribute('attori_coinvolti')}
        </h3>
    </div>
    
</div>