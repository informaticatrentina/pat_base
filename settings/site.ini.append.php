<?php /* #?ini charset="utf-8"?

[RegionalSettings]
TranslationExtensions[]=pat_base

[TemplateSettings]
ExtensionAutoloadPath[]=pat_base

[RoleSettings]
PolicyOmitList[]=ptn/newsletter
PolicyOmitList[]=ptn/header_image
PolicyOmitList[]=ptn/imalive
PolicyOmitList[]=ptn/password_policy
PolicyOmitList[]=ptn/password_expired
PolicyOmitList[]=ptn/password_updated
PolicyOmitList[]=ptn/health_check
 
; Password Policy siti PAT ;
[UserSettings]
ExtensionDirectory[]=pat_base
LoginHandler[]
LoginHandler[]=patbase

MinPasswordLength=8
GeneratePasswordLength=8
UseSpecialCharacters=true

; LOW = nessun controllo
; MEDIUM = una maiuscola
; HIGH = una maiuscola un numero
; HIGHER = una maiuscola un numero un carattere speciale
PasswordStrength=HIGH

; 0 = non scade mai
PasswordExpirationDays[default]=180
PasswordExpirationDays[admin]=0
PasswordExpirationDays[itadmin]=0

; Numero di password usate in passato da non riusare
LastPasswordsCheckCount=5

; Giorni disabilitazione utente
DisableUserNoVisitDays=365

*/ ?>
