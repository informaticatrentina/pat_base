<?php

/**
 * 
 */
class PatHeader
{
   
    /**
     * Ritorna il nodo che contiene le immagini
     * 
     * @param type $nodeID
     */
    public static function getHeaderImages($nodeID)
    {
        $node = eZContentObjectTreeNode::fetch($nodeID);
        
        if( $node->ClassName === 'Landing Page'){
            return $node;
        }
        else if($node->NodeID === '2'){
            return false;
        }
        else{
            return self::getHeaderImages($node->ParentNodeID);
        }
        
    }
}

