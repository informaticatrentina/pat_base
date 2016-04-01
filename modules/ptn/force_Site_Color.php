<?php

$module = $Params['Module'];
$siteColor = $Params['SiteColor'];

$result = '';



try{
 
    $esito = PatBaseColorFunctions::forceSiteColor($siteColor);
    
    //print_r($esito);
    //die();

    $result = array( 'SiteColorForced' => $esito );
}catch (Exception $ex) {
    $result = array( 'error' => $ex->getMessage() ); 
}

header('Content-Type: application/json');

echo json_encode( $result );

eZExecution::cleanExit();