<?php

use IT\PATBase\ITPasswordPolicy;

$module = $Params['Module'];
$user_id= $Params['UserID'];

header('Content-Type: application/json');

$passwordPolicy = new ITPasswordPolicy();

echo json_encode($passwordPolicy->passwordUpdated($user_id));

eZExecution::cleanExit();