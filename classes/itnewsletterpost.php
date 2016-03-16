<?php

/**
 * Utilizzata dalla newsletter per gestire le classi che generano le notifiche
 * ed i tag a cui ci si può registrare.
 * 
 */
class ITNewsletterPost{
    const CLASS_IDENTIFIER = 'comunicato';
    
    const TAG_ATTRIBUTE_IDENTIFIER = 'tematica';
    
    
    const STATE_PUBLISHED = 'published';
    const STATE_SENT = 'sent';
    
    /**
     * @var eZContentObject
     */
    protected $object;

    /**
     * @var eZContentObjectAttribute[]
     */
    protected $dataMap;
    
    /**
     * @var eZContentObjectTreeNode
     */
    protected $mainNode;
    
    /**
     * @var array
     */
    protected $data;
    
     protected function __construct( array $data = array() )
    {
        $this->data = $data;
        if ( isset( $data['object_id'] ) )
        {
            $this->object = eZContentObject::fetch( $data['object_id'] );
        }
        if ( !$this->object instanceof eZContentObject )
        {
            throw new Exception( 'Object not found' );
        }
        $this->mainNode = $this->object->attribute( 'main_node' );
        if ( !$this->mainNode instanceof eZContentObjectTreeNode )
        {
            throw new Exception( 'Node not found' );
        }
        $this->dataMap = $this->object->attribute( 'data_map' );                
    }
    
    /**
     * Ritorna l'elengo dei tag disponibili
     * 
     * @return eZTagsObject[]
     */
    public static function notificationAvailableTags(){
        $class = eZContentClass::fetchByIdentifier( self::CLASS_IDENTIFIER );
        
        if ( $class instanceof eZContentClass ){
            $classAttribute = $class->fetchAttributeByIdentifier( self::TAG_ATTRIBUTE_IDENTIFIER );
            if ( $classAttribute instanceof eZContentClassAttribute ){
                $tagRoot = eZTagsObject::fetch(
                    intval( $classAttribute->attribute( eZTagsType::SUBTREE_LIMIT_FIELD ) )
                );

                return $tagRoot->getChildren();
            }
        }
        return array();
    }
    
    /**
     * @param eZContentObject $object
     *
     * @return ITNewsletterPost
     */
    public static function instanceFromEzContentObject( eZContentObject $object ){        
        $id = $object->attribute( 'id' );
        return ITNewsletterPostHandler::fetchByObjectId( $id );
    }
    /**
     * @param int $id
     *
     * @return ITNewsletterPost
     */
    public static function instanceFromEzContentObjectId( $id )
    {                
        return ITNewsletterPostHandler::fetchByObjectId( $id );
    }
    
    /**
     * @return array
     */
    public static function fields()
    {
        return array(
            /*
            array(
                'solr_identifier' => 'extra_link_count_s',
                'object_property' => 'link_count',
                'attribute_identifier' => 'link',
                'index_extra' => true
            ),
            array(
                'solr_identifier' => 'extra_image_count_s',
                'object_property' => 'image_count',
                'attribute_identifier' => 'immagini',
                'index_extra' => true
            ),
            array(
                'solr_identifier' => 'extra_audio_count_s',
                'object_property' => 'audio_count',
                'attribute_identifier' => 'audio',
                'index_extra' => true
            ),
            array(
                'solr_identifier' => 'extra_video_count_s',
                'object_property' => 'video_count',
                'attribute_identifier' => 'video',
                'index_extra' => true
            ),
            array(
                'solr_identifier' => 'extra_attachment_count_s',
                'object_property' => 'attachment_count',
                'attribute_identifier' => 'allegati',
                'index_extra' => true
            ),
             */
            array(
                'solr_identifier' => 'attr_argomento_lk',
                'object_property' => 'tags',
                'attribute_identifier' => 'argomento',
                'index_extra' => false
            ),
            array(
                'solr_identifier' => 'attr_numero_si',
                'object_property' => 'id',
                'attribute_identifier' => 'numero',
                'index_extra' => false
            ),
            array(
                'solr_identifier' => 'meta_object_states_si',
                'object_property' => 'states',
                'attribute_identifier' => null,
                'index_extra' => false
            )
        );
    }
    
    /**
     * @param array $result
     *
     * @return ITNewsletterPost
     */
    public static function instanceFromEzfindResultArray( array $result )
    {        
        $data = array();
        $data['object_id'] = $result['id'];
        foreach(ITNewsletterPost::fields() as $field ){            
            $data[$field['object_property']] = isset( $result['fields'][$field['solr_identifier']] ) ? $result['fields'][$field['solr_identifier']] : null;
        }
        return new ITNewsletterPost( $data );
    }
    
    /**
     * @return bool
     */
    public function isValid(){
        return $this->object->attribute( 'class_identifier' ) == 'comunicato';
    }
    
    final public function attribute( $property )
    {
        switch( $property )
        {
            case 'object':
                return $this->object;
        
            case 'node':
                return $this->mainNode;
        
            case 'states':
                return self::states();
            
            case 'current_state':
                return $this->currentState();
            
            case 'history':
                return $this->history();
            
            case 'notifications':
                return $this->notifications();
            
            case 'social_pushes':
                return $this->socialPushes();
            
            case 'hashtags':
                return $this->hashtags();

            case 'is_published':
                return $this->currentState()->attribute( 'identifier' ) == ITNewsletterPost::STATE_PUBLISHED;
            
            case 'is_sent':
                return $this->currentState()->attribute( 'identifier' ) == ITNewsletterPost::STATE_SENT;
                        
            default:
                if ( array_key_exists( $property, $this->data ) )
                {
                    return $this->data[$property];
                }
                return false;
        }     
    }

    final public function attributes()
    {
        return array_merge(
            array(
                'object',
                'node',
                'can_approve',
                'can_disapprove',
                'current_state',
                'history',
                'notifications',
                'social_pushes',
                'hashtags',
                'is_published',
                'is_sent'
            ),
           array_keys( $this->data )
        );
    }

    final public function hasAttribute( $property )
    {
        return in_array( $property, $this->attributes() );
    }
    
    /**
     * @return eZTags
     */
    public function notificationTags()
    {
        $tags = new eZTags();
        if ( isset( $this->dataMap[self::TAG_ATTRIBUTE_IDENTIFIER] )
             && $this->dataMap[self::TAG_ATTRIBUTE_IDENTIFIER]->attribute( 'data_type_string' ) == 'eztags'
             && $this->dataMap[self::TAG_ATTRIBUTE_IDENTIFIER]->attribute( 'has_content' ) )
        {
            $tags = $this->dataMap[self::TAG_ATTRIBUTE_IDENTIFIER]->attribute( 'content' );
        }
        return $tags;
    }
}
