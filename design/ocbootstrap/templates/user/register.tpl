{* verifica la tipologia di invio notifica attivazione utente mail o sms *}
{def $currentVerifyUserType = ezini('UserSettings', 'VerifyUserType', 'site.ini')}


<div class="row">
<div class="col-md-8 col-md-offset-2">

<form enctype="multipart/form-data"  action={"/user/register/"|ezurl} method="post" name="Register" class="form-signin" onsubmit="checkform();">

<h1 class="container-title">{"Register user"|i18n("design/ocbootstrap/user/register")}</h1>
<h6><small>* {"Required fields"|i18n("design/ocbootstrap/user/register")}</small></h6>

{if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true() ) )}
<div class="alert alert-danger">
<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h2>
</div>
{/if}

{if $validation.processed}

{if $validation.attributes|count|gt(0)}
    <div class="alert alert-danger">
    <p><strong>{"Input did not validate"|i18n("design/ocbootstrap/user/register")}</strong></p>
    <ul>
    {foreach $validation.attributes as $attribute}
        <li>{$attribute.name}: {$attribute.description}</li>
    {/foreach}
    </ul>
    </div>
{else}
    <div class="alert alert-success">
    <p><strong>{"Input was stored successfully"|i18n("design/ocbootstrap/user/register")}</strong></p>
    </div>
{/if}

{/if}

{if count($content_attributes)|gt(0)}
   
    <div class="row">
        
        <div class="col-md-6">            
            {foreach $content_attributes as $attribute max 3}            
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />  
            <p>{attribute_edit_gui attribute=$attribute html_class="form-control input-lg" 
                placeholder=$attribute.contentclass_attribute.name|i18n("design/ocbootstrap/user/register")}</p>
            {/foreach}
           
            {if $currentVerifyUserType|eq('sms')}
             
                <div class="alert alert-success clearfix">
                <div class="row">
                        <div class="col-xs-9">
                           </br>
                            Inserire un numero di cellulare valido 
                            per ricevere codice di conferma via SMS.
                        </div>
                        <div class="col-xs-3 text-right">
                            <span class="fa-stack fa-2x related-icon" style="margin-left: 2px;">
                                <i class="fa fa-circle fa-stack-2x 
                                          fa-inverse"></i>
                                <i class="fa fa-info fa-stack-1x"></i>
                            </span>
                        </div>
                </div>
                </div>
            {/if}
        </div>
        
        <div class="col-md-6">          
            {foreach $content_attributes as $attribute offset 3}
                {if $attribute.contentclass_attribute.category|ne('hidden')}
                    {* Salta i campi con categoria hidden*}
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                    <p>{attribute_edit_gui attribute=$attribute html_class="form-control input-lg" placeholder=$attribute.contentclass_attribute.name|i18n("design/ocbootstrap/user/register")}</p>
                {/if}
            {/foreach}
        </div>
    </div>
        
    <div class="alert alert-warning clearfix">
        {def $acceptservice = ezhttp('acceptservice', 'POST')}
        
        <input type='checkbox' name='acceptservice' id='acceptservice' 
               {if $acceptservice |eq('on')}
                   checked
               {/if}    
        > Accetto i 
        <a href='https://www.riformastatuto.tn.it/Social-Media-Policy' target="_blank">
            principi del servizio</a>
        <br>
        {def $acceptinfo = ezhttp('acceptinfo', 'POST')}
         <input type='checkbox' name='acceptinfo' id='acceptinfo'
            {if $acceptinfo |eq('on')}
                checked
            {/if}  
        > Ho letto 
        <a href='http://www.consiglio.provincia.tn.it/Util/Pages/Privacy-policy.aspx' target="_blank">l'informativa</a>
        alla privacy e autorizzo il trattamento dei dati personali in base art. 13 del D. Lgs. 196/2003
        <br>
        <br>
        <b>ATTENZIONE: Al termine della registrazione, riceverete una email di conferma iscrizione.</b>
    </div>
        
    <div class="buttonblock">
         <input type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}" />
        {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
            <input class="btn btn-lg btn-primary pull-right" type="submit" id="PublishButton" name="PublishButton" value="{'Register'|i18n('design/ocbootstrap/user/register')}"/>
        {else}    
            <input class="btn btn-lg btn-inverse pull-right" type="submit" id="PublishButton" name="PublishButton" disabled="disabled" value="{'Register'|i18n('design/ocbootstrap/user/register')}"  />
        {/if}
        <input class="btn btn-lg btn-inverse pull-left" type="submit" id="CancelButton" name="CancelButton" value="{'Discard'|i18n('design/ocbootstrap/user/register')}" onclick="cancelSubmit();" />
    </div>
{else}
    <div class="alert alert-danger">
        <p>{"Unable to register new user"|i18n("design/ocbootstrap/user/register")}</p>
    </div>
    <input class="btn btn-primary" type="submit" id="CancelButton" name="CancelButton" value="{'Back'|i18n('design/ocbootstrap/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
{/if}

</form>
</div>
</div>

{literal}
<script type="text/javascript">
    function disableButtons()
    {
        document.getElementById( 'PublishButton' ).disabled = true;
        document.getElementById( 'CancelButton' ).disabled = true;
    }
    function cancelSubmit(){       
        document.Register.acceptservice.checked = true;
        document.Register.acceptinfo.checked = true;
    }
    function checkform() {
   
        if(!document.Register.acceptservice.checked) {           
            if(!document.Register.acceptinfo.checked) {
                alert("Prego accettare sia i principi che i termini di servizio che informativa alla privacy.");
                event.preventDefault();
                return false;
            }
            else{
                alert("Prego accettare i principi e i termini di servizio.");
                event.preventDefault();
                return false;
            } 
        }
        if(!document.Register.acceptinfo.checked) {
            if(document.Register.acceptservice.checked) {
                 alert("Prego accettare informativa alla privacy.");
                 event.preventDefault();
                    return false;
            }
        }
        window.setTimeout( disableButtons, 1 );
    }
   
</script>
{/literal}
