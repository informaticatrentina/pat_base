<?php

class ITNewsletterHandler extends eZNotificationEventHandler{
    const NOTIFICATION_HANDLER_ID = 'itnewsletter';
    const TRANSPORT = 'ezmail';

    /*!
     Constructor
    */
    function ITNewsletterHandler(){
        $this->eZNotificationEventHandler( self::NOTIFICATION_HANDLER_ID, "Newsletter Handler" );
    }

    /**
     * @return array
     */
    function attributes(){
        return array_merge( array( 'subscribed_tags',
                                   'rules',
                                   'available_tags' ),
            eZNotificationEventHandler::attributes() );
    }

    /**
     * @param string $attr
     *
     * @return bool
     */
    function hasAttribute( $attr ){
        return in_array( $attr, $this->attributes() );
    }

    /**
     * @param string $attr
     *
     * @return mixed
     */
    function attribute( $attr ){
        if ( $attr == 'subscribed_tags' ){
            $user = eZUser::currentUser();
            return $this->subscribedTags( $user );
        }
        else if ( $attr == 'rules' ){
            $user = eZUser::currentUser();
            return $this->rules( $user );
        }
        else if ( $attr == 'available_tags' )
        {
            return ITNewsletterPost::notificationAvailableTags();
        }
        return eZNotificationEventHandler::attribute( $attr );
    }

    /**
     * @param eZNotificationEvent $event
     *
     * @return bool
     */
    function handle( $event ){ 
        eZDebugSetting::writeDebug( 'kernel-notification', $event, "trying to handle event" );
        if ( $event->attribute( 'event_type_string' ) == 'ezpublish' ){
            $parameters = array();
            $status = $this->handlePublishEvent( $event, $parameters );
            /*
            if ( $status == eZNotificationEventHandler::EVENT_HANDLED ){
                $this->sendMessage( $event, $parameters );
            }
            else{
                return false;
            }
             * 
             */
        }
        return true;
    }

    /**
     * @param eZNotificationEvent $event
     * @param array $parameters
     *
     * @return int
     */
    function handlePublishEvent( $event, &$parameters ){
        /** @var eZContentObjectVersion $versionObject */
        $versionObject = $event->attribute( 'content' );
        if ( !$versionObject )
            return eZNotificationEventHandler::EVENT_SKIPPED;

        /** @var eZContentObject $contentObject */
        $contentObject = $versionObject->attribute( 'contentobject' );
        if ( !$contentObject )
            return eZNotificationEventHandler::EVENT_SKIPPED;

        /** @var eZContentObjectTreeNode $contentNode */
        $contentNode = $contentObject->attribute( 'main_node' );
        if ( !$contentNode )
            return eZNotificationEventHandler::EVENT_SKIPPED;

        // Notification should only be sent out when the object is published (is visible)
        if ( $contentNode->attribute( 'is_invisible' ) == 1 )
            return eZNotificationEventHandler::EVENT_SKIPPED;

        /** @var eZContentClass $contentClass */
        $contentClass = $contentObject->attribute( 'content_class' );
        if ( !$contentClass )
            return eZNotificationEventHandler::EVENT_SKIPPED;
        
        if ( // $versionObject->attribute( 'version' ) != 1 ||
            $versionObject->attribute( 'version' ) != $contentObject->attribute( 'current_version' ) ) {
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }
        
        try{
            
            $post = ITNewsletterPost::instanceFromEzContentObject( $contentObject );
            
            
            if ( !$post instanceof ITNewsletterPost )
            {
                throw new Exception( "Post not found" );
            }
            if ( !$post->isValid() )
            {
                throw new Exception( "Post not valid" );
            }
   
            /*
            if ( !$post->attribute( 'is_sent' ) )
            {
                throw new Exception( "Post not already sent" );
            }
             * 
             */
        }
        catch( Exception $e )
        {
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }        

        $tpl = eZTemplate::factory();
        $tpl->resetVariables();

        /** @var eZContentObjectTreeNode $parentNode */
        $parentNode = $contentNode->attribute( 'parent' );
        if ( !$parentNode instanceof eZContentObjectTreeNode )
        {
            eZDebug::writeError( 'DB corruption: Node id ' . $contentNode->attribute( 'node_id' ) . ' is missing parent node.', __METHOD__ );
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }

        /** @var eZContentObject $parentContentObject */
        $parentContentObject = $parentNode->attribute( 'object' );
        if ( !$parentContentObject instanceof eZContentObject )
        {
            eZDebug::writeError( 'DB corruption: Node id ' . $parentNode->attribute( 'node_id' ) . ' is missing object.', __METHOD__ );
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }

        /** @var eZContentClass $parentContentClass */
        $parentContentClass = $parentContentObject->attribute( 'content_class' );
        if ( !$parentContentClass instanceof eZContentClass )
        {
            eZDebug::writeError( 'DB corruption: Object id ' . $parentContentObject->attribute( 'id' ) . ' is missing class object.', __METHOD__ );
            return eZNotificationEventHandler::EVENT_SKIPPED;
        }

        $res = eZTemplateDesignResource::instance();
        $res->setKeys( array( array( 'object', $contentObject->attribute( 'id' ) ),
                              array( 'node', $contentNode->attribute( 'node_id' ) ),
                              array( 'class', $contentObject->attribute( 'contentclass_id' ) ),
                              array( 'class_identifier', $contentClass->attribute( 'identifier' ) ),
                              array( 'parent_node', $contentNode->attribute( 'parent_node_id' ) ),
                              array( 'parent_class', $parentContentObject->attribute( 'contentclass_id' ) ),
                              array( 'parent_class_identifier', ( $parentContentClass != null ? $parentContentClass->attribute( 'identifier' ) : 0 ) ),
                              array( 'depth', $contentNode->attribute( 'depth' ) ),
                              array( 'url_alias', $contentNode->attribute( 'url_alias' ) )
        ) );

        $tpl->setVariable( 'object', $contentObject );

        $notificationINI = eZINI::instance( 'notification.ini' );
        $emailSender = $notificationINI->variable( 'MailSettings', 'EmailSender' );
        $ini = eZINI::instance();
        if ( !$emailSender )
            $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
        if ( !$emailSender )
            $emailSender = $ini->variable( "MailSettings", "AdminEmail" );
        $tpl->setVariable( 'sender', $emailSender );

        $result = $tpl->fetch( 'design:notification/handler/templatepat/view/plain.tpl' );
        
        $subject = $tpl->variable( 'subject' );
        if ( $tpl->hasVariable( 'message_id' ) )
            $parameters['message_id'] = $tpl->variable( 'message_id' );
        if ( $tpl->hasVariable( 'references' ) )
            $parameters['references'] = $tpl->variable( 'references' );
        if ( $tpl->hasVariable( 'reply_to' ) )
            $parameters['reply_to'] = $tpl->variable( 'reply_to' );
        if ( $tpl->hasVariable( 'from' ) )
            $parameters['from'] = $tpl->variable( 'from' );
        if ( $tpl->hasVariable( 'content_type' ) )
            $parameters['content_type'] = $tpl->variable( 'content_type' );
        
        $collection = eZNotificationCollection::create( $event->attribute( 'id' ),
            self::NOTIFICATION_HANDLER_ID,
            self::TRANSPORT );
        
        $collection->setAttribute( 'data_subject', $subject );
        $collection->setAttribute( 'data_text', $result );
        $collection->store();

        $tags = $post->notificationTags();
        
        $userList = ITNewsletterNotificationRule::fetchUserList( $tags );

        $locale = eZLocale::instance();
        $weekDayNames = $locale->attribute( 'weekday_name_list' );
        $weekDaysByName = array_flip( $weekDayNames );

        foreach( $userList as $user )
        {
            $item = $collection->addItem( $user->attribute( 'email' ) );
            // digest forzato
            eZNotificationSchedule::setDateForItem( $item, array( 'frequency' => 'day', 'hour' => '12' ) );
            $item->store();
            
            ///** @var eZGeneralDigestUserSettings $settings */
            //$settings = eZGeneralDigestUserSettings::fetchForUser( $user->attribute( 'email' ) );
            //if ( $settings !== null && $settings->attribute( 'receive_digest' ) == 1 )
            //{
            //    $time = $settings->attribute( 'time' );
            //    $timeArray = explode( ':', $time );
            //    $hour = $timeArray[0];
            //
            //    if ( $settings->attribute( 'digest_type' ) == eZGeneralDigestUserSettings::TYPE_DAILY )
            //    {
            //        eZNotificationSchedule::setDateForItem( $item, array( 'frequency' => 'day',
            //                                                              'hour' => $hour ) );
            //    }
            //    else if ( $settings->attribute( 'digest_type' ) == eZGeneralDigestUserSettings::TYPE_WEEKLY )
            //    {
            //        $weekday = $weekDaysByName[ $settings->attribute( 'day' ) ];
            //        eZNotificationSchedule::setDateForItem( $item, array( 'frequency' => 'week',
            //                                                              'day' => $weekday,
            //                                                              'hour' => $hour ) );
            //    }
            //    else if ( $settings->attribute( 'digest_type' ) == eZGeneralDigestUserSettings::TYPE_MONTHLY )
            //    {
            //        eZNotificationSchedule::setDateForItem( $item,
            //            array( 'frequency' => 'month',
            //                   'day' => $settings->attribute( 'day' ),
            //                   'hour' => $hour ) );
            //    }
            //    $item->store();
            //}
        }
        return eZNotificationEventHandler::EVENT_HANDLED;
    }

    /**
     * @param eZNotificationEvent $event
     * @param array $parameters
     */
    function sendMessage( $event, $parameters ){
        /** @var eZNotificationCollection $collection */
        $collection = eZNotificationCollection::fetchForHandler(
            self::NOTIFICATION_HANDLER_ID,
            $event->attribute( 'id' ),
            self::TRANSPORT );

        if ( !$collection ){
            return;
        }

        /** @var eZNotificationCollectionItem[] $items */
        //$items = $collection->attribute( 'items_to_send' );
        $items = $collection->items();
        
        //print_r($collection);
        //print_r($items);
        //die();
        
        if ( !$items ){
            eZDebugSetting::writeDebug( 'kernel-notification', "No items to send now" );
            return;
        }
        
        $addressList = array();
        foreach ( $items as $item ){
            $addressList[] = $item->attribute( 'address' );
            $item->remove();
        }

        $transport = eZNotificationTransport::instance( 'ezmail' );
        $transport->send( $addressList, $collection->attribute( 'data_subject' ), $collection->attribute( 'data_text' ), null, $parameters );
        
        if ( $collection->attribute( 'item_count' ) == 0 ) {
            $collection->remove();
        }
    }

    /**
     * @param eZUser $user
     *
     * @return eZTagsObject[]
     */
    function subscribedTags( $user = null ){
        if ( $user === null ){
            $user = eZUser::currentUser();
        }
        $userID = $user->attribute( 'contentobject_id' );

        return ITNewsletterNotificationRule::fetchTagsForUserID( $userID );
    }

    /**
     * @param eZUser $user
     * @param bool $offset
     * @param bool $limit
     *
     * @return ITNewsletterNotificationRule[]
     */
    static function rules( $user = null, $offset = false, $limit = false ){
        if ( $user === null ){
            $user = eZUser::currentUser();
        }
        $userID = $user->attribute( 'contentobject_id' );

        return ITNewsletterNotificationRule::fetchList( $userID, true, $offset, $limit );
    }

    /**
     * @param eZUser $user
     *
     * @return int
     */
    static function rulesCount( $user = null ){
        if ( $user === null ){
            $user = eZUser::currentUser();
        }
        $userID = $user->attribute( 'contentobject_id' );

        return ITNewsletterNotificationRule::fetchListCount( $userID );
    }

    /**
     * @param eZHTTPTool $http
     * @param eZModule $module
     * @return void
     */
    function fetchHttpInput( $http, $module ){
        if ( $http->hasPostVariable( 'RemoveRule_' . self::NOTIFICATION_HANDLER_ID  ) ){
            $user = eZUser::currentUser();
            $listID = array();
            $userList = ITNewsletterNotificationRule::fetchList( $user->attribute( 'contentobject_id' ), false );
            foreach ( $userList as $userRow )
            {
                $listID[] = $userRow['id'];
            }
            $ruleIDList = $http->postVariable( 'RemoveRule_' . self::NOTIFICATION_HANDLER_ID );
            foreach ( $ruleIDList as $ruleID )
            {
                if ( in_array( $ruleID, $listID ) )
                    eZPersistentObject::removeObject( ITNewsletterNotificationRule::definition(), array( 'id' => $ruleID ) );
            }
        }
        else if ( $http->hasPostVariable( 'SaveRule_' . self::NOTIFICATION_HANDLER_ID  )  ){
            $tagID = $http->postVariable( 'SaveRule_' . self::NOTIFICATION_HANDLER_ID );
            $user = eZUser::currentUser();
            
            $existingTags = ITNewsletterNotificationRule::fetchTagsForUserID( $user->attribute( 'contentobject_id' ), false );

            if ( ! in_array( $tagID, $existingTags ) ){
                $rule = ITNewsletterNotificationRule::create( $tagID, $user->attribute( 'contentobject_id' ) );
                $rule->store();
            }
        }
    }
    
    
    function cleanup(){
        ITNewsletterNotificationRule::cleanup();
    }
}