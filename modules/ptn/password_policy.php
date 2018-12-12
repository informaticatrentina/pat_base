<?php

use IT\PATBase\ITPasswordPolicy;

$module = $Params['Module'];
$new_password = $Params['NewPassword'];
$old_password = $Params['OldPassword'];
$login = $Params['Login'];

header('Content-Type: application/json');

$passwordPolicy = new ITPasswordPolicy();

$result = array(
    'old_password_check' => $passwordPolicy->checkOldPassword($old_password, $new_password),
    'password_policy_check' => $passwordPolicy->checkPolicy($new_password),
    'password_already_used' => $passwordPolicy->checkPasswordAlreadyUsed($login, $new_password)
);

echo json_encode($result);

eZExecution::cleanExit();