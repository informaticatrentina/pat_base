<?php

$FunctionList = array();
$FunctionList['forcesitecolorfunction'] = array(
    'name' => 'forcesitecolorfunction',
    'operation_types' => array( 'read' ),
    'call_method' => array(
        'include_file' => 'extension/pat_base/classes/patbasecolorfunctions.php',
        'class' => 'PatBaseColorFunctions',
        'method' => 'fetchSiteColors' ),
        'parameter_type' => 'standard',
    'parameters' => array()
);
