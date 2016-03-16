{def $node=fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}

<div class="card-material solo_testo">
    <header>
        <h1 class="text-center">
            {if $can_edit}
            <a href={$node.url_alias|ezurl}>
            {/if}
                {$block.name|wash()}
            {if $can_edit}
            </a>
            {/if}
        </h1>
    </header>
    <p>
        {attribute_view_gui attribute=$node|attribute('short_description')}
    </p>

    <p>
        {attribute_view_gui attribute=$node|attribute('description')}
    </p>
</div>