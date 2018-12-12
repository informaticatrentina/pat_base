<?php

class It_OpenPAPageData
{
    public static $contactsMatrixFields = array(
        "Telefono",
        "Fax",
        "Email",
        "PEC",
        "Indirizzo",        
        "Facebook",
        "Twitter",
        "Web",
        "Codice fiscale",
        "Partita IVA",
        "Codice iPA",
        "Via",
        "Numero Civico",
        "CAP",
        "Comune",
        "Latitudine",
        "Longitudine",
        "Linkedin",
        "Instagram",
        "Rss"
    );

    function operatorList()
    {
        return array( 'it_fill_contacts_matrix', 'it_contacts_matrix_fields' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(            
            'it_fill_contacts_matrix' => array(
                'attribute' => array( 'type' => 'object', 'required' => true ),
                'fields' => array( 'type' => 'array', 'required' => false, 'default' => self::$contactsMatrixFields )
            ),
        );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'it_contacts_matrix_fields':
            {
                $operatorValue = self::$contactsMatrixFields;
                // Se esiste l'ini repuera oi dati da lì
                $patBaseContactsMatrixFields = eZINI::instance( 'patbase.ini' )->variable( 'ContactsMatrixFields', 'Field' );
                is_array($patBaseContactsMatrixFields) ? $patBaseContactsMatrixFields : $operatorValue;
                $operatorValue = $patBaseContactsMatrixFields;
            } break;

            case 'it_fill_contacts_matrix':
            {
                
                $attribute = $namedParameters['attribute'];
                $fields = $namedParameters['fields'];
                $existingFields = array();
                if ( $attribute instanceof eZContentObjectAttribute )
                {
                    $matrix = $attribute->attribute( 'content' );
                    if ( $attribute->hasContent() )
                    {
                        $rows = $matrix->attribute( 'rows' );                        
                        foreach( $rows['sequential'] as $row )
                        {
                            if ( in_array( $row['columns'][0], $fields ) )
                            {
                                $existingFields[] = $row['columns'][0];
                            }
                        }
                    }
                    foreach( $fields as $field )
                    {
                        if ( !in_array( $field, $existingFields ) )
                        {
                            $matrix->addRow();
                        }
                    }
                    
                    $attribute->setAttribute( 'data_text', $matrix->xmlString() );
                    $matrix->decodeXML( $attribute->attribute( 'data_text' ) );
                    $attribute->setContent( $matrix );
                    $attribute->store();                    
                }
                $operatorValue = $attribute;
               
            } break;
        }
    }

    function getContactsData()
    {
        $data = array();
        $homePage = OpenPaFunctionCollection::fetchHome();
        if ( $homePage instanceof eZContentObjectTreeNode  )
        {
            $homeObject = $homePage->attribute( 'object' );
            if ( $homeObject instanceof eZContentObject )
            {
                $dataMap = $homeObject->attribute( 'data_map' );
                if ( isset( $dataMap['contacts'] )
                     && $dataMap['contacts'] instanceof eZContentObjectAttribute
                     && $dataMap['contacts']->attribute( 'data_type_string' ) == 'ezmatrix'
                     && $dataMap['contacts']->attribute( 'has_content' ) )
                {
                    $trans = eZCharTransform::instance();
                    $matrix = $dataMap['contacts']->attribute( 'content' )->attribute( 'matrix' );
                    foreach( $matrix['rows']['sequential'] as $row )
                    {                        
                        $columns = $row['columns'];
                        $name = $columns[0];
                        $identifier = $trans->transformByGroup( $name, 'identifier' );
                        if ( !empty( $columns[1] ) )
                        {
                            $data[$identifier] = $columns[1];
                        }
                    }
                }
                else
                {
                    if( isset( $dataMap['facebook'] )
                        && $dataMap['facebook'] instanceof eZContentObjectAttribute
                        && $dataMap['facebook']->attribute( 'has_content' ) )
                    {
                        $data['facebook'] = $dataMap['facebook']->toString();
                    }
                    if( isset( $dataMap['twitter'] )
                        && $dataMap['twitter'] instanceof eZContentObjectAttribute
                        && $dataMap['twitter']->attribute( 'has_content' ) )
                    {
                        $data['twitter'] = $dataMap['twitter']->toString();
                    }
                }
            }
        }
        return $data;
    }
}
