<?php
namespace IT\PATBase;

class ITPasswordPolicy extends ITClass{

    protected $ini;

    private $strength;
    private $passwordExpirationDays;
    private $lastPasswordsCheckCount;

    // ====================== PRIVATE METHODS ======================
    private function checkHasCapital($pwd)
    {
        if( !preg_match('#[A-Z]+#', $pwd) || !preg_match('#[a-z]+#', $pwd) ){
            return false;
        }

        return true;
    }

    private function checkHasNumber($pwd)
    {
        if( !preg_match('#[0-9]+#', $pwd) ){
            return false;
        }

        return true;
    }

    private function checkSpecialCharacters($pwd)
    {
        if( !preg_match('#[\W]+#', $pwd) ){
            return false;
        }

        return true;
    }

    private function isPasswordExpired($passwordPO, $expirationDays)
    {
        $now_timestamp = time();
        $last_change = $passwordPO->attribute('last_password_change');
        $expirationSeconds = $expirationDays * 24 * 60 * 60;

        return ($now_timestamp - $last_change) > $expirationSeconds;
    }

    // ====================== PUBLIC METHODS ======================

    /**
     * ITPasswordPolicy constructor.
     * @param int $env
     */
    public function __construct( $env = self::NON_TEST )
    {
        $this->env = $env;

        $eZINI = $this->checkEnv('eZINI' );

        $this->ini = $eZINI::instance( 'site.ini' );
        $this->strength = $this->ini->variable('UserSettings','PasswordStrength');
        $this->passwordExpirationDays = $this->ini->variable('UserSettings', 'PasswordExpirationDays');
        $this->lastPasswordsCheckCount = $this->ini->variable('UserSettings', 'LastPasswordsCheckCount');
    }

    /**
     *
     * @param $new_password
     * @return bool
     */
    public function checkPolicy(  $pwd ){

        switch($this->strength){
            case 'LOW':
                {
                    return true;
                }
            case 'MEDIUM':
                {
                    if(!$this->checkHasCapital($pwd)){
                        return false;
                    }
                    else{
                        return true;
                    }
                }
            case 'HIGH':
                {
                    if(!$this->checkHasCapital($pwd) || !$this->checkHasNumber($pwd)){
                        return false;
                    }
                    else{
                        return true;
                    }
                }
            case 'HIGHER':
                {
                    if( !$this->checkHasCapital($pwd) ||
                        !$this->checkHasNumber($pwd) ||
                        !$this->checkSpecialCharacters($pwd) ){
                        return false;
                    }
                    else{
                        return true;
                    }
                }
        }

        return true;
    }

    public function checkOldPassword($old_password, $new_password)
    {
        return $new_password !== $old_password;
    }

    public function checkPasswordExpired( $userID, $login )
    {
        $ITUserPasswordPO = $this->checkEnv('ITUserPasswordPO' );

        $passwordPO = $ITUserPasswordPO::fetchByUserID($userID);

        $expirationDays = 0;
        if(array_key_exists($login, $this->passwordExpirationDays)){
            $expirationDays = $this->passwordExpirationDays[$login];
        }
        else if (array_key_exists('default', $this->passwordExpirationDays)){
            $expirationDays = $this->passwordExpirationDays['default'];
        }

        if($expirationDays > 0){
            if (empty($passwordPO)) {
                return true;
            }
            else if($this->isPasswordExpired($passwordPO, $expirationDays)){
                return true;
            }
        }

        return false;
    }

    public function checkPasswordAlreadyUsed($login, $password )
    {
        $eZUser = $this->checkEnv('eZUser');
        $password_hash = $eZUser::createHash(
            $login,
            $password,
            $eZUser::site(),
            $eZUser::hashType()
        );

        $user = $eZUser::fetchByName($login);

        if($user instanceof $eZUser) {
            $userID = $user->ContentObjectID;

            $ITUserPasswordPO = $this->checkEnv('ITUserPasswordPO');
            $passwordPO = $ITUserPasswordPO::fetchByUserID($userID);

            if($passwordPO instanceof $ITUserPasswordPO) {
                $lastPasswords = explode(';', $passwordPO->attribute('last_passwords'));

                foreach ($lastPasswords as $lastPassword) {
                    if ($password_hash === $lastPassword) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    /**
     * Salva il timestamp di aggiornamento password
     *
     * @param $userID
     * @return mixed
     */
    public function passwordUpdated($userID)
    {
        $eZDB = $this->checkEnv('eZDB' );

        $db = $eZDB::instance();
        $db->begin();

        $ITUserPasswordPO = $this->checkEnv('ITUserPasswordPO' );

        $passwordPO = $ITUserPasswordPO::fetchByUserID($userID);

        $eZUser = $this->checkEnv('eZUser');
        $user = $eZUser::fetch($userID);

        //echo $user->PasswordHash;
        //die();

        if(empty($passwordPO)){
            $object = $ITUserPasswordPO::create( $userID, time(), $user->PasswordHash );
            $object->store();
        }
        else{
            $object = $ITUserPasswordPO::update( $passwordPO->attribute('id'), time(), $user->PasswordHash, $this->lastPasswordsCheckCount );
            $object->store();
        }

        $db->commit();

        return $object;
    }

}