<?php

/**
 * Customizzazione per agggiungere il parametro rel=0
 * al embed di youtube.
 *
 * @author Stefano Ziller
 */
class youtubehandler implements OCCustomEmbedHandlerInterface {
    
    public static function regex() {
        return '#https?://(www\.)?youtube.com/watch.*#i';
    }
    
    /**
     * Aggiunta di rel=0 nel link all'interno dell'iframe
     * 
     * @param type $matches
     * @param type $url
     * @param type $args
     */
    public static function callback($matches, $url, $args) {
        $oembed = new OCoEmbed;
        $result = $oembed->get_html( $url, $args );   
        
        return str_replace("feature=oembed", "feature=oembed&rel=0", $result);
    }


}

?>