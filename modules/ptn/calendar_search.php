<?php
/**
 * Esegue una ricerca su vivoscuola utilizando ezfind e le faccette.
 */

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();
$currentUser = eZUser::currentUser();

$siteUrl = eZINI::instance()->variable( 'SiteSettings', 'SiteURL'  );

$module = $Params['Module'];
// Classi su cui eseguire la ricerca
$class_identifiers = $Params['Class'];

// Elenco degli attributi per cui estrarre le faccette
$attribute_identifiers = $Params['FacetAttributes'];

// Nodo contenitore in cui limitare la ricerca
$parent_node_id = $Params['ParentNodeID'];

try
{
    if(empty($class_identifiers)){
        throw new Exception('You must set Class Identifiers on URL');
    }
    if(empty($attribute_identifiers)){
        throw new Exception('You must set Attribute Identifier on URL');
    }
    
    // Parametri dal DataTable
    $draw = $_GET['draw'];
    $offset = $_GET['start'];
    $limit = $_GET['length'];
    $order = $_GET['order'];
    
    // Array delle classi da cercare
    $search_classes = explode('|', $class_identifiers);
   
    
    $sort_by = array();
    $order_col = $order[0];
    if( isset($order_col) ){    
        //
        // @TODO: fraccato!
        switch( $order_col['column'] ){
            case 0: $sort_by[$search_classes[0].'/'.'data'] = $order_col['dir']; break;
            case 1: $sort_by[$search_classes[0].'/'.'numero'] = $order_col['dir']; break;
            case 2: $sort_by[$search_classes[0].'/'.'titolo'] = $order_col['dir']; break;
            case 3: $sort_by[$search_classes[0].'/'.'proponente'] = $order_col['dir']; break;
        }
    }
    
    // Imposta le faccette da estrarre
    $search_attributes = explode('|', $attribute_identifiers);
    $facets = array();
    foreach( $search_attributes as $attribute_identifier ){
        foreach( $search_classes as $class_identifier){
            $facets[] = array('field' => $class_identifier.'/'.$attribute_identifier,
                              'limit' => 1000,
                              'sort' => 'alpha',
                              'mincount' => 0);
        }
    }
    
    // Imposta il filtro sulla ricerca
    $query = '';
    $filter = array();
    foreach($_GET as $attribute => $value){
        if( !empty($value) ){
            if($attribute === 'query'){
                $query = $value;
            }
            else if( in_array($attribute, $search_attributes) ){
                // metto in OR la ricerca sulle diverse classi
                $or_filter = array('or');
                foreach( $search_classes as $class_identifier){
                    $or_filter[] = $class_identifier . '/' . $attribute . ':' . '"' .$value .'"';
                }
                $filter[] = $or_filter;
            }
        }
    }
    
    //$soggetti = $_GET['soggetti'];
    
    $dateRange = $_GET['currentMonth'];
    try {
        $__from = new DateTime($dateRange);
        $dataIni = $__from->format('Y-m-d');
        date_modify($__from, '+1 month');
        date_modify($__from, '-1 day');
        $dataFin = $__from->format('Y-m-d');
        
    } catch (Exception $e) {}
 
    /* Ricerca per data*/
    
    if( !empty($dateRange) ){
        
        // Filtro tra 2 date
        $and_filter = array('and');   
        

        $and_filter[] = $class_identifiers . '/from_time:[* TO ' . $dataFin . 'T23:59:999Z' .']';
        $and_filter[] = $class_identifiers . '/to_time:[' .  $dataIni . 'T00:00:000Z' . ' TO *]';

        $or_filter = array('or');

        $or_filter[] = $and_filter;
        $or_filter[] = $class_identifiers . '/from_time:[' .  $dataIni . 'T00:00:000Z' . ' TO ' . $dataFin . 'T23:59:999Z' .']';

        
        $filter[] = $or_filter;
    }
    
    $fetch_parameters = array(
        'query' => $query,
        'offset' => $offset,
        'limit' => $limit,
        'facet' => $facets,
        'class_id' => ( is_array($search_classes) ? $search_classes : array( $search_classes ) )
    );
    
    
    if( !empty($filter) ){
        $fetch_parameters['filter'] = array('filter' => $filter);
    }
    
    //echo("<pre>");
    //print_r($fetch_parameters);
    //die();
    // @Fraccato imposta l'ordinamento per data di pubblicazione in EZ
    //
    if( !empty($sort_by) ){
       $fetch_parameters['sort_by'] = $sort_by;
    }else{
       $fetch_parameters['sort_by'] = array( 'published' => 'desc'  ) ; 
    }
 
    
    // @Fraccato imposta l'ordinamento per data di pubblicazione in EZ
    //$fetch_parameters['sort_by'] = array( 'published' => 'desc'  ) ;
    
    if( !empty($parent_node_id) ){
        $fetch_parameters['subtree_array'] = array($parent_node_id);
    }
    //echo("<pre>");
    //print_r($fetch_parameters);
    //die();
    
    $result = eZFunctionHandler::execute('ezfind', 'search', $fetch_parameters);
    //echo("<pre>");
    //print_r($fetch_parameters);
    //die()
    $hiddenCount = 0;
    $searchResult = $result['SearchResult'];
    $resultData = array();
    if( !empty($searchResult) ){
        foreach( $searchResult as $resultNode ){
            if(!$resultNode->IsHidden || $currentUser->Login != "anonymous"){
                $dataMap = $resultNode->dataMap();

                $parent_url = 'https://' . $siteUrl . '/content/view/full/' . $resultNode->ParentNodeID;
                $node_url = 'https://' . $siteUrl . '/content/view/full/' . $resultNode->MainNodeID;
                $aryTime = null;
                $aryToTime=null;
                $date = new eZDate( $dataMap['data']->DataInt );
                $name = $dataMap['titolo']->DataText;
                if(empty($name)){
                    $name=$resultNode->ContentObject->Name;
                }
                
                $dayEvents = array();  
                $dayEvents['name'] = $name;                
                $dayEvents['titolo'] = $dataMap['titolo']->DataText;
                $dayEvents['sotto_titolo'] = $dataMap['short_title']->DataText;                
                $dayEvents['full_link'] = $node_url;
                //date evento
                if($dataMap['from_time']->DataInt != 0){
                    $from_time = new eZDateTime( $dataMap['from_time']->DataInt );  
                    if ($from_time!=null){
                        $from_timeDal = date( 'd/m/Y', $from_time->DateTime );                        
                        $aryTimes =  explode( ':', $from_time->toString(false) );
                        // Toglie i millisecondi
                        $aryTime = $aryTimes[0] . ':' . $aryTimes[1];
                    }                   
                }
                $from_timeAl = null;
                if($dataMap['to_time']->DataInt != 0){
                    $to_time= new eZDateTime( $dataMap['to_time']->DataInt );                  
                    if ($to_time!=null){
                        $from_timeAl = date( 'd/m/Y', $to_time->DateTime );                        
                        $aryToTimes =  explode( ':', $to_time->toString(false) );
                        // Toglie i millisecondi
                        $aryToTime = $aryToTimes[0] . ':' . $aryToTimes[1];
                    }
                }
                $dayEvents['DataDal'] = ($from_timeDal!=null ? $from_timeDal : "");
                $dayEvents['DataDalCompleta'] = ($aryTime!=null ? $aryTime : "");
                $dayEvents['DataAl'] = ($from_timeAl!=null ? $from_timeAl : ""); 
                $dayEvents['DataAlCompleta'] = ($aryToTime!=null ? $aryToTime : "");
                // Data Pubblicazione
                $timestampPublishedDate = strtotime($resultNode->LocalAttributeValueList['published']);
                $date = new eZDate($timestampPublishedDate);
                $dayEvents['DataPubblicazione'] = $date->toString(true);     
                // Ricava la 1° Immagine in formato widelarge della gallery
                $ids = explode( '-', $dataMap['immagini']->toString() );                  
                 if ( count($ids) > 0 and ($ids[0] =='') ){                  
                    //recupera l'immagine di default
                    $parentNode = eZContentObjectTreeNode::fetch( $resultNode->ParentNodeID ) ;
                    $dataMapNode = $parentNode->dataMap();
                    $ids = explode( '-', $dataMapNode['image']->toString() ); 
                }
                if ( count($ids) > 0 and ($ids[0] !='') ){
                    $imagine = eZContentObject::fetch( $ids[0] ) ;
                    $imgAttribute=$imagine->dataMap()['image'];
                    $widelargeImage = $imgAttribute->content()->attribute( 'widelarge' );
                    $imgUrl = $widelargeImage['url'];
                }else{
                    $imgUrl = '';
                }    
                
                $dayEvents['widelargeImage'] =$imgUrl;
                ////print_r($imgUrl);
                //die();
                $resultData[] = $dayEvents;
    
            }
            else{
                $hiddenCount++;
            }
            //
        }        
    }
    
    $json_result = array(
        'draw' => $draw,
        'recordsTotal' => $result['SearchCount'] - $hiddenCount,
        'recordsFiltered' => $result['SearchCount'] - $hiddenCount,
        'data' => $resultData,
        'FacetFields' => $result['SearchExtras']->attribute('facet_fields'),
        'GET' => $_GET,
        'FetchParameters' => $fetch_parameters
    );
    
    header('Content-Type: application/json');
    echo json_encode($json_result);
    
} catch (Exception $e) {
    echo json_encode(
                        array( 
                                'Error' => $e->getMessage(),
                                'Line' => $e->getLine(),
                                'Trace' => $e->getTraceAsString()
                             )
                    );
}

eZExecution::cleanExit();
