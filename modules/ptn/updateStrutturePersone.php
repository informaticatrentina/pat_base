<?php

$module = $Params['Module'];
$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();
$sequence_id = $Params['id'];
$tree_type = $Params['tree_type'];

$curChkIncludiFigli0 = "";
$curChkIncludiFigli1 = ""; 

try{
 
    // Pesca i dati dal persistent object
    $currentSetting = ItImportStrutturePersistentObject::fetchById($sequence_id);
    if ($currentSetting != null)
    {       
        $curCodice_Struttura = $currentSetting->Codice_Struttura;
        $curdest_node = $currentSetting->MainNodeId;
        $curdest_persona_dest_node_id = $currentSetting->PersoneNodeId;
        $curdest_ricorsivo = $currentSetting->Ricorsivo;
        if ($curdest_ricorsivo == "0")
            $curChkIncludiFigli0 = "selected";
        else
            $curChkIncludiFigli1 = "selected";
         
                    
        foreach($http->attribute('post') as $key => $value){
            //echo("<br>");
            //echo($key);
            //echo('#');
            //echo($value);
            switch ($key) {
                case 'Enable_Struttura':
                    // Controllo che la struttura di di 4 carateri                    
                    if (strlen($value) == 4){ 
                        $curCodice_Struttura = $value;
                        $cond = array( 'id' => $sequence_id);
                        $simpleObj = eZPersistentObject::fetchObject( ItImportStrutturePersistentObject::definition(), null, $cond );
                        $simpleObj->setAttribute( 'codice_struttura', $curCodice_Struttura ); 
                        $simpleObj->store();
                    }                        
                    break;
                case "Enable_Children":
                    $curChkIncludiFigli = $value;
                    
                    $cond = array( 'id' => $sequence_id);
                    $simpleObj = eZPersistentObject::fetchObject( ItImportStrutturePersistentObject::definition(), null, $cond );
                    $simpleObj->setAttribute( 'ricorsivo', $curChkIncludiFigli ); 
                    $simpleObj->store();
                    if ($curChkIncludiFigli =="0"){
                        $curChkIncludiFigli0 = "selected";
                        $curChkIncludiFigli1 = "";
                    }
                    else{
                        $curChkIncludiFigli0 = "";
                        $curChkIncludiFigli1 = "selected";
                    }
                    break;
                case 'SelectedNodeIDArray':
                    // prende il valore 0
                   
                    $cond = array( 'id' => $sequence_id);
                    $simpleObj = eZPersistentObject::fetchObject( ItImportStrutturePersistentObject::definition(), null, $cond );
                    if($tree_type =='Persona'){
                        $curdest_persona_dest_node_id = $value[0];
                        $simpleObj->setAttribute( 'persone_node_id', $curdest_persona_dest_node_id );
                    }else{
                        $curdest_node = $value[0];
                        $simpleObj->setAttribute( 'main_node_id', $curdest_node );                     
                    }
                    $simpleObj->store();         
                    break;                    
            }            
        }
        // echo("</pre>");
        // die();
        // 
        // Caso modifica
        $tpl->setVariable('dest_node',  $curdest_node);
        $tpl->setVariable('persona_dest_node_id', $curdest_persona_dest_node_id);
        $tpl->setVariable('curCodiceStruttura',$curCodice_Struttura ); 
        $tpl->setVariable('curChkIncludiFigli0',  $curChkIncludiFigli0);
        $tpl->setVariable('curChkIncludiFigli1',  $curChkIncludiFigli1);
    }
    
    if($http->hasPostVariable( 'SelezionaDestinazione' )){
        eZContentBrowse::browse(
            array(
                'action_name' => 'SelectDestinationNodeID',
                'selection' => 'single',
                'return_type' => 'NodeID',
                'start_node' => 2,
                'from_page' => 'ptn/updateStrutturePersone/' . $sequence_id . '/Struttt/',
                'cancel_page' => 'ptn/updateStrutturePersone/' . $sequence_id,
            ),
            $module
        );
        return;
    }

    if($http->hasPostVariable( 'SelezionaDestinazionePersona' )){
        eZContentBrowse::browse(
            array(
                'action_name' => 'SelectDestinationNodeID',
                'selection' => 'single',
                'return_type' => 'NodeID',
                'start_node' => 2,
                'from_page' => 'ptn/updateStrutturePersone/' . $sequence_id. '/Persona/',
                'cancel_page' => 'ptn/updateStrutturePersone/' . $sequence_id,
            ),
            $module
        );
        return;
    }
    // Esegue l'update
    
    // Variabili passate al template
  
    
} catch (Exception $ex) {
    $tpl->setVariable('exception', $ex->getMessage() );
}

$Result['content'] = $tpl->fetch( "design:dashboard/updateStrutturePersone.tpl" );
$Result['path'] = array( array( 'url' => 'content/dashboard',
                                'text' => 'Pannello strumenti' ) ,
                         array( 'url' => false,
                                'text' => 'Import Strutture e  Personale P.A.T.' ) );
