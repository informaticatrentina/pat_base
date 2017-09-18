{def $lang_selector = array()
     $avail_translation = array()
     $site_url = ezini('SiteSettings', 'SiteURL')}
     
{if and( is_set( $DesignKeys:used.url_alias ), $DesignKeys:used.url_alias|count|ge( 1 ) )}
    {set $avail_translation = language_switcher( $DesignKeys:used.url_alias )}
{else}
    {set $avail_translation = language_switcher( $site.uri.original_uri )}
{/if}

{def $user_policies=fetch( 'user', 'user_role', hash( 'user_id', $current_user.contentobject_id ) )
     $site_access_policies=false()}

{foreach $user_policies as $policy}
    {if and($policy.moduleName|eq('user'), $policy.functionName|eq('login'))}
        {set $site_access_policies=$policy.limitation.0.values_as_array_with_names}
    {/if}
{/foreach}

{if $avail_translation|count|gt( 1 )}
    
    {def $lang_uri=false()}
    
    {foreach $avail_translation as $siteaccess => $lang}
        
        {set $lang_uri = $lang.text|downcase()}
        
        {if is_set($lang.locale)}
            {def $access_enabled = false()}
            
            {foreach $site_access_policies as $policy}
                {if or($policy.Name|ends_with($lang_uri), $lang_uri|eq('ita'))}
                    {set $access_enabled = true()}
                {/if}
            {/foreach}
            
            {if $access_enabled}
                <li>
                {if $siteaccess|eq( $access_type.name )}
                    <a href="#">
                        <b class="text-primary">{$lang.text|wash()}</b>
                    </a>
                {else}
                    {if $lang_uri|eq('ita')}
                        {set $lang_uri = ''}
                    {/if}

                    <a href={concat('https://', $site_url, '/', $lang_uri)}>
                        {$lang.text|wash()}
                    </a>
                {/if}
                </li>
            {/if}
            
            {undef $access_enabled}
        {/if}
    {/foreach}
    
    {undef $lang_uri}
{/if}

{undef $lang_selector
       $avail_translation
       $site_url
       $user_policies
       $site_access_policies}