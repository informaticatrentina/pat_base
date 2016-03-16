{def $view = first_set( $current_calendar_view, 'calendar' )}
{if is_set( $view_parameters.view )}
    {set $view = $view_parameters.view}
{/if}
{include name=calendar node=$node uri=concat("design:calendar/",$view,".tpl") view_parameters=$view_parameters }