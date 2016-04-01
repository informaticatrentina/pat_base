<header>
        <h2>
            <i class="fa fa-paint-brush"></i>
            Imposta Colori Principali del sito
        </h2>
    </header>
    <hr>
    <p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Scelta Colore:</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
               
               {foreach fetch( 'ptn', 'forcesitecolorfunction' ) as $curSiteColor}   
                <tr>
                    <td>{$curSiteColor.name_tag}</td>
                    <td>
                        <input type="text" 
                           name="colorpicker{$curSiteColor.id}" 
                           maxlength="6" 
                           size="6" 
                           id="colorpicker{$curSiteColor.id}"
                           value="{$curSiteColor.color}" 
                           style="background-color:#{$curSiteColor.color}">
                    <td>
                    <td>
                        &nbsp;
                    </td>
                 </tr>  
                {if is_set( $cpname )|not}
                    {def $clickfunction = concat("$('#colorpicker" ,$curSiteColor.id , "').val()")}
                    {def $cpname = concat('#colorpicker' , $curSiteColor.id)}
                {else}
                    {set $clickfunction = concat($clickfunction , "+'-'+$('#colorpicker" ,$curSiteColor.id , "').val()")}
                    {set $cpname = concat($cpname ,', #colorpicker' , $curSiteColor.id)}
                {/if} 
                {/foreach} 
                 <input type="hidden" id="curColorPick" value="none">
                <tr>
                     <td>
                        &nbsp;
                    </td>
                    <td>
                        <button id="forceSiteColor" class="btn btn-primary">
                            Imposta Colori al Sito                        
                        </button> 
                    </td><td>    
                        <form id="clearcache" action="{'/setup/cachetoolbar'|ezurl( 'no' )}" method="post">
                            <input type="hidden" name="CacheTypeValue" value="TemplateContent">
                            <input class="btn btn-primary" type="submit" name="ClearCacheButton" value="Svuota Cache" >
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>
        <input type="hidden" id="curColorPick" value="">
    </p>

    
    <script type="text/javascript">
        $('{$cpname}' ).ColorPicker( {ldelim}
           
    flat: false,
                onShow: function (colpkr)  {ldelim}
                        $(colpkr).fadeIn(500);
                        return false;
                {rdelim},
	onHide: function (colpkr)  {ldelim}
		$(colpkr).fadeOut(500);                       
		return false;
	{rdelim},
        onBeforeShow: function () {ldelim}
		$(this).ColorPickerSetColor(this.value);
                $('#curColorPick').val(this.name);                
	{rdelim},      
	onChange: function (hsb, hex, rgb)  {ldelim}
                $_div = $('#curColorPick').val(); 
        	$("#" + $_div).val(hex);
                $("#" + $_div).css('backgroundColor', '#' + hex);               
	{rdelim}
        {rdelim});
    </script>
    
    

    <script>
        {literal}
        $("#forceSiteColor").click(function() {
            var colori = '/' + {/literal}{$clickfunction}{literal} + '/';
         
        {/literal}
            
            var base_url = {'/ptn/forceSiteColor/'|ezurl()};           
            {literal}  
            base_url = base_url + colori;
            //alert(base_url);
            
            var request = $.ajax({
                url: base_url + colori ,
                type: "GET", 
                async: false,
                dataType: "json"
            });
           
            request.done(function( msg ) {
                
                if(msg.SiteColorForced){
                    alert('Svuotare la Cache per rendere effettive le modifiche.');
                }
                else{
                   alert('Attenzione errore durante la fase di modifica colore sito.');           
                }                
            });
 
        });
        {/literal}
    </script> 