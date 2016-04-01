<?php

class Sinetsitecolors_PstObject extends eZPersistentObject
{

    static function definition()
    {
        return array( "fields" => array( "id" => array( 'name' => 'ID',
                                                        'datatype' => 'integer',
                                                        'default' => 0,
                                                        'required' => true ),                                      
                                         "name_tag" => array( 'name' => "name_tag",
                                                             'datatype' => 'text',                                                                                                                          
                                                             'required' => true,                                                            
                                                             'multiplicity' => '1..*' ),
                                         "color" => array( 'name' => "color",
                                                             'datatype' => 'text',                                                             
                                                             'required' => true,                                                            
                                                             'multiplicity' => '1..*' )        
                                        ),
                      "keys" => array( "id" ),
                      "sort" => array( "id" => "asc" ),
                      "class_name" => "Sinetsitecolors_PstObject",
                      "name" => "sinet_site_colors" );
    }

    public static function fetchHandlerList( )
    {

        $sinetsitecolorsObjectList = eZPersistentObject::fetchObjectList(
                Sinetsitecolors_PstObject::definition(),
                null,
                array(),
                null,
                null,
                false
            );
         return $sinetsitecolorsObjectList;
           
    }

    
    public static function fetchListCount()
    {
        $countRes = eZPersistentObject::fetchObjectList(
                Sinetsitecolors_PstObject::definition(),
                null,
                array(),
                null,
                null,
                false
            ); 
        return $countRes[0]['count'];
    }
    
    public static function fetchById( $IdTableName )
    {

        $cond = array( 'id' => $IdTableName );
        $return = eZPersistentObject::fetchObject( self::definition(), null, $cond );
        return $return; 
           
    } 
    
    public static function removeById( $IdTableName )
    {
            $cond = array( 'id' => $IdTableName );
            eZPersistentObject::removeObject( self::definition(), $cond );

    }  
}
