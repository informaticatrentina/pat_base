<?php

use IT\PATBase\ITPasswordPolicy;

class Pat_BaseHandler extends eZContentObjectEditHandler
{
    function validateInput( $http, &$module, &$class, $object, &$version, $contentObjectAttributes, $editVersion, $editLanguage, $fromLanguage, $validationParameters )
    {
        $result = array( 'is_valid' => true, 'warnings' => array() );

        if($class->Identifier == 'user'){

            $password_attribute_id = 'ContentObjectAttribute_data_user_password_'.$this->getAttributeID($contentObjectAttributes, 'user_account');
            $login_attribute_id = 'ContentObjectAttribute_data_user_login_'.$this->getAttributeID($contentObjectAttributes, 'user_account');;

            if(array_key_exists($password_attribute_id, $_POST)){
                $password = $_POST[$password_attribute_id];

                $passwordPolicy = new ITPasswordPolicy();

                if(!$passwordPolicy->checkPolicy($password)){

                    $strength = eZINI::instance()->variable('UserSettings', 'PasswordStrength');

                    $message = '';
                    switch ($strength){
                        case 'MEDIUM':
                            $message = 'La password deve contenere almeno una lettera maiuscola.';
                            break;
                        case 'HIGH':
                            $message = 'La password deve contenere almeno una lettera maiuscola ed un numero.';
                            break;
                        case 'HIGHER':
                            $message = 'La password deve contenere almeno una lettera maiuscola, un numero ed un carattere speciale.';
                            break;
                    }

                    $result = array(
                        'is_valid' => false,
                        'warnings' => array( array( 'text' => $message ) )
                    );
                }
                else{
                    $login = $_POST[$login_attribute_id];

                    $user = eZUser::fetchByName($login);

                    if($user instanceof eZUser){
                        $userID = $user->attribute( 'contentobject_id' );

                        // Imposto una data ultimo login ad adesso per ripristinare eventuali utenti scaduti
                        eZUser::updateLastVisit( $userID );
                        eZUser::updateLastVisitByLogout( $userID );
                    }
                }
            }
        }

        return $result;
    }


    /**
     * Valore di un attributo
     *
     * @param array $contentObjectAttributes
     * @param string $attribute_name
     * @return string
     */
    private function getAttributeID($contentObjectAttributes, $attribute_name)
    {

        foreach($contentObjectAttributes as $attribute){
            if($attribute->ContentClassAttributeIdentifier === $attribute_name){
                return $attribute->ID;
            }
        }

        return NULL;
    }
}