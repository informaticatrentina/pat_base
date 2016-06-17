<?php
 
/**
 * se viene effettuato l'import di un comunicato o alla sua modifica 
 * deve essere impostata la data di pubblicazione in base al campo 
 * della classe denominato published
 */
class ImportComunicatiType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "importcomunicati";    
    const PUBLISH_CLASS = 'comunicato';
    
    
    public function __construct()
    {
        $this->eZWorkflowEventType( self::WORKFLOW_TYPE_STRING, 'Import Comunicati Change State' );
    }
 
    public function execute( $process, $event )
    {
        //echo('*** workflow importcomunicati ***<pre>');
        
        $parameters = $process->attribute( 'parameter_list' );
        
        try
        {
            $object = eZContentObject::fetch( $parameters['object_id'] );
            // if a newer object is the current version, abort this workflow.
            $currentVersion = $object->attribute( 'current_version' );
            $version = $object->version( $parameters['version'] );
            $classIdentifier = $version->ContentObject->ClassIdentifier;
            // Verifica se la classe è corretta
            if ($classIdentifier == self::PUBLISH_CLASS ){
                
                $objectAttributes = $version->attribute( 'contentobject_attributes' );
                // cicla sugl iattributi
                foreach ( $objectAttributes as $objectAttribute )
                {
                    $contentClassAttributeIdentifier = $objectAttribute->ContentClassAttributeIdentifier;
                    if ($contentClassAttributeIdentifier == 'published'){       
                        // recupera la data di pubblicazione
                        $publisheddate = $objectAttribute->attribute( 'content' );
                    }
                }
                // set della data di pubblicazione
                if ( $publisheddate instanceof eZDateTime || $publisheddate instanceof eZDate )
                {
                    $object->setAttribute( 'published', $publisheddate->timeStamp() );
                    $object->store();
                    eZContentOperationCollection::registerSearchObject( $object->attribute( 'id' ) );
                    eZDebug::writeNotice( 'Workflow change object publish date', __METHOD__ );
                }
                //echo('<br>*** die workflow ***');
                //die();  
            }
            return eZWorkflowType::STATUS_ACCEPTED;    
        }
        catch( Exception $e )
        {
            eZDebug::writeError( $e->getMessage(), __METHOD__ );
            return eZWorkflowType::STATUS_REJECTED;
        }
    }
}
eZWorkflowEventType::registerEventType( ImportComunicatiType::WORKFLOW_TYPE_STRING, 'ImportComunicatiType' );
