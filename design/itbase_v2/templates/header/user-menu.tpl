<div class="container site-user-menu">
    <ul class="list-inline pull-right text-center">
        {if $current_user.is_logged_in}
            {if fetch( 'user', 'has_access_to', hash( 'module', 'ufficiostampa', 'function', 'dashboard' ) )}      
            <li>
                <a href={"/content/dashboard/"|ezurl} title="Pannello strumenti" class="has_tooltip"  data-toggle="tooltip" data-placement="bottom">
                   <i class="fa fa-dashboard"></i>
                    <div class="menu-name">
                        Dashboard
                    </div>
                </a>
            </li>
            {/if}

            {if fetch( 'user', 'has_access_to', hash( 'module', 'user', 'function', 'selfedit' ) )}
            <li id="myprofile">
                <a href={"/user/edit/"|ezurl} title="Visualizza il tuo profilo utente" class="has_tooltip" data-toggle="tooltip" data-placement="bottom">
                   <i class="fa fa-user"></i>
                    <div class="menu-name">
                        Profilo
                    </div>
                </a>
            </li>
            {/if}
          
            <li id="logout">
                <a href={"/user/logout"|ezurl} class="has_tooltip" title="Esegui il logout ({$current_user.contentobject.name|wash})" data-toggle="tooltip" data-placement="bottom">
                    <i class="fa fa-unlock"></i>
                    <div class="menu-name">
                        {$current_user.login|wash()}
                    </div>
                </a>
            </li>
        {else}
            {*
            <li id="login">
                <a href={concat("/user/login?url=",$module_result.uri)|ezurl} class="has_tooltip" title="Accedi con il tuo account utente" data-toggle="tooltip" data-placement="bottom">
                    <i class="fa fa-lock"></i>
                    <div class="menu-name">
                        Accedi
                    </div>
                </a>
            </li>
            
            <li id="registeruser">
                <a href={"/user/register"|ezurl} class="has_tooltip"  data-toggle="tooltip" data-placement="bottom" title="Crea il tuo utente per accedere alle aree riservate">
                    <i class="fa fa-child"></i>
                    <div class="menu-name">
                        Registrati
                    </div>
                </a>
            </li>
            *}
        {/if}
    </ul>
</div>