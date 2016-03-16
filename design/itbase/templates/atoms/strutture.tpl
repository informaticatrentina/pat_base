
{foreach $tree as $tree_node}
    {if is_set($tree_node.name)}
        {* Sono in una struttura *}
        <span>
            <i class="fa fa-folder-open text-warning"></i> 
        </span>
        <a href={$tree_node.url|ezurl()}>
            {$tree_node.name}
        </a>
    {else}
        {* Scendo l'albero *}

        
        <ul style="list-style: none;">
            <li>
                {include uri='design:atoms/strutture.tpl' tree=$tree_node is_root=0}
            </li>
        </ul>
    {/if}
{/foreach}
