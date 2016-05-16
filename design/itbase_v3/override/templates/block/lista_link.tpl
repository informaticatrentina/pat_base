{def $node=fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}

<div class="widget home_widget card-material lista_link">
    <header>
        <div class="widget_title">
            <h1>
                {if $can_edit}
                    <a href={$node.url_alias|ezurl}>
                {/if}
                {$block.name|wash()}
                {if $can_edit}
                    </a>
                {/if}
            </h1>
        </div>
    </header>
    <ul class="list-unstyled">
        {foreach $node.children as $child}
            {if eq($child.class_name, 'Link')}
                <li>
                    <a href={$child.data_map.location.content} 
                       {if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )}
                            target="_blank"
                       {/if} >
                        {$child.name|wash()}
                    </a>
                </li>
            {/if}
                
        {/foreach}
    </ul>

</div>
