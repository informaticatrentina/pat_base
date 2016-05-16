{def $node=fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}

<div class="card-material solo_testo">
    <header>
        {def $title_size='1'}
        {if and(is_set($block.custom_attributes.title_size),$block.custom_attributes.title_size|ne(''))}
            {if and($block.custom_attributes.title_size|ge(1), $block.custom_attributes.title_size|le(4))}
                {set $title_size = $block.custom_attributes.title_size}
            {/if}
        {/if}
        
        <h{$title_size}>
            {if $can_edit}
            <a href={$node.url_alias|ezurl}>
            {/if}
                {$block.name|wash()}
            {if $can_edit}
            </a>
            {/if}
        </h{$title_size}>
        {undef $title_size}
    </header>
    <p>
        {attribute_view_gui attribute=$node|attribute('short_description')}
    </p>

    <p>
        {attribute_view_gui attribute=$node|attribute('description')}
    </p>
</div>