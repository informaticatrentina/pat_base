<?php


$ini = eZINI::instance();
$module = $Params['Module'];
$userLogin= $Params['UserID'];
$userPassword= $Params['Password'];

header('Content-Type: application/json');


try
{
    if (( $userLogin != '' ) &&( $userPassword != '' ))
    {
        $loginHandlers = array( 'standard' );
        foreach ( array_keys ( $loginHandlers ) as $key )
        {
            $loginHandler = $loginHandlers[$key];
            $userClass = eZUserLoginHandler::instance( $loginHandler );
            $user = $userClass->loginUser( $userLogin, $userPassword );
            if ( $user instanceof eZUser )
            {
                eZUser::logoutCurrent();

                echo json_encode(
                    array(   
                        'Login' => 'Ok',
                        'Logout' => 'Ok',
                    ));
            }
            else
            {
                echo json_encode(
                    array(   
                        'Error' => 'FailedLogin'
                    ));
            }
        }
    }
    else{
        echo json_encode(
                    array(   
                        'Error' => 'FailedLogin'
        ));
    }
}
catch (Exception $e) {
    echo json_encode(
                        array( 
                                'Error' => $e->getMessage(),
                                'Line' => $e->getLine(),
                                'Trace' => $e->getTraceAsString()
                             )
                    );
}


eZExecution::cleanExit();