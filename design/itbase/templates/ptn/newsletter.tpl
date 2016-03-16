<script>
    {literal}
    $(document).ready(function() {
        var touch = false;
        if (window.Modernizr) {
            touch = Modernizr.touch;
        }
        if (!touch) {
            $("body").on("mouseenter", ".has-tooltip", function() {
                var el;
                el = $(this);
                if (el.data("tooltip") === undefined) {
                    el.tooltip({
                        placement: el.data("placement") || "top",
                        container: el.data("container") || "body"
                    });
                }
                return el.tooltip("show");
            });
            $("body").on("mouseleave", ".has-tooltip", function() {
                return $(this).tooltip("hide");
            });
        }
    });
    {/literal}
</script>

{def $handlers = fetch('notification', 'handler_list')}
{def $handler = false()}

{foreach $handlers as $item}
    {if $item.id_string|eq('itnewsletter')}
        {set $handler=$item}
    {/if}
{/foreach}

{def $currentUser = fetch( 'user', 'current_user' )}

<div class="content-view-full">
    <div class="content-title">
        <h1>Rimani aggiornato</h1>
    </div>

    <div class="content-main wide">
        <p>
            Per rimanere aggiornato su ciascun tema puoi gestire le tue iscrizioni alle newsletter tematiche quotidiane.
        </p>
        {if $currentUser.is_logged_in|not}
            <div class="well">
                <p>Per iscriverti e gestire le tue iscrizioni alle newsletter tematiche <strong>devi autenticarti:</strong></p>
                <form class="form-inline" method="post" action={"/user/login"|ezurl} >
                    <div class="form-group">
                        <label for="Login" class="sr-only">Username o email</label>
                        <input type="text" autofocus="" autocomplete="off" name="Login" id="Login" placeholder="Username o email" class="form-control" data-rule-required="true" value="{$User:login|wash}">
                    </div>
                    <div class="form-group">
                        <label for="Password"  class="sr-only">Password</label>
                        <input type="password" autocomplete="off" name="Password" id="Password" placeholder="{"Password"|i18n("design/ocbootstrap/user/login")}" class="form-control" data-rule-required="true" >
                    </div>
                    <input type="hidden" name="RedirectURI" value="notification/settings" />
                    <button class='btn btn-success' name="LoginButton">{'Login'|i18n('design/ocbootstrap/user/login','Button')}</button>
                    <a class='btn btn-warning' href={'/user/forgotpassword'|ezurl}>Password dimenticata?</a>
                    <a class='btn btn-danger' href={"/user/register"|ezurl}>Non hai un account?</a>
                </form>
            </div>
        {/if}

        <form method="post" action={"ptn/newsletter"|ezurl}>
            <table class="table table-striped" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <th>Tematiche</th>
                    <th class="text-center">Iscrizioni newsletter</th>
                    {* <th class="text-center">Link RSS</th> *}
                </tr>
                {foreach $handler.available_tags as $tag}
                    <tr>
                        <td>{$tag.keyword|wash()}</td>
                        {if $currentUser.is_logged_in}
                            <td class="text-center">
                                {def $selected = false()}
                                {foreach $handler.rules as $rule}
                                    {if $rule.tag_id|eq( $tag.id )}
                                        <button class="btn btn-danger btn-md has-tooltip" type="submit" name="RemoveRule_{$handler.id_string}[]" value="{$rule.id}" title="Rimuovi iscrizione a {$tag.keyword|wash()}" data-toggle="tooltip" data-placement="top">
                                            <i class="fa fa-times"></i> Rimuovi
                                        </button>
                                        {set $selected = true()}
                                        {break}
                                    {/if}
                                {/foreach}
                                {if $selected|not()}
                                    <button class="btn btn-success btn-md has-tooltip" type="submit" name="SaveRule_{$handler.id_string}" value="{$tag.id}" title="Iscriviti a {$tag.keyword|wash()}" data-toggle="tooltip" data-placement="top">
                                        <i class="fa fa-check"></i> Aggiungi
                                    </button>
                                {/if}
                                {undef $selected}
                            </td>
                        {else}
                            <td class="text-center">
                                <button class="btn btn-default btn-md btn-disabled" disabled="disabled" type="submit" name="Disabled" value="{$tag.id}">
                                    <i class="fa fa-check"></i> Aggiungi
                                </button>
                            </td>
                        {/if}
                        {*
                        <td class="text-center">
                            <a href="{concat('feed/rss/tag/', $tag.id)|ezurl(no)}" class="btn btn-warning btn-md"><i class="fa fa-rss"></i></a>
                        </td>
                        *}
                    </tr>
                {/foreach}
            </table>
        </form>


    </div>
</div>