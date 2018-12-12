<div class="row">
<div class="col-md-8 col-md-offset-2">

    <div class="alert alert-info" role="alert">
        <p>
            La password deve essere composta da almeno {ezini('UserSettings', 'MinPasswordLength')} caratteri
        </p>

        <p>
            {def $strength = ezini('UserSettings', 'PasswordStrength')}

            {if $strength|eq('MEDIUM')}
                La password deve contenere almeno una lettera minuscola e una maiuscola.
            {/if}
            {if $strength|eq('HIGH')}
                La password deve contenere almeno una lettera minuscola, una maiuscola e un numero
            {/if}
            {if $strength|eq('HIGHER')}
                La password deve contenere almeno una lettera minuscola, maiuscola, un numero ed un carattere speciale.
            {/if}
            {undef $strength}
        </p>
    </div>

    {def $action = concat($module.functions.password.uri,"/",$userID)}
    {if $password_expired}
        {set $action = concat("/ptn/password_expired/", $userID)}
    {/if}

    <form action={$action|ezurl} method="post" name="Password" id="Password">
    {undef $action}

        <div class="attribute-header">
            {if $password_expired}
                <h1 class="long">
                    La password per {$userAccount.login} è scaduta.
                </h1>
            {else}
                <h1 class="long">
                    {"Change password for user"|i18n("design/ocbootstrap/user/password")} {$userAccount.login}
                </h1>
            {/if}
        </div>

        <div id="Messages">
            {if $message}
                {if or( $oldPasswordNotValid, $newPasswordNotMatch, $newPasswordTooShort )}
                    {if $oldPasswordNotValid}
                        <div class="warning">
                            <h2>{'Please retype your old password.'|i18n('design/ocbootstrap/user/password')}</h2>
                        </div>
                    {/if}
                    {if $newPasswordNotMatch}
                        <div class="warning">
                            <h2>{"Password didn't match, please retype your new password."|i18n('design/ocbootstrap/user/password')}</h2>
                        </div>
                    {/if}
                    {if $newPasswordTooShort}
                        <div class="warning">
                            <h2>{"The new password must be at least %1 characters long, please retype your new password."|i18n( 'design/ocbootstrap/user/password','',array( ezini('UserSettings','MinPasswordLength') ) )}</h2>
                        </div>
                    {/if}

                {else}
                    <div class="feedback">
                        <h2>{'Password successfully updated.'|i18n('design/ocbootstrap/user/password')}</h2>
                    </div>
                    {include uri='design:user/password_updated.tpl'}
                {/if}
            {/if}
        </div>

        <div id="OldPasswordMessage" class="warning" style="display: none;">
            <b>La nuova password non deve coincidere con la precedente.</b>
        </div>
        <div id="PasswordPolicyMessage" class="warning" style="display: none;">
            <b>La password deve rispettare le regole sopra indicate.</b>
        </div>
        <div id="AlreadyUsedMessage" class="warning" style="display: none;">
            <b>La password impostata è già stata utilizzata in precedenza.</b>
        </div>


        {if $oldPasswordNotValid}*{/if}
        <label>{"Old password"|i18n("design/ocbootstrap/user/password")}</label><div class="labelbreak"></div>
        <input class="form-control" type="password" id="pass" name="oldPassword" size="11" value="{$oldPassword|wash}" />

        {if $newPasswordNotMatch}*{/if}
        <label>{"New password"|i18n("design/ocbootstrap/user/password")}</label><div class="labelbreak"></div>
        <input class="form-control" autocomplete="off" type="password" id="newPassword" name="newPassword" size="11" value="{$newPassword|wash}" />
        {if $newPasswordNotMatch}*{/if}
        <label>{"Retype password"|i18n("design/ocbootstrap/user/password")}</label><div class="labelbreak"></div>
        <input class="form-control" autocomplete="off" type="password" id="confirmPassword" name="confirmPassword" size="11" value="{$confirmPassword|wash}" />

        {*
        <div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="privacy-bootstrap" name="privacy">
                    Autorizzo il trattamento dei dati personali ai sensi  degli artt.
                    13 e 14 del  Regolamento UE n. 679 del 2016<br>
                    <a href="http://www.provincia.tn.it/privacy/" target="_blank">Informativa Privacy</a>
                </label>
            </div>
        </div>
        *}

        <input id="okButton"
               class="defaultbutton"
               type="submit"
               name="OKButton"
               value="{'OK'|i18n('design/ocbootstrap/user/password')}" />
        <input class="button" type="submit" name="CancelButton" value="{'Cancel'|i18n('design/ocbootstrap/user/password')}" />
        <span id="loading" style="display: none;">
            <i class='fa fa-spin fa-circle-o-notch'></i>
        </span>

    </form>
</div>
</div>

{include uri='design:user/password_policy.tpl'}

