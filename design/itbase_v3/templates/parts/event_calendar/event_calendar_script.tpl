                            
{* Script per la ricerca degli eventi  *}
{literal}
<script>
    var siteURL = '{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}';
    var class_identifier = "event_simple";
    var facet_attributes = "titolo";
    var node_id = '{/literal}{$node.node_id}{literal}';
    var show_datatable = false;
    var arrayMonths = [ "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", 
               "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre" ];


    // Imposta le faccette per le select options
    function setSelectFacet( facet, item, selected_item_value ){
        if(selected_item_value === ''){
            item.html('<option value="" selected>'+item.data("placeholder")+'</option>');
        }
        else{
            item.html('<option value="">'+item.data("placeholder")+'</option>');
        }
        
        if( facet !== null ){
            console.log(facet);
            $.each(facet.countList, function( _label, _count ){
                var _disabled = false;
                if(_count === 0){
                    _disabled = true;
                }

                /* DEBUG *
                if(_label === ''){
                    _label = '<N/D>';
                    _disabled = true;
                }
                /**/
        
                if(_label !== ''){
                    if(selected_item_value === _label){
                       item.append($('<option>', { 
                            value: _label,
                            text : _label + ' (' +  _count +  ')',
                            disabled: _disabled,
                            selected: ''
                        })); 
                    }
                    else{
                        item.append($('<option>', { 
                            value: _label,
                            text : _label + ' (' +  _count +  ')',
                            disabled: _disabled
                        }));
                    }
                }

            });
        }
    }
    
    
    function updateFacets(result){
       // setSelectFacet( (result.FacetFields !== null?result.FacetFields[1]:null), $("#soggetti"), result.GET['soggetti'] );
 
    }
    
    function updateCalendar(result){
        
        var modelloPannello = "<div class='col-xs-12 col-sm-6 col-md-4' id='content-related-folder'><div class='media-panel'><div class='figure-border'><a href='##full_link##' title='##titolo_media##'>";
            modelloPannello += "<figure style='background: url( /##widelargeImage## )'></figure></a></div><div class='media has-image'>";
            modelloPannello += "<div class='caption'><h2>##DataDal## ##DataAl##</h2><p></p>";
            modelloPannello += "<h4 class='fw_medium color_dark text-left'><a href='##full_link_titolo##' title='##titolo_link##'>##titolo##</a></h4><p></p><div class='row'><div class='col-xs-5 media-line'></div></div><p class='abstract'></p>";
            modelloPannello += "<div class='text-left' style='padding-bottom: 5px; '><a class='btn btn-default btn-xs_thiny' href='##full_link_scopri##' class='panel-button'>SCOPRI</a></div>";
            modelloPannello += "</div></div></div></div>";
        
        var calendar = '';
        $('.cur-calendar').html(calendar);
        if(result.recordsTotal === 0){
            calendar = "<div id='prv_NessunEvento' class='col_md-12 text-center'> Nessun evento </div>";
         }
        // Pannelli
        $.each(result.data, function(row, value){
            
            console.log(row);
            console.log(value);
             
            modelloPannelloTmp = modelloPannello;
            modelloPannelloTmp =  modelloPannelloTmp.replace("##titolo##", value.titolo);
            modelloPannelloTmp =  modelloPannelloTmp.replace("##titolo_media##", value.titolo);
            modelloPannelloTmp =  modelloPannelloTmp.replace("##titolo_link##", value.titolo);           
            
            if(value.DataAl !=''){
                modelloPannelloTmp = modelloPannelloTmp.replace("##DataDal##","" + value.DataDal);
                modelloPannelloTmp = modelloPannelloTmp.replace("##DataAl##", " - " + value.DataAl);  
            }else
            {
                modelloPannelloTmp = modelloPannelloTmp.replace("##DataDal##", value.DataDal);
                modelloPannelloTmp = modelloPannelloTmp.replace("##DataAl##", "");  
            }           
            modelloPannelloTmp = modelloPannelloTmp.replace("##full_link##", value.full_link);
            modelloPannelloTmp = modelloPannelloTmp.replace("##full_link_titolo##", value.full_link);
            modelloPannelloTmp = modelloPannelloTmp.replace("##full_link_scopri##", value.full_link);
            modelloPannelloTmp = modelloPannelloTmp.replace("##widelargeImage##", value.widelargeImage);
            modelloPannelloTmp = modelloPannelloTmp.replace("##pubblicatoil##", value.DataPubblicazione);
            calendar += modelloPannelloTmp;
        });
        //

        $('.cur-calendar').html(calendar);
    }

    // Se vero esegue una ricerca iniziale
    var do_search = true;
    currentMonth = $("#currentSelectedMonth").val();
    console.log("https://"+siteURL+"/ptn/calendar_search/" + class_identifier + "/" + facet_attributes + "/" + node_id + "?currentMonth=" + currentMonth);
       
    $(document).ready(function(){
        $.ajax({
           dataType: "json",
           url: "https://"+siteURL+"/ptn/calendar_search/" + class_identifier + "/" + facet_attributes + "/" + node_id + "?currentMonth=" + currentMonth, 
           //async: false,           
           "success": function( result ){
                     updateFacets( result );
                     updateCalendar( result );
            },
            error: function() {   
               
            }
        });

        
        
            // Lettura variabili persistenti
            if(localStorage.getItem('query') !== null){
                $("#query").val( localStorage.getItem('query') );
            }
         
            if(localStorage.getItem('soggetti') !== null){
                $("#soggetti").val( localStorage.getItem('soggetti') );
                $("#soggetti").hide();
                $("#soggetti_value").html( localStorage.getItem('soggetti') );
                $("#soggetti_choosen").show();
            }

            // Se ci sono variabili preimpostate esegue la ricerca
            if(do_search){
                search( null );
            }
        //});
        
        // Aggiorna la ricerca //
        function search(event){
            
            show_datatable = true;
            do_search = false;
            
            // Numero elementi per pagina
            if(event !== null && event.target.id === 'show'){
                dataTable.page.len( $(event.target).val() );
            }
            
            // Sistema per togliere impostazione di una faccetta
            if(event !== null && $(event.target).attr("class") === "search-choice-close"){
                var id_reset = event.target.id;
                var parent_id = id_reset.replace('_reset', '');
                
                $("#"+parent_id).val( '' );
                $("#"+parent_id).show();
                
                $("#"+parent_id+"_value").html( '' );
                $("#"+parent_id+"_choosen").hide();
            }
            currentMonth = $("#currentSelectedMonth").val();
            if($("#query").val() !== ''){
                curQuery = "&query=" + $("#query").val();
            }else{
                curQuery = '';
            }
            if($("#soggetti").val() !== ''){
                curQuery = "&soggetti=" + $("#soggetti").val();
            }
            
            $.ajax({
                dataType: "json",
                url: "https://"+siteURL+"/ptn/calendar_search/" + class_identifier + "/" + facet_attributes + "/" + node_id + "?currentMonth=" + currentMonth + curQuery, 
                //async: false,           
                "success": function( result ){
                          updateFacets( result );
                          updateCalendar( result );
                 },
                 error: function() {   

                 }
             });
            
            // Imposta il sistema per rimuovere la faccetta se è selezionato un valore
            if(event !== null){
                var value = $(event.target).val();
                var source_id = event.target.id;
                if(value !== '' && source_id !== 'query' && source_id !== 'titolo'){
                    $(event.target).hide();

                    $("#"+source_id+"_value").html( value );
                    $("#"+source_id+"_choosen").show();
                }
            }
            
           
            
            // persistenza variabili di ricerca
            if($("#query").val() !== ''){
                localStorage.setItem('query', $("#query").val());
            }
            else{
                localStorage.removeItem('query');
            }
            
            if($("#titolo").val() !== ''){
                localStorage.setItem('titolo', $("#titolo").val());
            }
            else{
                localStorage.removeItem('titolo');
            }                            
           
            if($("#luogo_svolgimento").val() !== ''){
                localStorage.setItem('luogo_svolgimento', $("#luogo_svolgimento").val());
            }
            else{
                localStorage.removeItem('luogo_svolgimento');
            }
            
            //
        }
        
        // Azzera la ricerca //
        $("#prv_reset_button").click(function(event){
            $("#query").val("");
            
           
            
            search(event);
            $(this).hide();
        });
        
        // Ricarica lanciata su invio //
        $("#query").keypress(function(event) {
            
            if (event.which === 13) {
                event.preventDefault();
                 $("#prv_reset_button").show();
                show_loading();
                search(event);
                
            }
        });
        
                
        // Ricarica su PrexMonth
        $("#calendardPrexMonth").click(function(event){
            show_loading();
            //Modifica la data
            currentMonth = $("#currentSelectedMonth").val();
            var d = new Date(currentMonth);
            d = addMonths(d,-1);
            $("#currentSelectedMonth").val(  d.getFullYear( )  + '-' + parseInt(d.getMonth() + 1 ) + '-' + d.getDate( )); 
            $("#calendardCorrentMonth").html('Mese di ' + arrayMonths[d.getMonth()] + " " + d.getFullYear( )  );
          
            search(event);
            event.preventDefault();
        });
         // Ricarica su NextMonth
        $("#calendardNextMonth").click(function(event){
            show_loading();
            //Modifica la data
            currentMonth = $("#currentSelectedMonth").val();
            var d = new Date(currentMonth);
            d = addMonths(d,1);
            $("#currentSelectedMonth").val(  d.getFullYear( )  + '-' + parseInt(d.getMonth() + 1 ) + '-' + d.getDate( ));
            $("#calendardCorrentMonth").html('Mese di ' + arrayMonths[d.getMonth()] + " " +  d.getFullYear( )  );
            
            search(event);
            event.preventDefault();
        });
        
       // Reset di una faccetta //
       $(".search-choice-close").click(function(event){
            search(event);
       });
       
    });
    
    
    function addMonths (date, count) {
    
        if (date && count) {
    
            var m, d = (date = new Date(+date)).getDate()

            date.setMonth(date.getMonth() + count, 1)
            m = date.getMonth()
            date.setDate(d)
            if (date.getMonth() !== m) date.setDate(0)
        }
      return date
    }
    
    function show_loading(){
        var calendar = '<div id="prv_loading" class="col_md-12 text-center" style="padding-top: 100px ; padding-bottom: 100px">';
            calendar += '<i class="fa fa-spinner fa-spin fa-3x"></i></div>';
        $('.cur-calendar').html(calendar);
    }
    
</script>
{/literal}