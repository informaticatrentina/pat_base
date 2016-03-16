<?php

/**
 * Crea una struttura ad albero per la rappresentazione dell'organigramma
 * 
 * @author Stefano Ziller, Marco Stambul
 */
class PatOrganigramma{
    
    /**
     * 
     * @param array $node_id
     */
    public static function getOrganigrammaTree($node_id){
        $retvalue = array();
        $mynode = eZContentObjectTreeNode::fetch($node_id);
    	$nodechildren=$mynode->children();
        
        foreach($nodechildren as $nodechild){
            if( $nodechild instanceof eZContentObjectTreeNode ){
                if($nodechild->ClassIdentifier == 'struttura_organizzativa'){
                    $dataMap = $nodechild->dataMap();
                    
                    $contentarray = $dataMap['codice_struttura_superiore']->Content;
                    $relation_list = $contentarray[relation_list];
                    
                    if(empty($relation_list)){
                        $retvalue[] = PatOrganigramma::getStruttura( $nodechild, $nodechildren );
                    }
                }
            }
        }
        
        return $retvalue;
    }
    
    /**
     * 
     * @param array $parentNode
     */
    private static function getStruttura( $parentNode, $nodechildren ){
        $retvalue = array();
        $retvalue[] = $parentNode;
        
        // Cerco se esistono nodi che hanno come padre $parentNode
        $contentObject = $parentNode->ContentObject;
        $remoteID = $contentObject->remoteID();
        foreach($nodechildren as $nodechild){
            if( $nodechild instanceof eZContentObjectTreeNode ){
                if($nodechild->ClassIdentifier == 'struttura_organizzativa'){
                    $dataMap = $nodechild->dataMap();
                    
                    $contentarray = $dataMap['codice_struttura_superiore']->Content;
                    $relation_list = $contentarray[relation_list];
                    
                    if(!empty($relation_list)){
                        $_remoteID = $relation_list[0][contentobject_remote_id];
                        if( strcmp($_remoteID, $remoteID) == 0 ){
                            $retvalue[] = PatOrganigramma::getStruttura( $nodechild, $nodechildren );
                        }
                    }
                }
            }
        }
        
        return $retvalue;
    }
}