<?php

/**
 * Funzioni di utilità usate per il colore di base di un site.
 * 
 */
class PatBaseColorFunctions{
    
    /**
     * Forza l'impostazione del colore di base di un site
     * 
     * Ritorna true se il colore è stato modificato
     * 
     * @param int $currentColor
     * @return boolean
     */
    public static function forceSiteColor( $currentColor ){
        
        //
        // lettura variabili per individuare file scss
        $designINIinstance = eZINI::instance('design.ini', 'settings', null, FALSE);
        $_stylesheetBaseFile = $designINIinstance->variable( 'StylesheetSettings', 'StylesheetBaseFile' );
        $_stylesheetDestFile = $designINIinstance->variable( 'StylesheetSettings', 'StylesheetDestinationFile' );
        $_stylesheetCluster = $designINIinstance->variable( 'StylesheetSettings', 'StylesheetCluster' );
       
        // Cicla sui file di origine
        for ($i = 0; $i < count($_stylesheetBaseFile) ; $i++) {

            foreach( $_stylesheetCluster as $itemCluster ){
                // File da sostituire.
                $curFile = $itemCluster.$_stylesheetBaseFile[$i];
                $curDestinationFile = $itemCluster.$_stylesheetDestFile[$i];                
                //print_r('File :<br><b>');
                //print_r($curFile);
                //print_r('<br>in:<br><b>');
                //print_r($curDestinationFile);
                //die();
                
                // recupera i valori del eZPersistentObject sinet_site_colors
                $colorList = Sinetsitecolors_PstObject::fetchHandlerList();
                   
                $fh = fopen($curFile,'r');
                $newRow = '';
                // Legge ogni singola riga del file origine
                $arrayOriginalColor = explode("-", $currentColor); 

                while (!feof($fh)) {
                   $tmpRow = fgets($fh);
                   
                   $indiceColore =0;
                   foreach( $colorList as $objColor ) 
                   {
                       // per ogni riga del pesisten object sostituisce il name_tag con il colore letto
                       $curname_tag = $objColor['name_tag'];                       
                       if (count($arrayOriginalColor) > $indiceColore){
                        $tmpRow = PatBaseColorFunctions::replaceCssInLine($tmpRow,$arrayOriginalColor[$indiceColore],$curname_tag); 
                       }
                       $indiceColore++;
                   } 
                   $newRow .= $tmpRow;
                }
                
                // set del colore nel persistent object
                $indiceColore =0;
                foreach( $colorList as $objColor ) 
                {   
                   $curname_tag = $objColor['name_tag'];
                   $curId = $objColor['id'];
                   if (count($arrayOriginalColor) > $indiceColore){                                           
                        $simpleObj = Sinetsitecolors_PstObject::fetchById($curId);                          
                        $simpleObj->setAttribute( 'color', $arrayOriginalColor[$indiceColore] );                      
                        $simpleObj->store();  
                   }  
                   $indiceColore++;
                }
                // Scrive il file di destinazione
                $fw = fopen($curDestinationFile,'w');
                if (!$fw) {
                    echo('</b><font color=red>Errore Open W</font></pre>');
                }
                else {
                        $bytes = fwrite($fw, $newRow);
                        fclose($fw);
                }
                fclose($fh);   
                // echo('</b><font color=red>OK</font></pre>');
            }
        } 
        // Prova la pulizia della cache dei template           
        eZContentCacheManager::clearAllContentCache();
        eZContentCacheManager::clearContentCache(2);
        //die(); 
        return true;
        
    }
    
    public static function replaceCssInLine($tmpRow,$currentColor,$cssTag) {
        

        $pos = strpos($tmpRow, $cssTag);     
        if ($pos > 0 ) {
            $pieces = explode("#", $tmpRow);  
            $tmpRow = $pieces[0]."#".$currentColor." !default\r\n";
        }         
        return $tmpRow;
    }
            
    public static function alter_brightness($colourstr, $steps) {
        
        //Take off the #
        $colourstr    = str_replace( '#', '', $colourstr );
        // Steps should be between -255 and 255. Negative = darker, positive = lighter
        $steps  = max( -255, min( 255, $steps ) );
        // Transform colors of type #fff to #ffffff
        if ( 3 == strlen( $colourstr ) ) {
            $colourstr    = str_repeat( substr( $colourstr, 0, 1 ), 2 ) . str_repeat( substr( $colourstr, 1, 1 ), 2 ) . str_repeat( substr( $colourstr, 2, 1 ), 2 );
        }
        // Modify the brigthness of each component
        $rgb=array(substr($colourstr,0,2),  substr($colourstr,2,2), substr($colourstr,4,2));
        for($i = 0; $i< count($rgb); $i++){
          $rgb[$i] = str_pad(dechex(max(0,min(255, hexdec($rgb[$i]) + $steps))),2,"0",STR_PAD_LEFT) ;
        }
        return implode('', $rgb);
    }
    
    public static function fetchSiteColors()
    {
       
        $result = array();  
         
        $userListPostHandler = Sinetsitecolors_PstObject::fetchHandlerList();
       
        return array( 'result' => $userListPostHandler );
    }
    
}
