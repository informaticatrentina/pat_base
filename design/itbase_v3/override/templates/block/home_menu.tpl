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
        {/foreach}
    </ul>
</div>