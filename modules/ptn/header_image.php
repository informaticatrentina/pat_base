<?php

/**
 * Visualizza l'immagine contenuta nell'attirbuto header_image
 * della classe frotpage posizionata come RootNode
 */

$module = $Params['Module'];

// Root Node ID
$ini = eZINI::instance( 'content.ini' );
$root_node_id = $ini->variable( 'NodeSettings', 'RootNode' );

// Cluster
$file_ini = eZINI::instance( 'file.ini' );
$mount_point = $file_ini->variable('eZDFSClusteringSettings', 'MountPointPath');

// Default imagepath
$imagepath = 'extension/pat_base/design/itbase/images/header-ittemplate.jpg';

// Immagine personalizzata
$frontpage = eZContentObject::fetchByNodeID( $root_node_id );
if( $frontpage instanceof eZContentObject ){
    if( strcmp ($frontpage->className(), 'Frontpage') == 0 ){
        $dataMap =& $frontpage->attribute( 'data_map' ); 
        if( array_key_exists('header_image', $dataMap) ){
            $image =& $dataMap['header_image']->content();
            $list =& $image->aliasList(); 
            
            if( !empty($list['original']['url']) ){
                $imagepath = $mount_point . '/' . $list['original']['url'];
            }
        }
        
    }
}


header("Content-Type: image/jpeg");
echo file_get_contents($imagepath);

eZExecution::cleanExit();
