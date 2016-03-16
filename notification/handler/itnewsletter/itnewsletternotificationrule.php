<?php

/**
 * 
 */
class ITNewsletterNotificationRule extends eZPersistentObject{

    static function definition(){
        return array( "fields" => array( "id" => array( 'name' => 'ID',
                                                        'datatype' => 'integer',
                                                        'default' => 0,
                                                        'required' => true ),
                                         "user_id" => array( 'name' => "UserID",
                                                             'datatype' => 'integer',
                                                             'default' => '',
                                                             'required' => true,
                                                             'foreign_class' => 'eZUser',
                                                             'foreign_attribute' => 'contentobject_id',
                                                             'multiplicity' => '1..*' ),
                                         "tag_id" => array( 'name' => "TagID",
                                                             'datatype' => 'integer',
                                                             'default' => 0,
                                                             'required' => true,
                                                             'foreign_class' => 'eZTagsObject',
                                                             'foreign_attribute' => 'id',
                                                             'multiplicity' => '1..*' ) ),
                      "keys" => array( "id" ),
                      "function_attributes" => array( 'tag' => 'tag' ),
                      "increment_key" => "id",
                      "sort" => array( "id" => "asc" ),
                      "class_name" => "ITNewsletterNotificationRule",
                      "name" => "itnewsletter_notification_rule" );
    }

    static function create( $tagID, $userID ){
        $rule = new ITNewsletterNotificationRule( array( 'user_id' => $userID,
                                                            'tag_id' => $tagID ) );
        return $rule;
    }


    /**
     * @param eZTags $tags
     *
     * @return eZUser[]
     */
    public static function fetchUserList( eZTags $tags )
    {
        $tagIds = $tags->attribute( 'tag_ids' );
        $roles = array();
        if ( is_array( $tagIds ) && !empty( $tagIds ) )
        {
            $roles = eZPersistentObject::fetchObjectList(
                ITNewsletterNotificationRule::definition(),
                array( 'user_id' ),
                array( 'tag_id' => array( $tagIds ) ),
                null,
                null,
                false
            );
        }
        $userIds = array();
        foreach( $roles as $role )
        {
            $userIds[] = $role['user_id'];
        }
        $userIds = array_unique( $userIds );
        $users = array();
        if ( !empty( $userIds ) )
        {
            $users = eZPersistentObject::fetchObjectList(
                eZUser::definition(),
                null,
                array( 'contentobject_id' => array( $userIds ) )
            );
        }
        foreach( $users as $index => $user )
        {
            if ( !$user->attribute( 'is_enabled' ) )
            {
                unset( $users[$index] );
            }
        }
        return $users;
    }

    public static function fetchTagsForUserID( $userId, $asObject = true )
    {
        $tagIDList = eZPersistentObject::fetchObjectList(
            ITNewsletterNotificationRule::definition(),
            array( 'tag_id' ),
            array( 'user_id' => $userId ),
            null,
            null,
            false
        );
        $tags = array();
        if ( $asObject )
        {
            foreach ( $tagIDList as $tagRow )
            {
                $tags[] = eZTagsObject::fetch( $tagRow['tag_id'] );
            }
        }
        else
        {
            foreach ( $tagIDList as $tagRow )
            {
                $tags[] = $tagRow['tag_id'];
            }
        }
        return $tags;
    }

    public static function fetchList( $userID, $asObject = true, $offset = false, $limit = false )
    {
        return eZPersistentObject::fetchObjectList(
            ITNewsletterNotificationRule::definition(),
            null,
            array( 'user_id' => $userID ),
            null,
            array( 'offset' => $offset,
                   'length' => $limit ),
            $asObject );
    }

    public static function fetchListCount( $userID )
    {
        $countRes = eZPersistentObject::fetchObjectList(
            ITNewsletterNotificationRule::definition(),
            array(),
            array( 'user_id' => $userID ),
            false,
            null,
            false,
            false,
            array( array( 'operation' => 'count( id )',
                          'name' => 'count' ) ) );
        return $countRes[0]['count'];
    }

    public static function cleanup()
    {
        $db = eZDB::instance();
        $db->query( "DELETE FROM itnewsletter_notification_rule" );
    }

    function node()
    {
        if ( $this->Tag == null )
        {
            $this->Tag = eZTagsObject::fetch( $this->attribute( 'tag_id' ) );
        }
        return $this->Tag;
    }

    public $Tag = null;
}
