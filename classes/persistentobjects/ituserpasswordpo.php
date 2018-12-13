<?php

/**
 * Class ITUserPasswordPO
 */
class ITUserPasswordPO extends eZPersistentObject
{
    static function definition()
    {
        return array( "fields" =>
            array(
                "id" => array(
                    'name' => 'id',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true ),
                'contentobject_id' => array(
                    'name' => 'contentobject_id',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true ),
                'last_password_change' => array(
                    'name' => 'last_password_change',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true ),
                'last_passwords' => array(
                    'name' => 'last_passwords',
                    'datatype' => 'text',
                    'default' => '',
                    'required' => false ),
            ),
            "keys" => array( 'id' ),
            "sort" => array( "id" => "asc" ),
            "class_name" => "ITUserPasswordPO",
            "name" => "ituserpassword" );
    }

    /**
     * Se non esiste crea la tabella e la sequence sul db
     */
    private static function autodeploy()
    {
        $dbSchema = eZINI::instance()->variable('DatabaseSettings', 'Database');

        $db = eZDB::instance();
        $db->begin();

        $checkTableQuery = "SELECT 1 "
                         . "  FROM information_schema.tables "
                         . " WHERE (table_schema = '$dbSchema' OR table_schema = 'public') "
                         . "   AND table_name = 'ituserpassword' ";

        $hasTable = $db->arrayQuery( $checkTableQuery );

        if(empty($hasTable)){
            $query = file_get_contents ('extension/pat_base/sql/postgresql/schema.sql');
            $db->query( $query );
        }
        else{
            $checkLastPasswordsQuery = "SELECT column_name "
                                     . "  FROM information_schema.columns "
                                     . " WHERE table_name='ituserpassword' and column_name='last_passwords'";

            $hasColumn = $db->arrayQuery( $checkLastPasswordsQuery );

            if(empty($hasColumn)){
                $query = file_get_contents ('extension/pat_base/sql/postgresql/schema_update1.sql');
                $db->query( $query );
            }
        }

        $db->commit();
    }

    /**
     * @param $contentobject_id
     * @param $last_password_change
     * @return ITUserPasswordPO
     */
    public static function create( $contentobject_id, $last_password_change, $last_password )
    {
        $object = new ITUserPasswordPO(
            array(
                'contentobject_id' => $contentobject_id,
                'last_password_change' => $last_password_change,
                'last_passwords' => $last_password
            )
        );

        return $object;
    }

    /**
     * @param $user_id
     * @return mixed
     */
    public static function fetchByUserID( $user_id )
    {
        self::autodeploy();
        
        $object = eZPersistentObject::fetchObject(
            self::definition(),
            null,
            array( 'contentobject_id' => $user_id )
        );

        return $object;
    }


    public static function update($id, $last_password_change, $last_password, $last_passwords_check_count)
    {
        $object = eZPersistentObject::fetchObject(
            self::definition(),
            null,
            array( 'id' => $id )
        );

        $object->setAttribute('last_password_change', $last_password_change );

        $last_passwords = $object->attribute('last_passwords');
        $passwords = explode(';', $last_passwords);

        $passwords[] = $last_password;

        while(count($passwords) > $last_passwords_check_count){
            array_shift($passwords);
        }
        $last_passwords = implode(";", $passwords);

        $object->setAttribute('last_passwords', $last_passwords );

        return $object;
    }
}