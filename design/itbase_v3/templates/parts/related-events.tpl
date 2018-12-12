{def $objects = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id 
                                                                  , 'all_relations', true()
                                                                  , 'sort_by', array('published', false()) ) )}
                                                                  
{if $objects|count()|gt(0)}
    <h2 style="padding-top: 20px; padding-bottom: 5px;">
        <h3>{"events"|i18n('design/pat_base/generic')}</h3> 
    </h2>
    <div class="card-material">
        <div class="calendar">
            {foreach $objects as $object max 5}
                <a href={$object.main_node.url|ezurl}>
                    <div style="padding-bottom: 10px;" class="row">
                        <div class="col-xs-3 col-sm-3">
                            <div class="event-day text-center">
                                {$object.data_map.from_time.content.day}
                            </div>

                            <div class="event-month text-center">
                                {$object.data_map.from_time.content.timestamp|datetime( 'custom', '%F' )}
                            </div>

                        </div>
                        <div class="col-xs-9 col-sm-9 event">                            
                            <strong>{$object.data_map.titolo.content}</strong><br/>
                            <span class="text-small">{$object.data_map.short_title.content}</span>
                        </div>
                    </div>
                </a>
            {/foreach}
        </div>
    </div>
 {/if}
 
 