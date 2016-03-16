{if $attribute.has_content}
{def $href='' $text=''}
<ul class="list-unstyled">
{foreach $attribute.content.rows.sequential as $row}
  {set $href='' $text=''}
  {foreach $row.columns as $index => $column}
	{if $index|eq(0)}
	  {set $href=$column}
	{else}
	  {set $text=$column}
	{/if}
  {/foreach}
  <li><a href="{$href}">{$text}</a></li>  
{/foreach}
</ul>
{undef $href $text}
{/if}