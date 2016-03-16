<?php

/**
 * Classe per l'operatore di template
 * 
 * @author Stefano Ziller
 */
class FooterOperator{
    public $Operators;
    
    /** 
     * Nome dell'operatore
     * 
     * @param string $name
     */
    public function __construct( $name = 'footer' ){
        $this->Operators = array( $name );
    }
    
    /**
     * Elenco degli operatori
     * 
     * @return array
     */
    function operatorList(){
        return $this->Operators;
    }
    
    /**
     * Vero se la lista dei parametri esiste per operatore
     * 
     * @return boolean
     */
    public function namedParameterPerOperator(){
        return true;
    }
    
    /**
     * Parametri da assegnare agli operatori
     * 
     * @return type
     */
    public function namedParameterList(){
        return array( 'footer' => array( 'result_type' => array( 'type' => 'string',
                                                                'required' => true,
                                                                'default' => 'footer_notes' ))
                      );
    }

    /**
     * Switch sui possibili operatori
     * 
     * @param type $tpl
     * @param type $operatorName
     * @param type $operatorParameters
     * @param type $rootNamespace
     * @param type $currentNamespace
     * @param type $operatorValue
     * @param type $namedParameters
     */
    public function modify( $tpl, $operatorName, $operatorParameters,  $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters  ){
        
        $result_type = $namedParameters['result_type'];
        if( $result_type == 'footer_notes' ){
            $operatorValue = FooterTool::getFooterNotes();
        }
        else if( $result_type == 'footer_links' ){
            $operatorValue = FooterTool::getFooterLinks();
        }
        else if( $result_type == 'footer_banners' ){
            $operatorValue = FooterTool::getFooterBanners();
        }
        else if( $result_type == 'footer_contacts' ){
            $operatorValue = FooterTool::getFooterContacts();
        }
        else if( $result_type == 'footer_top_links' ){
            $operatorValue = FooterTool::getFooterTopLinks();
        }
        else if( $result_type == 'footer_bottom_links' ){
            $operatorValue = FooterTool::getFooterBottomLinks();
        }
    }
    
}