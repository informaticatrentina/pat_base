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
            <li>
                <a href={$valid_node.url|ezurl()}>
                     {$valid_node.name|wash()}
                </a>
            </li>
        {/foreach}
    </ul>
</div>