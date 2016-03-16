<?php

/**
 * Classe per l'esecuzione delle funzionalità dell'operatore
 * 
 */
class FooterTool{
    
    /**
     * Carica il nodo radice
     * 
     * @return node
     */
    private static function fetchRootNode(){
        $_home = eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' );
        $home = eZContentObjectTreeNode::fetch( $_home );
        
        return $home;
    }
    
    /**
     * Carica il nodo Media radice
     * 
     * @return node
     */
    private static function fetchMediaRootNode(){
        $_media = eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'MediaRootNode' );
        $media = eZContentObjectTreeNode::fetch( $_media );
        
        return $media;
        
    }
    
    /**
     * Carica l'attributo footer_notes prendendolo dal nodo radice
     * 
     * @return attribute
     */
    public static function getFooterNotes(){
        $result = '';
        $home = FooterTool::fetchRootNode();
        
        if($home->attribute('class_identifier') == 'frontpage'){
            $dataMap = $home->attribute( 'data_map' );
            
            if(isset($dataMap['note_footer'])){
                $result = $dataMap['note_footer'];
                
                return $result;
            }
            
        }
        
        return $result;
    }
    
    /**
     * Carica l'elenco dei Link relazionati alla Homepage
     * 
     * @return array
     */
    public static function getFooterLinks(){
        $result = array();
        $home = FooterTool::fetchRootNode();
        
        if($home->attribute('class_identifier') == 'frontpage'){
            $dataMap = $home->attribute( 'data_map' );
            
            if(isset($dataMap['link_nel_footer'])){
                $content = $dataMap['link_nel_footer']->attribute( 'content' );
                foreach( $content['relation_list'] as $item ) {
                    if ( isset( $item['node_id'] ) ){
                        $node = eZContentObjectTreeNode::fetch( $item['node_id'] );
                        
                        if( $node->attribute('class_identifier') == 'link' ){
                            $result[] = $node;
                        }
                    }
                }
            }
        }
        
        return $result;
    }
    
    /**
     * Carica l'elenco dei Banner relazionati alla Homepage
     * 
     * @return array
     */
    public static function getFooterBanners(){
        $result = array();
        $home = FooterTool::fetchRootNode();
        
        if($home->attribute('class_identifier') == 'frontpage'){
            $dataMap = $home->attribute( 'data_map' );
            
            if(isset($dataMap['link_nel_footer'])){
                $content = $dataMap['link_nel_footer']->attribute( 'content' );
                foreach( $content['relation_list'] as $item ) {
                    if ( isset( $item['node_id'] ) ){
                        $node = eZContentObjectTreeNode::fetch( $item['node_id'] );
                        
                        if( $node->attribute('class_identifier') == 'banner' ){
                            $result[] = $node;
                        }
                    }
                }
            }
        }
        
        return $result;
    }
    
    /**
     * Carica i contatti dal nodo radice (Matrice contacts)
     * 
     * @return array
     */
    public static function getFooterContacts(){
        $data = array();
        $homePage = FooterTool::fetchRootNode();
        
        if ( $homePage instanceof eZContentObjectTreeNode  ){
            $homeObject = $homePage->attribute( 'object' );
            if ( $homeObject instanceof eZContentObject ){
                
                $dataMap = $homeObject->attribute( 'data_map' );
                if ( isset( $dataMap['contacts'] )
                     && $dataMap['contacts'] instanceof eZContentObjectAttribute
                     && $dataMap['contacts']->attribute( 'data_type_string' ) == 'ezmatrix'
                     && $dataMap['contacts']->attribute( 'has_content' ) ){
                
                    $trans = eZCharTransform::instance();
                    $matrix = $dataMap['contacts']->attribute( 'content' )->attribute( 'matrix' );
                    foreach( $matrix['rows']['sequential'] as $row ){                        
                        $columns = $row['columns'];
                        $name = $columns[0];
                        $identifier = $trans->transformByGroup( $name, 'identifier' );
                        
                        if ( !empty( $columns[1] ) ){
                            $data[$identifier] = $columns[1];
                        }
                    }
                }
                else{
                    if( isset( $dataMap['facebook'] )
                        && $dataMap['facebook'] instanceof eZContentObjectAttribute
                        && $dataMap['facebook']->attribute( 'has_content' ) ){
                        $data['facebook'] = $dataMap['facebook']->toString();
                    }
                    if( isset( $dataMap['twitter'] )
                        && $dataMap['twitter'] instanceof eZContentObjectAttribute
                        && $dataMap['twitter']->attribute( 'has_content' ) ){
                        $data['twitter'] = $dataMap['twitter']->toString();
                    }
                }
            }
        }
        
        return $data;
    }
    
    /**
     * I link da riportare nella parte alta del footer, vengono inseriti in una
     * matrice chiamata footer_link_top nella classe Homepage
     * 
     * @return array
     */
    public static function getFooterTopLinks(){
        $data = array();
        $homePage = FooterTool::fetchRootNode();
        
        if ( $homePage instanceof eZContentObjectTreeNode  ){
            $homeObject = $homePage->attribute( 'object' );
            if ( $homeObject instanceof eZContentObject ){
                
                $dataMap = $homeObject->attribute( 'data_map' );
                if ( isset( $dataMap['footer_link_top'] )
                     && $dataMap['footer_link_top'] instanceof eZContentObjectAttribute
                     && $dataMap['footer_link_top']->attribute( 'data_type_string' ) == 'ezmatrix'
                     && $dataMap['footer_link_top']->attribute( 'has_content' ) ){
                
                    $trans = eZCharTransform::instance();
                    $matrix = $dataMap['footer_link_top']->attribute( 'content' )->attribute( 'matrix' );
                    foreach( $matrix['rows']['sequential'] as $row ){                        
                        $columns = $row['columns'];
                        $name = $columns[0];
                        $identifier = $trans->transformByGroup( $name, 'identifier' );
                        
                        if ( !empty( $columns[1] ) ){
                            $data[$identifier] = $columns[1];
                        }
                    }
                }
            }
        }
        
        return $data;
    }
    
    /**
     * I link da riportare nella parte bassa del footer, vengono inseriti in una
     * matrice chiamata footer_link_bottom nella classe Homepage
     * 
     * @return array
     */
    public static function getFooterBottomLinks(){
        $data = array();
        $homePage = FooterTool::fetchRootNode();
        
        if ( $homePage instanceof eZContentObjectTreeNode  ){
            $homeObject = $homePage->attribute( 'object' );
            if ( $homeObject instanceof eZContentObject ){
                
                $dataMap = $homeObject->attribute( 'data_map' );
                if ( isset( $dataMap['footer_link_bottom'] )
                     && $dataMap['footer_link_bottom'] instanceof eZContentObjectAttribute
                     && $dataMap['footer_link_bottom']->attribute( 'data_type_string' ) == 'ezmatrix'
                     && $dataMap['footer_link_bottom']->attribute( 'has_content' ) ){
                
                    $trans = eZCharTransform::instance();
                    $matrix = $dataMap['footer_link_bottom']->attribute( 'content' )->attribute( 'matrix' );
                    foreach( $matrix['rows']['sequential'] as $row ){                        
                        $columns = $row['columns'];
                        $name = $columns[0];
                        $identifier = $trans->transformByGroup( $name, 'identifier' );
                        
                        if ( !empty( $columns[1] ) ){
                            $data[$identifier] = $columns[1];
                        }
                    }
                }
            }
        }
        
        return $data;
    }
}
