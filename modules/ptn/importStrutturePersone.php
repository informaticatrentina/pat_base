<?php


$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

$module = $Params['Module'];
$active = $Params['Active'];

$action = $Params['action']; 
$sequence_id = $Params['sequence_id']; 
$cod_struttura = $Params['cod_struttura']; 
$main_node_id = $Params['main_node_id']; 
$persone_node_id = $Params['persone_node_id']; 

$arayResult = array();

switch ($action) {
    case 'read':
        // lettura dei parametri da persistent object
        $arrayImportStrutturePersistentObjec = ItImportStrutturePersistentObject::fetchList();
        if($arrayImportStrutturePersistentObjec != null){
            foreach ($arrayImportStrutturePersistentObjec as $value) {
                $setImportStrutture = array();
                $setImportStrutture['id'] = $value['id'];
                // Legge il nome del nodo       
                $setImportStrutture['codice_struttura'] = $value['codice_struttura'];
                $setImportStrutture['ricorsivo'] = $value['ricorsivo'];
                $nodeId = $value['main_node_id'];
                if (is_numeric($nodeId)){                
                    $node = eZContentObjectTreeNode::fetch($nodeId );
                    $setImportStrutture['main_node_id'] = $node->attribute( 'name' );
                }  else {
                    $setImportStrutture['main_node_id'] = '';
                }
                $nodeIdPers = $value['persone_node_id'];
                if (is_numeric($nodeId)){                
                    $node = eZContentObjectTreeNode::fetch($nodeIdPers );
                    $setImportStrutture['persone_node_id'] = $node->attribute( 'name' );
                }  else {
                    $setImportStrutture['persone_node_id'] = '';
                }  
                $setImportStrutture['result'] = 'Ok';
            }
        }else{
            $setImportStrutture['result'] = 'Nessun record presente';
        }
         $arayResult[] = $setImportStrutture;
        break;
    case 'add':
        // aggiunta dei parametri al persistent object
        $arrayImportStrutturePersistentObjec = ItImportStrutturePersistentObject::fetchList();
        if($arrayImportStrutturePersistentObjec != null){
            $setImportStrutture['result'] = 'Errore Setting già impostatio';
        }else{          
            $simpleObj = ItImportStrutturePersistentObject::create( array( 'id' => null, 
                                                        'codice_struttura' => '',
                                                        'ricorsivo' => 0, 
                                                        'main_node_id' =>2,  
                                                        'persone_node_id' =>2
            ));        
            $simpleObj->store();
            // recupera l'id
            $arrayObj = ItImportStrutturePersistentObject::fetchList();
            if($arrayObj != null){                
                $setImportStrutture['id'] = $arrayObj[0]['id'];
            }
            $setImportStrutture['result'] = 'Ok';
        }
        $arayResult[] = $setImportStrutture;
        break;
    case 'remove':
            $setImportStrutture = array();
            if(is_numeric($sequence_id)){
                $cond = array( 'id' => $sequence_id);
                $simpleObj = eZPersistentObject::fetchObject( ItImportStrutturePersistentObject::definition(), null, $cond ); 
                if($simpleObj != null){
                    eZPersistentObject::removeObject( ItImportStrutturePersistentObject::definition(), $cond );
                    $setImportStrutture['result'] = 'Nessun record presente';
                }else{
                    $setImportStrutture['result'] = 'Errore Setting non trovato';
                }                
            }else{
                $setImportStrutture['result'] = 'Errore Setting non trovato';
            }
            
            $arayResult[] = $setImportStrutture;
            
        break;
    
    default:
       
}

header('Content-Type: application/json'); 
echo json_encode($arayResult);


eZExecution::cleanExit();