<?php

/**
 * 
 * Modifica della funzione di import della classe OCRepositoryContentClassClient
 * 
 */
class ITRepositoryPatBaseClient extends OCRepositoryContentClassClient {
    
    /**
     * @param int $remoteNodeID
     * @param int $localParentNodeID
     *
     * @return eZContentObject
     * @throws Exception
     */
    public function import( $remoteNodeID, $localParentNodeID )
    {
       
        if ( !class_exists( 'ITOpenDataApiNode' ) )
        {
            throw new Exception( "Classe ITOpenDataApiNode non trovata" );
        }
        $apiNodeUrl = rtrim( $this->attributes['definition']['Url'], '/' ) . '/api/opendata/v1/content/node/' . $remoteNodeID;
        $remoteApiNode = ITOpenDataApiNode::fromLink( $apiNodeUrl );
        
        if ( !$remoteApiNode instanceof ITOpenDataApiNode )
        {
            throw new Exception( "Url remoto \"{$apiNodeUrl}\" non raggiungibile" );
        }
               
        $newObject = $remoteApiNode->createContentObject( $localParentNodeID );

        if ( !$newObject instanceof eZContentObject )
        {            
            throw new Exception( "Fallita la creazione dell'oggetto da nodo remoto" );
        }
        $rowPending = array(
            'action'        => self::ACTION_SYNC_OBJECT,            
            'param'         => $newObject->attribute( 'id' )
        );        
        $pendingItem = new eZPendingActions( $rowPending );
        $pendingItem->store();
        return $newObject;
    }
    
}
