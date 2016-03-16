<br/>
{if $current_user.is_logged_in}
    <a href={"/user/logout"|ezurl} 
       class="has_tooltip" 
       title="Esegui il logout 
       ({$current_user.contentobject.name|wash})" 
       data-toggle="tooltip" 
       data-placement="top">
        <i style="font-size:2em;" class="fa fa-unlock"></i>
    </a>
{else}
    <a href={concat("/user/login?url=",$module_result.uri)|ezurl} 
       class="has_tooltip" 
       title="Accedi con il tuo account utente" 
       data-toggle="tooltip" 
       data-placement="top">
        <i style="font-size:2em;" class="fa fa-lock"></i>
    </a>
{/if}
