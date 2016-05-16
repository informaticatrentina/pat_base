<?php
 
/**
 * La modifica di uno stato viene propagata a tutti i nodi figli del
 * nodo attuale in modo ricorsivo. I gruppi di stati per cui è
 * attiva la propagazione devono venire configurati nel patbase.ini
 */
class ChildsPropagationStateType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "childspropagationstate";
    
    public function __construct()
    {
        $this->eZWorkflowEventType( self::WORKFLOW_TYPE_STRING, 'Child Propagation State' );
    }
 
    public function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
     
        try
        {
            // WORKFLOW HERE
            if ( $parameters['trigger_name'] == 'post_updateobjectstate' )
            {
                $objectId = $parameters['object_id'];
                $object = eZContentObject::fetch( $objectId );
                $parentStateIDArray = $object->stateIDArray();
                
                $fetch_parameters = array(
                                            'parent_node_id' => $object->mainNodeID()
                                         );
                $childs = eZFunctionHandler::execute('content', 'list', $fetch_parameters);

                $stateGroups = eZINI::instance( 'patbase.ini' )->variable( 'ChildsPropagationState', 'StateGroupID' );
                
                foreach( $childs as $child ){
                    $childStateIDArray = $child->object()->stateIDArray();

                    $stateChanged = FALSE;
                    foreach( $stateGroups as $stateGroup ){
                        
                        if( $childStateIDArray[ $stateGroup ] !== $parentStateIDArray[ $stateGroup ] ){
                            $stateChanged = TRUE;
                            
                            $childStateIDArray[ $stateGroup ] = $parentStateIDArray[ $stateGroup ];
                        }
                    }
                    
                    if( $stateChanged ){
                        eZOperationHandler::execute( 'content', 'updateobjectstate', 
                                                      array( 'object_id' => $child->ContentObjectID, 
                                                             'state_id_list' => $childStateIDArray ) );
                    }
                }

            }
            else if( $parameters['trigger_name'] == 'post_publish' )
            {
                if( $parameters['version'] === '1' ) // SOLO CREAZIONE
                {
                    $objectId = $parameters['object_id'];
                    $object = eZContentObject::fetch( $objectId );
                    $objectStateIDArray = $object->stateIDArray();

                    $fetch_parameters = array(
                                                'node_id' => $object->mainParentNodeID()
                                             );
                    $parent = eZFunctionHandler::execute('content', 'node', $fetch_parameters);

                    $stateGroups = eZINI::instance( 'patbase.ini' )->variable( 'ChildsPropagationState', 'StateGroupID' );

                    $parentStateIDArray = $parent->object()->stateIDArray();

                    $stateChanged = FALSE;
                    foreach( $stateGroups as $stateGroup ){
                        if( $objectStateIDArray[ $stateGroup ] !== $parentStateIDArray[ $stateGroup ] ){
                            $stateChanged = TRUE;

                            $objectStateIDArray[ $stateGroup ] = $parentStateIDArray[ $stateGroup ];
                        }
                    }

                    if( $stateChanged ){
                        eZOperationHandler::execute( 'content', 'updateobjectstate', 
                                                      array( 'object_id' => $objectId, 
                                                             'state_id_list' => $objectStateIDArray ) );
                    }
                }
            }
            //
            
            return eZWorkflowType::STATUS_ACCEPTED;    
        }
        catch( Exception $e )
        {
            eZDebug::writeError( $e->getMessage(), __METHOD__ );
            return eZWorkflowType::STATUS_REJECTED;
        }
    }
}
eZWorkflowEventType::registerEventType( ChildsPropagationStateType::WORKFLOW_TYPE_STRING, 'ChildsPropagationStateType' );
