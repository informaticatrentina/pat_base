{def $folder_node=fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}

{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $folder_node ) )}
                                                 
{def $custom_attributes = $block.custom_attributes}

<div class="widget home_widget card-material">
    <header>
        <div class="widget_title">
            <h1>
                <a href={$folder_node.url_alias|ezurl}>
                    {$block.name|wash()}
                </a>
            </h1>
        </div>
    </header>

    {if $custom_attributes.node_id|ne('')}
        {*ordine inverso in base a data di pubblicazione*}
        {*visualizza ultimi 3*}

        {def $search=fetch( ezfind,
                            'search',
                            hash( 'subtree_array', array( $folder_node.node_id ),
                                  'sort_by', hash( 'published', 'desc' ) )
                                 )}

        {def $_index=0}
        <div class="calendar">
            {foreach $search['SearchResult'] as $node}
                {if $_index|gt(2)}
                    {break}
                {/if}

                  {if or(
                            $node.object.class_identifier|eq('event_simple'), 
                            $node.object.class_identifier|eq('event')
                        )} 
                    {if $can_edit}
                    <a href={$node.url_alias|ezurl}>
                    {else}
                    {*<a href={$folder_node.url_alias|ezurl}>*}
                    <a href={$node.url_alias|ezurl}>
                    {/if}
                        <div style="padding-bottom: 10px;" class="row">
                            <div class="col-xs-3 col-sm-3">
                                <div class="event-day text-center">
                                    {$node.data_map.from_time.content.day}
                                </div>

                                <div class="event-month text-center">
                                    {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%F' )}
                                </div>

                            </div>
                            <div class="col-xs-9 col-sm-9 event">                            
                                <strong>{$node.data_map.titolo.content}</strong><br/>
                                <span class="text-small">{$node.data_map.short_title.content}</span>
                            </div>
                        </div>
                        {set $_index = $_index|sum(1)}
                    </a>
                {/if}
            {/foreach}
        </div>

        {undef $folder_node 
               $search
               $_index}
    {/if}
</div>
        
{undef $can_edit
       $custom_attributes}