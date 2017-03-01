<br>
<header>
        <h2>
            <i class="fa fa-building-o"></i>
            Import Strutture e 
            <i class="fa fa-user"></i>
            Personale P.A.T.
        </h2>
</header>
<hr>
<p>


<table class="table table-striped">
    <thead>
    <tr>
        <th class="header">Codice Struttura</th>
        <th class="header">Nodo Struttura Principale</th>
        <th class="header">Nodo Persone</th>
        <th class="header">Importa Figli</th>
        <th class="header">&nbsp;</th>
    </tr>
    <tbody id="tbody_setting">
    </tbody> 
    </thead>
</table>

{literal}               
    <script>
        
    $(document).ready(function() {
        
         var siteURL = "{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}";
         console.log(siteURL);
         $.ajax({
            dataType: "json",
            url: "https://"+siteURL+"/ptn/importStrutturePersone/read", 
            //async: false,
            success: function(result){
                $.each(result, function(key, setImport){
                    
                    // Aggiunta dell'evento in array
                    curSet = new Object();                    
                    curSet.id = setImport.id;
                    curSet.codice_struttura = setImport.codice_struttura;
                    curSet.ricorsivo = setImport.ricorsivo;                                
                    curSet.main_node_id = setImport.main_node_id;
                    curSet.persone_node_id = setImport.persone_node_id;
                    curSet.result = setImport.result;
                    
                    if( curSet.result=='Nessun record presente'){
                        // Inizializzazione dati
                        // Popola la riga con i dati recuperati
                        t_set = '<tr>';
                        t_set += '   <td colspan=4>'+curSet.result+'</td>';    
                        t_set += '   <td><a href="javascript:void(0)" onclick="addSetting();" class="btn btn-success has_tooltip" data-toggle="tooltip" data-placement="top" data-original-title="Add New Setting"><i class="fa fa-plus"></i></td>';                                    
                        t_set += '<tr>';
                        $("#tbody_setting").html( t_set );
                    }else{
                        // Popola la riga con i dati recuperati
                        t_set = '<tr>';
                        t_set += '   <td>'+curSet.codice_struttura+'</td>';                                    
                        t_set += '   <td>'+curSet.main_node_id+'</td>';                                    
                        t_set += '   <td>'+curSet.persone_node_id +'</td>';  
                        t_set += '   <td>'+ (curSet.ricorsivo === "1" ? "Si" : "No") +'</td>';  
                        t_set += '   <td><a href="https://'+siteURL+'/ptn/updateStrutturePersone/' + setImport.id +'" class="btn btn-success has_tooltip" data-toggle="tooltip" data-placement="top" data-original-title="Set Import"><i class="fa fa-pencil"></i></td>';                                    
                        t_set += '   <td><s href="javascript:void(0)" onclick="removeSetting(' +  setImport.id + ');" class="btn btn-success has_tooltip" data-toggle="tooltip" data-placement="top" data-original-title="Remove Setting"><i class="fa fa-trash-o"></i></td>';                                    
                        t_set += '<tr>';
                    }
                    $("#tbody_setting").html( t_set );
                });  
            }
        });
    });

    function removeSetting($sequenceId) {
        if (confirm("Vuoi davvero rimuovere le impostazioni?")) {
            var siteURL = "{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}";
            $.ajax({
                dataType: "json",
                url: "https://"+siteURL+"/ptn/importStrutturePersone/remove/" + $sequenceId , 
                //async: false,
                success: function(result){
                $.each(result, function(key, setImport){                   
                    // Aggiunta dell'evento in array
                    curSet = new Object();                    
                    curSet.result = setImport.result;                   
                    // Popola la riga con i dati recuperati
                    t_set = '<tr>';
                    t_set += '   <td colspan=4>'+curSet.result+'</td>';    
                    t_set += '   <td><a href="javascript:void(0)" onclick="addSetting();" class="btn btn-success has_tooltip" data-toggle="tooltip" data-placement="top" data-original-title="Add New Setting"><i class="fa fa-plus"></i></td>';                                    
                    t_set += '<tr>';
                    $("#tbody_setting").html( t_set );
                });  
            }
        });
        }
        else {
            return false;
        }
    }
    function addSetting(){
        var siteURL = "{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}";
            $.ajax({
                dataType: "json",
                url: "https://"+siteURL+"/ptn/importStrutturePersone/add/" , 
                //async: false,
                success: function(result){
                $.each(result, function(key, setImport){                    
                    // Aggiunta dell'evento in array
                    curSet = new Object();                    
                    curSet.result = setImport.result;  
                    curSet.id = setImport.id;
                    if(curSet.result == 'Ok'){
                        window.location =  "https://"+siteURL+"/ptn/updateStrutturePersone/" +curSet.id;
                    }else{
                        t_set = '<tr>';
                        t_set += '   <td colspan=4>'+curSet.result+'</td>';    
                        t_set += '   <td></td>';                                    
                        t_set += '<tr>';
                        $("#tbody_setting").html( t_set );
                    }
                });  
            }
         }); 
    }
     
    </script>
{/literal}


    