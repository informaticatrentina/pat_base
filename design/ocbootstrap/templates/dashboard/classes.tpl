{def $url_classes_repository = ezini('NetworkSettings','PrototypeUrl','openpa.ini')}

<header>
    <h2>
        <i class="fa fa-folder"></i>
        Gestione classi
        
    </h2>
</header>
<hr>
<p>
    Origine: 
    <small class="text-primary">
        {$url_classes_repository}
    </small>
</p>
<p>
    <div>
        {include uri='design:itclassmanager/classdiff.tpl'}
    </div>
    
</p>