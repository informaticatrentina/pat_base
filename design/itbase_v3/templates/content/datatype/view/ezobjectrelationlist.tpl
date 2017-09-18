{if not( is_set($show_link) )}
  {def $show_link = true()}
{/if}
{if and( is_set( $href ), $href|eq( 'no-link' ))}
  {set $show_link = false()}
{/if}
{if not( is_set($show_newline) )}
    {def $show_newline = false()}
{/if}
{section show=$attribute.content.relation_list}
{section var=Relations loop=$attribute.content.relation_list}
{if $Relations.item.in_trash|not()}
    {if is_set( $node_view )}
            {if $show_pre}- {/if}  {node_view_gui content_node=fetch( content, object, hash( object_id, $Relations.item.contentobject_id ) ).main_node view=$node_view}
    {else}
            {if current_object_id()|eq($Relations.item.contentobject_id )}
		{set $show_link = false()}
            {/if}
            {if $show_pre}- {/if} 
             {content_view_gui view=embed show_link=$show_link content_object=fetch( content, object, hash( object_id, $Relations.item.contentobject_id ) )}
    {/if}
    {if $show_newline}<br />{/if}
{/if}
{/section}
{/section}
