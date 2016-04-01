<?php

/**
 * Funzioni di utilità usate per l'importazione di playlist youtube.
 * 
 */
class PatBasePlaylistFunctions{
    
    /**
     * Forza l'importazione di una playlist alla prossima esecuzione
     * del cronjob.
     * 
     * Ritorna true se la playlist è stata rischedulata
     * 
     * @param int $parentNodeID
     * @return boolean
     */
    public static function forcePlaylistImport( $parentNodeID ){
        $limit = 1000;
        $offset = 0;
        
        $imports = SQLIScheduledImport::fetchList( $offset, $limit );
        
        foreach($imports as $import){
            if( $import instanceof SQLIScheduledImport ){
                $options = $import->getOptions();

                if( $options->hasAttribute('parentnodeid') ){
                    $_parentNodeID = $options->attribute('parentnodeid');
                    
                    if($parentNodeID == $_parentNodeID){
                        $db = eZDB::instance();
                        $db->begin();
                        
                        // Imposta il giorno precedente rispetto al timestamp attuale
                        $currentNextTime = $import->attribute('next');
                        $nextTimeInterval = '-1 day';
                        $nextTime = strtotime( $nextTimeInterval, $currentNextTime );
                        $import->setAttribute( 'next', $nextTime );
                        $import->store( array( 'next' ) );
                        
                        $db->commit();
                        
                        return true;
                    }
                }
            }
            else{
                throw new Exception( 'Classe errata!' );
            }
        }
        
        //echo("!");
        //die();
        return false;
    }
    
    /**
     * Ritorna vero se la playlist ha una data di schedulazione inferiore alla
     * data attuale
     * 
     * @param int $parentNodeID
     * @return boolean
     */
    public static function checkPlaylistImportScheduled( $parentNodeID ){
        $limit = 1000;
        $offset = 0;
       
        $imports = SQLIScheduledImport::fetchList( $offset, $limit );
        
        foreach($imports as $import){
            if( $import instanceof SQLIScheduledImport ){
                $options = $import->getOptions();

                if( $options->hasAttribute('parentnodeid') ){
                    $_parentNodeID = $options->attribute('parentnodeid');
                    
                    if($parentNodeID == $_parentNodeID){
                       
                        
                        // Legge la data della prossima shedulazione 
                        $currentNextTime = $import->attribute('next');
                        $currentTime = time();
                        
                        if($currentNextTime<$currentTime){
                            return true;
                        }
                        else{
                            return false;
                        }
                    }
                }
            }
        }
        
        return false;
    }
}
