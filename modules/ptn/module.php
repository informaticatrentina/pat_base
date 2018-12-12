<?php
 
$Module = array( 'name' => 'Template Module - Informatica Trentina SpA' );
$ViewList = array();
 
$ViewList['newsletter'] = array( 'script' => 'newsletter.php',
                                 'functions' => array( 'newsletter' ),
                                 'params' => array(),
                                 'unordered_params' => array() 
                               );

$ViewList['header_image'] = array( 'script' => 'header_image.php',
                                 'functions' => array( 'header_image' ),
                                 'params' => array(),
                                 'unordered_params' => array() 
                               );

$ViewList['force_playlist_import'] = array(
    'script' => 'force_playlist_import.php',
    'params' => array( 'ParentNodeID' ),
    'unordered_params' => array()
);


$ViewList['forceSiteColor'] = array( 
    'script' => 'force_Site_Color.php',
    'params' => array( 'SiteColor' ),
    'unordered_params' => array()
); 

$ViewList['imalive'] = array( 
    'script' => 'imalive.php',
    'params' => array(),
    'unordered_params' => array()
); 

$ViewList['calendar_search'] = array(
    'script'			=>      'calendar_search.php',
    'params'			=> 	array('Class', 'FacetAttributes', 'ParentNodeID', 'ExportFormat'),
    'unordered_params'		=> 	array(),
    'single_post_actions'	=> 	array(),
    'post_action_parameters'	=> 	array()
);

$ViewList['password_policy'] = array(
    'script'			=>      'password_policy.php',
    'params'			=> 	array('OldPassword', 'NewPassword', 'Login'),
    'unordered_params'		=> 	array(),
    'single_post_actions'	=> 	array(),
    'post_action_parameters'	=> 	array()
);

$ViewList['password_expired'] = array(
    'script'			=>      'password_expired.php',
    'params'			=> 	array('UserID'),
    'unordered_params'		=> 	array(),
    'single_post_actions'	=> 	array(),
    'post_action_parameters'	=> 	array()
);

$ViewList['password_updated'] = array(
    'script'			=>      'password_updated.php',
    'params'			=> 	array('UserID', 'Password'),
    'unordered_params'		=> 	array(),
    'single_post_actions'	=> 	array(),
    'post_action_parameters'	=> 	array()
);

$ViewList['health_check'] = array(
    'script'			=>      'health_check.php',
    'params'			=> 	array('UserID', 'Password'),
    'unordered_params'		=> 	array(),
    'single_post_actions'	=> 	array(),
    'post_action_parameters'	=> 	array()
);


$FunctionList = array();
$FunctionList['newsletter'] = array();
$FunctionList['header_image'] = array();
$FunctionList['forceSiteColor'] = array();
$FunctionList['imalive'] = array();
$FunctionList['calendar_search'] = array();
$FunctionList['password_policy'] = array();
$FunctionList['password_expired'] = array();
$FunctionList['password_updated'] = array();
$FunctionList['health_check'] = array();