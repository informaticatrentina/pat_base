<?php

use IT\PATBase\ITPasswordPolicy;
use IT\PATBase\ITClass;

/**
 * Class PatBaseUser
 */
class eZPatBaseUser extends eZUser
{
    const CHANGE_PASSWORD_URL = "/ptn/password_expired/";

    const ONE_YEAR_SECONDS = 31536000;

    private static function getFrontEndHost()
    {
        $relatedSiteAccessList = eZINI::instance()->variable('SiteAccessSettings', 'RelatedSiteAccessList');
        $host = '';

        foreach($relatedSiteAccessList as $siteAccess){
            if( is_numeric($siteAccess) ){
                $iniRootDir = getcwd() . '/settings/siteaccess/'. $siteAccess;
                $frontEndSiteINI = eZINI::instance('site.ini.append.php', $iniRootDir);
                $frontEndSiteINI->parseFile($iniRootDir . '/site.ini.append.php');

                $host =  $frontEndSiteINI->variable('SiteSettings', 'SiteURL');
                break;
            }
        }

        return "https://$host";
    }

    private static function checkLastVisit($user, $login)
    {
        $passwordExpirationDays = eZINI::instance()->variable('UserSettings', 'PasswordExpirationDays');
        $disableSeconds = eZINI::instance()->variable('UserSettings', 'DisableUserNoVisitDays') * 60 * 60 * 24;
        $checkLastVisit = true;

        if( empty($disableSeconds) ){
            $disableSeconds = self::ONE_YEAR_SECONDS;
        }

        foreach ($passwordExpirationDays as $_login => $days) {
            if($_login == $login && $days == 0){
                $checkLastVisit = false;
                break;
            }
        }

        if($checkLastVisit){
            $timeLastVisit = time() - $user->lastVisit();

            if($disableSeconds != 0 && $timeLastVisit > $disableSeconds){
                return false;
            }
        }

        return true;
    }

    public function __construct( $row = null )
    {
        parent::eZUser( $row );
    }

    public static function loginUser( $login, $password, $authenticationMatch = false )
    {
        $user = self::_loginUser($login, $password, $authenticationMatch);

        if($user instanceof eZUser){
            $userID = $user->attribute('contentobject_id');
            $login = $user->attribute('login');

            $passwordPolicy = new ITPasswordPolicy();

            if( !self::checkLastVisit( $user, $login ) ){
                self::loginFailed( $user, $login );
                return false;
            }

            if($passwordPolicy->checkPasswordExpired($userID, $login)){
                ITClass::redirect(self::getFrontEndHost() . self::CHANGE_PASSWORD_URL . $userID);
            }

        }

        if ( is_object( $user ) ) {
            self::loginSucceeded( $user );
            return $user;
        }
        else {
            self::loginFailed( $user, $login );
            return false;
        }
    }


}