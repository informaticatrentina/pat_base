<?php

class PatOperators
{

    function PatOperators()
    {
        $this->Operators= array( 'class_attributes', 'organigramma' );
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(
            'class_attributes' => array( 
                'params' 	=> array( 'type' 	=> 'array',	'required' => true )                
            ),
            'organigramma' => array( 
                                    'node_id' =>  array( 'type' => 'int',
                                                         'required' => true,
                                                         'default' => '2' )                
                                    ),
            'http_header' => array('header' => array('type' => 'string',
                                                     'required' => true ),
                                   'status_code' => array('type' => 'int',
                                                            'required' => false,
                                                            'default' => 0 )
                                  )
        );
    }
    
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
		
        switch ( $operatorName )
        {
            case 'class_attributes':
            {
                $operatorValue = $this->getClassAttributes( $namedParameters['params'] );                
            } break;
        
            case 'organigramma':
                {
                    $nodeID = $namedParameters['node_id'];
                    $operatorValue = PatOrganigramma::getOrganigrammaTree($nodeID);
                }
                break;
            
            case 'http_header':
                {
                    echo 'ciao';
                    die();
                    $header = $namedParameters['header'];
                    $status_code = $namedParameters['status_code'];
                    if ( $status_code != 0 )
                    {
                        header( $header, true, $status_code );
                    }
                    else
                    {
                        header( $header );
                    }
                    $operatorValue = '';
                }
                break;

        }
    }
    
    function getClassAttributes( $attribute_names = array() )
    {
        $debug = false;
        
        $db = eZDb::instance();
        $ret = array();
        $result = array();
        $result2 = array();
    
        if (count($attribute_names)>1) {
            foreach ($attribute_names as $key => $attribute_name) {
                $sql = "SELECT tmp.id, tmp.identifier from (select ezcontentclass.id, ezcontentclass.identifier from ezcontentclass,ezcontentclass_attribute where (ezcontentclass.id=ezcontentclass_attribute.contentclass_id AND ezcontentclass_attribute.identifier='servizio')) as tmp, ezcontentclass_attribute where tmp.id=ezcontentclass_attribute.contentclass_id AND ezcontentclass_attribute.identifier='argomento'";
                $ret[] = $db->arrayQuery( $sql );
            }
        } else {
            foreach ($attribute_names as $key => $attribute_name) {
                $sql = "SELECT ezcontentclass.id, ezcontentclass.identifier 
                FROM ezcontentclass_attribute, ezcontentclass 
                WHERE ezcontentclass.id=ezcontentclass_attribute.contentclass_id 
                AND ezcontentclass_attribute.identifier='" . $attribute_name . "'";
                $ret[] = $db->arrayQuery( $sql );
            }
        }
    
        if ( $debug )
            ezDebug::writeNotice( $ret[0], 'getClassAttributes: risultato per '.implode(',', $attribute_names) );
            
            return $ret[0];
    
    }
}

?>
