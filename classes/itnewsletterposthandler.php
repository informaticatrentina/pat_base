<?php

class ITNewsletterPostHandler {
    const INTERVAL_MONTH = 'P1M';
    const PICKER_DATE_FORMAT = 'd-m-Y';
    const FULLDAY_IDENTIFIER_FORMAT = 'Y-n-j';
    const DAY_IDENTIFIER_FORMAT = 'j';
    const MONTH_IDENTIFIER_FORMAT = 'n';
    const YEAR_IDENTIFIER_FORMAT = 'Y'; 
    
    protected $interval;
    
    protected $startDateArray;
    
    protected $facets = null;
    
    protected $filters = array();
    
    protected $query = '';
    
    public function __construct()
    {
        $this->setStartDate( date( self::YEAR_IDENTIFIER_FORMAT ), date( self::MONTH_IDENTIFIER_FORMAT ), date( self::DAY_IDENTIFIER_FORMAT ) );   
    }
    
    public static function fetchByObjectId( $id )
    {
        $self = new self();
        $self->setFilters( array( 'meta_id_si:' . $id ) );
        $results = $self->fetchResult( 1, 0 );
        if( count( $results ) > 0 )
        {
            return $results[0];
        }
        return false;
    }
    
        
    public function setFilters( $array )
    {
        $this->filters = $array;
    }

    public function setQuery( $query )
    {
        $this->query = $query;
        return $this;
    }
    
    public function setState( $state )
    {
        if ( is_array( $state ) )
        {
            $stateFilter = array();
            foreach( $state as $s )
            {
                $stateFilter[] = 'meta_object_states_si:' . $s;
            }
            $this->filters[] = $stateFilter;
        }
        else
        {
            $this->filters[] = 'meta_object_states_si:' . $state;
        }
        return $this;
    }
    
    public function setTag( $tag )
    {        
        $solrIdentifier = false;
        foreach( ITNewsletterPost::fields() as $field )
        {
            if ( $field['object_property'] == 'tags' )
            {
                $solrIdentifier = $field['solr_identifier']; //attr_argomento_lk
                break;
            }
        }
        
        if ( $solrIdentifier )
        {
            if ( is_array( $tag ) )
            {
                $tagFilter = array();
                foreach( $tag as $s )
                {
                    $tagFilter[] = $solrIdentifier . ':' . $s;
                }
                $this->filters[] = $tagFilter;
            }
            else
            {
                $this->filters[] = $solrIdentifier . ':' . $tag;
            }
        }
        return $this;
    }
        
    public function setInterval( $interval )
    {        
        $this->interval = $interval;
        $this->filters[] = $this->getDateFilter();
        return $this;
    }
    
    public function setStartDate( $year, $month, $day )
    {
        $this->startDateArray = array(
            'hour' => '00',
            'minute' => '00',
            'second' => '00',
            'month' => $month,
            'day' => $day,
            'year' => $year
        );
    }

    /**
     * @param int $limit
     * @param int $offset
     *
     * @return ITNewsletterPost[]
     */
    public function fetchResult( $limit = 10, $offset = 0 )
    {
        $solrResult = $this->fetch( $limit, $offset );
        $result = array();
        if ( $solrResult['SearchCount'] > 0 )
        {
            foreach( $solrResult['SearchResult'] as $item )
            {
                $result[] = ITNewsletterPost::instanceFromEzfindResultArray( $item );
            }
        }
        
        return $result;   
    }
    
    public function fetchCount()
    {
        $solrResult = $this->fetch( 1, 0 );        
        return $solrResult['SearchCount'];   
    }
    
    public function fetch( $limit = 10, $offset = 0 )
    {        
        $fieldsToReturn = array();
        foreach( ITNewsletterPost::fields() as $field )
        {
            $fieldsToReturn[] = $field['solr_identifier'];
        }
        
        $solrFetchParams = array(
            'SearchOffset' => $offset,
            'SearchLimit' => $limit,
            'Facet' => $this->facets,
            'SortBy' => array( 'published' => 'desc' ),
            'Filter' => $this->filters,
            'SearchContentClassID' => array( ITNewsletterPost::CLASS_IDENTIFIER ),
            'SearchSectionID' => null,
            'SearchSubTreeArray' => array( eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' ) ),
            'AsObjects' => false,
            'SpellCheck' => null,
            'IgnoreVisibility' => null,
            'Limitation' => null,
            'BoostFunctions' => null,
            'QueryHandler' => 'ezpublish',
            'EnableElevation' => true,
            'ForceElevation' => true,
            'SearchDate' => null,
            'DistributedSearch' => null,
            'FieldsToReturn' => $fieldsToReturn,
            'SearchResultClustering' => null,
            'ExtendedAttributeFilter' => array()
        );
        
        $solrSearch = new eZSolr();
        $tmp = $solrSearch->search( $this->query, $solrFetchParams );
        return $tmp;
    }
        
    protected function getDateFilter()
    {
        $startDateTime = DateTime::createFromFormat( 'H i s n j Y', implode( ' ', $this->startDateArray ), self::timezone() );
        $startTimeStamp = $startDateTime->format( 'U' );
        
        $endDateTime = clone $startDateTime;
        $this->addInterval( $endDateTime );
        $endTimeStamp = $endDateTime->format( 'U' );
        
        $endDateTime = $endTimeStamp > $startTimeStamp ? $endTimeStamp-- : $startTimeStamp--;
        $startDate = ezfSolrDocumentFieldBase::preProcessValue( $startTimeStamp, 'date' );        
        $endDate = ezfSolrDocumentFieldBase::preProcessValue( $endTimeStamp , 'date' );        
       
        if ( $endTimeStamp > $startTimeStamp )
            return array( 'meta_published_dt:[' . $startDate . ' TO ' . $endDate . ']' );
        else
            return array( 'meta_published_dt:[' . $endDate . ' TO ' . $startDate . ']' );
    }
    
    protected function addInterval( DateTime $date )
    {        
        if ( strpos( $this->interval, '-' ) !== false )
        {
            $interval = substr( $this->interval, 1 );
            $interval = new DateInterval( $interval );
            if ( !$interval instanceof DateInterval )
            {
                throw new Exception( "Intervallo non valido: {$this->interval}" );
            }
            $date->sub( $interval );
        }
        else
        {
            $interval = new DateInterval( $this->interval );
            if ( !$interval instanceof DateInterval )
            {
                throw new Exception( "Intervallo non valido: {$this->interval}" );
            }
            $date->add( $interval );
        }
        return $date;
    }
    
    public static function timezone()
    {
        //@todo
        return new DateTimeZone( 'Europe/Rome' );
    }
    
    /*
    public static function executeWorkflow( $parameters, $process, $event )
    {
        if ( $parameters['trigger_name'] == 'pre_updateobjectstate' )
        {
            $objectId = $parameters['object_id'];
            $post = ITNewsletterPost::instanceFromEzContentObjectId( $objectId );
            if ( $post->isValid() )
            {
                $object = $post->attribute( 'object' );
                $addHistory = false;
                $currentState = $post->currentState();
                $beforeStateId = $currentState instanceof eZContentObjectState ? $currentState->attribute( 'id' ) : '?';
                $beforeStateName = $currentState instanceof eZContentObjectState ? $currentState->attribute( 'current_translation' )->attribute( 'name' ) : '?';
                $states = ITNewsletterPost::states();
                $newStateIds = $parameters['state_id_list'];
                
                $currentStateIDArray = $object->attribute( 'state_id_array' );
                $selectedStateIDList = array_diff( $newStateIds, $currentStateIDArray );
                $canAssignStateIDList = $object->attribute( 'allowed_assign_state_id_list' );
                $newStateIds = array_intersect( $newStateIds, $canAssignStateIDList );
                
                foreach( $states as $identifier => $state )
                {
                    if ( in_array( $state->attribute( 'id' ), $newStateIds ) )
                    {
                        $afterStateId = $state->attribute( 'id' );
                        $afterStateName = $state->attribute( 'current_translation' )->attribute( 'name' );
                        $addHistory = true;
                        break;
                    }
                }
                if ( $addHistory )
                {
                    $post->addHistory( 'updateobjectstate', array( 'before_state_id' => $beforeStateId,
                                                                   'before_state_name' => $beforeStateName,
                                                                   'after_state_id' => $afterStateId,
                                                                   'after_state_name' => $afterStateName ) );
                }
            }
        }
        elseif ( $parameters['trigger_name'] == 'post_updateobjectstate' )
        {
            $objectId = $parameters['object_id'];
            $post = ITNewsletterPost::instanceFromEzContentObjectId( $objectId );
            if ( $post->isValid() )
            {
                $post->onUpdateState();
            }
        }
    }
    */
}
