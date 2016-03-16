{def $node_in_evidenza=fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node_in_evidenza ) )}

<div class="card-material in_evidenza">
    <header>
        <h3 class="widget_title">
            <i class="fa fa-newspaper-o"></i>
            {if $can_edit}
            <a href={$node_in_evidenza.url_alias|ezurl}>
            {/if}
                {$block.name|wash()}
            {if $can_edit}
            </a>
            {/if}
        </h3>
    </header>
        
    {def $attribute_filter = array( array( 'news/in_evidenza', '=', '1' ) )} 
    {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node_in_evidenza.node_id,
                                              'attribute_filter', $attribute_filter,
                                              'sort_by', hash( 'published', 'desc' ) ,
                                              'limit', 3 ) ) }
                              

    {if $children|count()|gt(0)}
        <ul class="media-list">                    
            {foreach $children as $child }
                {include uri='design:atoms/news.tpl' content=$child}
            {/foreach}
        </ul>
    {/if}
</div>

{undef $node_in_evidenza
       $can_edit}