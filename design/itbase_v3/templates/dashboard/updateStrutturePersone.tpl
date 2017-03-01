<div class="row dashboard">
    <div class="col-md-8 col-md-offset-3">
        <div class="card-material">
            <header>
                <h2>
                <i class="fa fa-building-o"></i>
                Import Strutture e 
                <i class="fa fa-user"></i>
                Personale P.A.T.
            </h2>
            </header>
            <hr/>
            <p>
                <form method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            {if is_set($dest_node)}
                                {def $my_node=fetch( 'content', 'node', hash( 'node_id',$dest_node ) )}                                
                                Destinazione Struttura Principale: 
                                <b>{$my_node.name|wash}</b>
                            {else}
                                <em>Seleziona la destinazione</em>
                            {/if}
                        </div>
                        <div class="col-md-6 text-left">
                            <button name="SelezionaDestinazione" type="submit" class="btn btn-primary text-right">
                                <i class="fa fa-folder"></i>
                                Seleziona Destinazione
                            </button>
                        </div>
                    </div>  
                    <div class="row"><div class="col-md-12">&nbsp;</div></div> 
                    <div class="row">
                        <div class="col-md-6">
                            {if is_set($persona_dest_node_id)}                                
                                {def $persona_dest_node=fetch( 'content', 'node', hash( 'node_id',$persona_dest_node_id ) )}                                
                                Destinazione Persone: 
                                <b>{$persona_dest_node.name|wash}</b>
                            {else}
                                <em>Seleziona la destinazione</em>
                            {/if}
                        </div>
                        <div class="col-md-6 text-left">
                            <button name="SelezionaDestinazionePersona" type="submit" class="btn btn-primary text-right">
                                <i class="fa fa-folder"></i>
                                Seleziona Destinazione
                            </button>
                        </div>
                    </div> 
                    <div class="row"><div class="col-md-12">&nbsp;</div></div>  
                     <div class="row">
                        <div class="col-md-6">
                            <label>Includi Figli: </label>                            
                        </div>
                        <div class="col-md-6 text-left" >
                            <select name="Enable_Children">
                                <option value="0" {$curChkIncludiFigli0}>No</option>
                                <option value="1" {$curChkIncludiFigli1}>Si</option>
                            </select>
                        </div>
                    </div>
                    <div class="row"><div class="col-md-12">&nbsp;</div></div>  
                    <div class="row">
                        <div class="col-md-6">
                            <label>Codice Struttura: </label>
                            <input name="Enable_Struttura" type="text" value="{$curCodiceStruttura}">
                        </div>
                        <div class="col-md-6 text-left" >
                            <button name="Enable_StrutturaBt" type="submit" class="btn btn-success" value="Set Struttura">
                                <i class="fa fa-check"></i>
                                Set Struttura
                            </button>
                        </div>
                    </div>
                    <div class="row"><div class="col-md-12">&nbsp;</div></div> 
                    
                </form>
                
                <div class="row"><div class="col-md-12">&nbsp;
                <a href="{'content/dashboard/'|ezurl('no')}" class="btn btn-warning pull-right" style="margin-right: 10px">Torna alla dashboard</a>   
                </div></div> 
            </p></div></div> 
        </div>
    </div>
</div>
