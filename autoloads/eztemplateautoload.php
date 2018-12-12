<?php
$eZTemplateOperatorArray[] = array( 'script' => 'extension/pat_base/autoloads/patoperators.php',
                                    'class' => 'PatOperators',
                                    'operator_names' => array( 'class_attributes' ) );

// Operator: footer
$eZTemplateOperatorArray[] = array( 'class' => 'FooterOperator',
                                    'operator_names' => array( 'footer' ) );


// Operator: organigramma
$eZTemplateOperatorArray[] = array( 'script' => 'extension/pat_base/autoloads/patoperators.php',
                                    'class' => 'PatOperators',
                                    'operator_names' => array( 'organigramma' ) );

// Operator: http_header
$eZTemplateOperatorArray[] = array( 'script' => 'extension/pat_base/autoloads/patoperators.php',
                                    'class' => 'PatOperators',
                                    'operator_names' => array( 'http_header' ) );
// Operator: header_images
$eZTemplateOperatorArray[] = array( 'script' => 'extension/pat_base/autoloads/patoperators.php',
                                    'class' => 'PatOperators',
                                    'operator_names' => array( 'header_images' ) );

// Operator:  'it_fill_contacts_matrix', 'it_contacts_matrix_fields
$eZTemplateOperatorArray[] = array(
    'script' => 'extension/openpa/autoloads/it_papagedata.php',
    'class' => 'It_OpenPAPageData',
    'operator_names' => array(  'it_fill_contacts_matrix', 'it_contacts_matrix_fields' )
);
