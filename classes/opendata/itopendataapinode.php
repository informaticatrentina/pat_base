<?php

/**
 * 
 * Modifica della classe OCOpenDataApiNode per togliere il controllo
 * con la ricerca dell'oggetto per nome
 * 
 */
class ITOpenDataApiNode extends OCOpenDataApiNode {
    
    /**
     * Ritorna un istanza della classe ITOpenDataApiNode
     * 
     * @param type $url
     * @return boolean|\self
     */
    public static function fromLink( $url )
    {
        $data = json_decode( eZHTTPTool::getDataByURL( $url ), true );
        
        if ( $data )
        {
            return new self( $data );
        }
        return false;
    }
    
    /**
     * Metodo modificato
     * 
     * @param type $parentNodeID
     * @param type $localRemoteIdPrefix
     * @return type
     * @throws Exception
     */
    public function createContentObject( $parentNodeID, $localRemoteIdPrefix = '' )
    {
        
        if ( !eZContentClass::fetchByIdentifier( $this->metadata['classIdentifier'] ) )
        {
            throw new Exception( "La classe {$this->metadata['classIdentifier']} non esiste in questa installazione" );
        }

        if ( eZContentObject::fetchByRemoteID( $this->metadata['objectRemoteId'] ) )
        {
            throw new Exception( "L'oggetto con remote \"{$this->metadata['objectRemoteId']}\" esiste già in questa installazione" );            
        }
        
        $params                     = array();        
        $params['class_identifier'] = $this->metadata['classIdentifier'];
        $params['remote_id']        = $localRemoteIdPrefix . $this->metadata['objectRemoteId'];
        $params['parent_node_id']   = $parentNodeID;
     
        $params['attributes']       = $this->getAttributesStringArray( $parentNodeID );
        
        return eZContentFunctions::createAndPublishObject( $params );
    }
    
    
    public function getAttributesStringArray( $parentNodeID, $isUpdate = false )
    {
         
        $attributeList = array();
        foreach( (array) $this->fields as $identifier => $fieldArray )
        {
            switch( $fieldArray['type'] )
            {
                case 'ezxmltext':
                    $attributeList[$identifier] = SQLIContentUtils::getRichContent( $fieldArray['value'] );
                    break;
                case 'ezbinaryfile':
                case 'ezimage':
                    if ( !empty( $fieldArray['value'] ) )
                    {
                        $attributeList[$identifier] = SQLIContentUtils::getRemoteFile( $fieldArray['value'] );
                    }
                    break;
                case 'ezobjectrelationlist':
                  
                    $parentNodeID = $this->findRelationObjectLocation( $identifier, $parentNodeID );                    
                    $attributeList[$identifier] = $this->createRelationObjects( $fieldArray, $parentNodeID, $isUpdate );
                   
                    break;
                case 'eztags':
             
                    $attributeList[$identifier] = $this->createLocalTags( $identifier, $fieldArray['string_value'] );
                    
                    break;
                default:
                    $attributeList[$identifier] = $fieldArray['string_value'];
                    break;
            }            
        }
        return $attributeList;
    }
    
    protected function createRelationObjects( $fieldArray, $parentNodeID, $isUpdate = false )
    {
       
        $data = array();
        if ( is_array( $fieldArray['value'] ) )
        {
            foreach ( $fieldArray['value'] as $item )
            {
                try{
                    
                    // Nella variabile $link imposto il link all'oggetto
                    $link = "";
                    if( is_array($item) && array_key_exists('link', $item) && substr( $item['link'], 0, 4 ) === "http" ){
                        $link = $item['link'];
                    }
                    else if( !is_array($item) && substr( $item, 0, 4 ) === "http" ){
                        $link = $item;
                    }
                    
                    if($link != "" && strpos( $link, "/api/" ) !== false ){
                        $remoteApiNode = ITOpenDataApiNode::fromLink( $link );
                        
                        if ( !$remoteApiNode instanceof ITOpenDataApiNode )
                        {
                            throw new Exception( "Api node not found" );
                        }
                        
                        if ( $isUpdate )
                        {   
                            $newObject = $remoteApiNode->updateContentObject();
                        }
                        else
                        {              
                            try{
                                $newObject = $remoteApiNode->createContentObject( $parentNodeID );
                            }catch ( Exception $es ){
                                // Se esiste già l'oggetto esegue l'update.
                                $newObject = $remoteApiNode->updateContentObject();
                            }
                        }
                        if ( $newObject instanceof eZContentObject )
                        {
                            $data[] = $newObject->attribute( 'id' );
                        }
                    }
                }
                catch ( Exception $e )
                {
                    eZDebug::writeError(
                        $e->getMessage() . ' ' . var_export( $item, 1 ),
                        __METHOD__
                    );
                }
            }
        }
        //eZDebug::writeNotice( var_export( $data, 1 ), __METHOD__ );
        return implode( '-', $data );
    }
    
    /**
     * Aggiorna solamente gli attributi valorizzati sul repository
     * 
     * @param eZContentObject $object
     * @param type $classTools
     * @param type $localRemoteIdPrefix
     * @return type
     * @throws Exception
     */
    public function updateContentObject( eZContentObject $object = null, $classTools = null, $localRemoteIdPrefix = '' )
    {
        if ( $object === null )
        {
            $object = eZContentObject::fetchByRemoteID( $localRemoteIdPrefix . $this->metadata['objectRemoteId'] );
        }
        $this->compareWithContentObject( $object, $classTools );
        $params = array();
        $params['attributes'] = $this->getAttributesStringArray( $object->attribute( 'main_parent_node_id' ), true );
        
        // Imposta solo gli attributi valorizzati
        $no_empty_params = array();
        $no_empty_params['attributes'] = array();
        
        foreach($params['attributes'] as $key => $attribute){
            if(!empty($attribute) && $attribute != '<?xml version="1.0" encoding="utf-8"?>
<section xmlns:image="http://ez.no/namespaces/ezpublish3/image/" xmlns:xhtml="http://ez.no/namespaces/ezpublish3/xhtml/" xmlns:custom="http://ez.no/namespaces/ezpublish3/custom/"/>
'){
                
               $no_empty_params['attributes'][$key] =  $attribute;
            }
        }
        //
        
        $newObject = eZContentFunctions::updateAndPublishObject( $object, $no_empty_params );
        if ( !$newObject )
        {
            throw new Exception( "Errore sincronizzando l'oggetto" );
        }
        $objectId = $object->attribute( 'id' );
        eZContentObject::clearCache( array( $objectId ) );
        return eZContentObject::fetch( $objectId );
    }
    
    /**
     * Cerca sul siteaccess locale tramite le KeyWord se esistono i tag uguali e
     * li imposta. Nel caso di Keyword uguali con nodo padre diverso questo metodo non funziona.
     * 
     * @param string $identifier
     * @param string $remoteTags
     */
    protected function createLocalTags( $identifier, $remoteTags ){
        $tag = "";
        
        $ezTagsArray = explode("|#", $remoteTags);

        // Verifico ci siano tags impostati
        if( !empty($ezTagsArray) ){
            // Verifico che la lunghezza dell'array sia un multiplo di 3
            if( count($ezTagsArray) % 3 == 0 ){
                $tagsNum = count($ezTagsArray) / 3;
                
                $tagIDs = "";
                $tagKeywords = "";
                $tagParents = "";
                
                for($i = $tagsNum; $i<$tagsNum*2; $i++){
                    $keyword = $ezTagsArray[$i];
                    
                    $ezTag = eZTagsObject::fetchByKeyword( $keyword );
                    
                    if(!empty($ezTag)){
                        $tagIDs .= $ezTag[0]->ID . '|#';
                        $tagKeywords .= $ezTag[0]->Keyword . '|#';
                        $tagParents .= $ezTag[0]->ParentID . '|#';
                    }
                }
                
                $tag = $tagIDs . $tagKeywords . $tagParents;
                $tag = substr($tag, 0, strlen($tag)-2);
            }
        }
        
        return $tag;
    }

}

