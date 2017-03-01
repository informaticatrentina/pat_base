{def $homepage = fetch('content','node', hash('node_id', 2))
     $footer_bottom_links = $homepage|attribute('footer_link_bottom')}
    
{if $footer_bottom_links.has_content}
    {def $rows = $footer_bottom_links.content.rows.sequential
         $numRows = $rows|count()
         $colSize = 4}
         
    {switch match=$numRows}
        {case match=4} 
            {set $colSize = 6}
        {/case}
        {case match=3} 
            {set $colSize = 6}
        {/case}
        {case match=2} 
            {set $colSize = 12}
        {/case}
        {case match=1}
            {set $colSize = 12}
        {/case}
        {case}
            {set $colSize = 4}
        {/case}
    {/switch}
    
    {foreach $rows as $index => $row max 6}
        {if $index|mod(2)|eq(0)}
            <div class="col-xs-{$colSize} text-center">
        {/if}
            <p>
                <a href={$row.columns[1]}>{$row.columns[0]}</a>
            </p>
        {if $index|mod(2)|eq(1)}
            </div>
        {/if}
    {/foreach}
    
    {undef $rows
           $numRows
           $colSize}
{/if}


{undef $homepage
       $footer_bottom_links}

