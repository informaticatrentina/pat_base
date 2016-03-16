<?php

$module = $Params['Module'];
$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

if ( $http->hasPostVariable( 'SaveRule_itnewsletter' ) ){
    // AGGIUNGO LA REGISTRAZIONE DELL'UTENTE AL TAG DELLA NEWSLETTER //
    
    $tagID = $http->postVariable( 'SaveRule_itnewsletter' );
    $user = eZUser::currentUser();

    $existingTags = ITNewsletterNotificationRule::fetchTagsForUserID( $user->attribute( 'contentobject_id' ), false );
    
    if ( ! in_array( $tagID, $existingTags ) ){
        $rule = ITNewsletterNotificationRule::create( $tagID, $user->attribute( 'contentobject_id' ) );
        $rule->store();
    }
}
else if ($http->hasPostVariable( 'RemoveRule_itnewsletter' )){
    // TOLGO LA REGISTRAZIONE DELL'UTENTE AL TAG DELLA NEWSLETTER //
    
    $user = eZUser::currentUser();
    $listID = array();
    $userList = ITNewsletterNotificationRule::fetchList( $user->attribute( 'contentobject_id' ), false );
    
    foreach ( $userList as $userRow ){
        $listID[] = $userRow['id'];
    }
    $ruleIDList = $http->postVariable( 'RemoveRule_itnewsletter' );
    
    foreach ( $ruleIDList as $ruleID ){
        if ( in_array( $ruleID, $listID ) ){
            eZPersistentObject::removeObject( ITNewsletterNotificationRule::definition(), array( 'id' => $ruleID ) );
        }
    }
}

$Result['content'] = $tpl->fetch( 'design:ptn/newsletter.tpl' );
$Result['path'] = array( array( 'url' => false,
                                'text' => 'Newsletter' ) );

