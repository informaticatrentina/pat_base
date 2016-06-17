{def $homepage = fetch('content','node', hash('node_id', 2))
     $footer_top_links = $homepage|attribute('footer_link_top')}
    
{if $footer_top_links.has_content}
    {def $rows = $footer_top_links.content.rows.sequential
         $numRows = $rows|count()
         $colSize = 2}
        
   {switch match=$numRows}
       {case match=1} 
           {set $colSize = 12}
       {/case}
       {case match=2} 
           {set $colSize = 6}
       {/case}
        {case match=3} 
           {set $colSize = 4}
       {/case}
       {case match=4} 
           {set $colSize = 3}
       {/case}
       {case}
            {set $colSize = 2}
       {/case}
   {/switch}
   
    {foreach $rows as $row max 6}
        {if and(is_set($row.columns[0]),is_set($row.columns[1]) )} 
            <div class="col-xs-{$colSize} text-center">
                {def $column=''
                     $fa_icon=''}
                {if $row.columns[0]|eq('LOGIN')}
                    {if $current_user.is_logged_in}
                    <a href={"/user/logout"|ezurl}>
                        {set $fa_icon=ezini( 'FooterIcons', 'logout', 'patbase.ini' )}
                        <i class="fa {$fa_icon} footer-icon"></i><div class="hidden-xs">LOGOUT</div>
                    </a>
                    {else}
                    <a href={"/user/login"|ezurl}>
                        {set $fa_icon=ezini( 'FooterIcons', 'login', 'patbase.ini' )}
                        <i class="fa {$fa_icon} footer-icon"></i><div class="hidden-xs">LOGIN</div>
                    </a>
                    {/if}
                {elseif $row.columns[0]|ne('')}
                    <a href={$row.columns[1]}>
                        {set $column=$row.columns[0]|explode(' ')|implode('_')|downcase()|trim()
                             $fa_icon=ezini( 'FooterIcons', $column, 'patbase.ini' )}

                        {if is_set($fa_icon)|not()}
                            {set $fa_icon=ezini( 'FooterIcons', 'default', 'patbase.ini' )}
                        {/if}

                        <i class="fa {$fa_icon} footer-icon"></i><div class="hidden-xs">{$row.columns[0]}</div>
                    </a>
                {/if}
                
                {undef $column
                       $fa_icon}
            </div>
        {/if}
    {/foreach}
    
    {undef $rows
           $numRows
           $colSize}
    
{/if}

{undef $homepage
       $footer_top_links}