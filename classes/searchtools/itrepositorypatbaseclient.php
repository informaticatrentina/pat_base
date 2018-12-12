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

    /**
     * Sostituisco il metodo originale causa utilizzo di eZTags 1.3
     *
     * @param eZModule $module
     * @param eZTemplate $tpl
     * @param $repositoryNodeID
     * @param $localParentNodeID
     *
     * @throws Exception
     */
    protected function handleTagChooserImport(
        eZModule $module,
        eZTemplate $tpl,
        $repositoryNodeID,
        $localParentNodeID,
        &$Result
    )
    {
        if ( isset( $this->attributes['definition']['AskTagTematica'] )
            && $this->attributes['definition']['AskTagTematica'] == true )
        {
            $http = eZHTTPTool::instance();

            if( !$http->hasPostVariable( 'SelectTags' ) ){
                $tpl->setVariable( 'fromPage', '/repository/import/' . $this->attributes['definition']['Identifier']. '/' . $repositoryNodeID );
                $tpl->setVariable( 'localParentNodeID', $localParentNodeID );

                $Result['content'] = $tpl->fetch( 'design:repository/eztagschooser.tpl' );
                $Result['path'] = array( array( 'url' => false,
                    'text' => 'Scegli Tag' ) );

                return;
            }
            else
            {
                $tagIDs = array();
                $tagKeywords = array();
                $tagParents = array();

                foreach( $_POST as $key => $value )
                {
                    if( substr( $key, 0, 8 ) == 'tematica' ){
                        list($tagID, $tagKeyword, $tagParent) = explode(";", $value);
                        $tagIDs[] = $tagID;
                        $tagKeywords[] = $tagKeyword;
                        $tagParents[] = $tagParent;
                    }
                }
            }

            $newObject = $this->import( $repositoryNodeID, $localParentNodeID );

            foreach( $newObject->contentObjectAttributes() as $attribute){
                if($attribute->contentClassAttributeIdentifier() == 'tematica'){
                    $eZTags = new eZTags();

                    $eZTags->createFromStrings( implode('|#', $tagIDs), implode('|#', $tagKeywords), implode('|#',$tagParents) );
                    $eZTags->store( $attribute );

                    break;
                }
            }

            $module->redirectTo( $newObject->attribute( 'main_node' )->attribute( 'url_alias' ) );
        }
        else
        {
            $newObject = $this->import( $repositoryNodeID, $localParentNodeID );
            $module->redirectTo( $newObject->attribute( 'main_node' )->attribute( 'url_alias' ) );
        }
    }
}
