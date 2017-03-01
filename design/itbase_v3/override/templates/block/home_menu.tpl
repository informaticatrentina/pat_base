{def $valid_nodes = $block.valid_nodes}

<div class="card-material home_menu">
    {if $block.name|ne('')}
        <header>
            <h3 class="widget_title" style="margin:10px;">
                <i class="fa fa-bars"></i>
                {$block.name|wash()}
            </h3>
        </header>
    {/if}
    <ul class="list-unstyled">
        {foreach $valid_nodes as $i => $valid_node}
            
            {* Verifica se è un Link *}
            {def $node_url = $valid_node.url_alias
                 $target = '_self'}
            {if $valid_node.object.class_identifier|eq('link')}
                {set $node_url=$valid_node|attribute('location').content}
                {if $valid_node|attribute('open_in_new_window').content|eq(1)}
                    {set $target = '_blank'}
                {/if}
            {/if}
            {* Verifica se è un File *}
            {if $valid_node.object.class_identifier|eq('file')}
                {*$valid_node|attribute('file')|attribute('show')*}
                {def $file = $valid_node|attribute('file')}
                {set $node_url = concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )}
                {set $target = '_blank'}
                {undef $file}
            {/if}
            {* ** *}
            
            <li>
                <a href={$node_url|ezurl()} target="{$target}">
                    <div class="row">
                        <div class="col-xs-12">
                            {$valid_node.name|wash()}
                        </div>
                        {*
                        <div class="col-xs-6 text-right">
                            <i class='fa fa-arrow-circle-o-right fa-2x'></i>
                        </div>
                        *}
                    </div>
                </a>
            </li>
            {undef $node_url
                   $target}
        {/foreach}
    </ul>
</div>