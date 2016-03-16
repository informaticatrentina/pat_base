<?php

$module = $Params['Module'];
$parentNodeID = $Params['ParentNodeID'];

$result = '';

try{
    $esito = PatBasePlaylistFunctions::forcePlaylistImport($parentNodeID);
    
    $result = array( 'playlistImportForced' => $esito );
}catch (Exception $ex) {
    $result = array( 'error' => $ex->getMessage() ); 
}

header('Content-Type: application/json');

echo json_encode( $result );

eZExecution::cleanExit();