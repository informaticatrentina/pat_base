<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!--[if lt IE 9 ]><html xmlns="http://www.w3.org/1999/xhtml" class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]><html xmlns="http://www.w3.org/1999/xhtml" class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html xmlns="http://www.w3.org/1999/xhtml" lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->

{http_header('X-UA-Compatible: IE=Edge')}
    
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
    
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.login, ',', $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}

{def $browser = checkbrowser() $ie9 = 0}
{if and( $browser.browser_name|eq('msie'), $browser.browser_math_number|lt(10) )}{set $ie9 = 1}{/if}
{cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key, $ie9 )}
{*def $pagedata         = ezpagedata()*}
{def $pagedata         = openpapagedata()}

{def $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $current_node_id  = $pagedata.node_id}

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Site: {ezsys( 'hostname' )} -->
  {if ezsys( 'hostname' )|begins_with( 'ez' )}
    <META name="robots" content="NOINDEX,NOFOLLOW" />
  {/if}

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}
{include uri='design:page_head_analytics_script.tpl'}

{include uri='design:page_favicon.tpl'}
<style>
    {literal}
    .TestoRosso{
        color: red !important;
    }
    .TestoBlu{
        color: blue !important;
    }
    {/literal}
</style>
</head>
<body>

<div id="page">

    {include uri='design:page_header.tpl'}
{/cache-block}
{cache-block keys=array( $module_result.uri, $current_user.contentobject_id, $extra_cache_key )}
    
    {if is_unset($pagedata)} 
        {def $pagedata = openpapagedata()}
    {/if}

    
    {include uri='design:nav/nav-main.tpl'}

    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
      {include uri='design:page_toolbar.tpl'}
    {/if}
    
    {if and( $pagedata.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ), $pagedata.show_path, array( 'edit', 'browse' )|contains( $ui_context )|not() )}
      {include uri='design:breadcrumb.tpl'}
    {/if}

    <div class="container">

{/cache-block}

      {$module_result.content}
      
{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

    </div>

    {include uri='design:page_footer.tpl'}
</div>

<button class="animate_ftl" id="go_to_top"><i class="fa fa-angle-up"></i></button>

{include uri='design:page_footer_script.tpl'}

{*
{if and( $pagedata.is_login_page|not(), array( 'edit', 'browse' )|contains( $ui_context )|not() )}
  {include uri='design:page_social.tpl'}
{/if}
*}

{* Codice extra usato da plugin javascript *}
{include uri='design:page_extra.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>

<!-- @developers: Stefano Ziller, Patrizio Anesin -->
</html>
