{def $i = 0}
{foreach $blocks as $block}
    {*if $block.identifier|eq('repositories')*}
        <div class="row dashboard">
            <div class="col-sm-6">
                <div class="card-material"
                    {if $block.template}
                        {include uri=concat( 'design:', $block.template )}
                    {else}
                        {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
                    {/if}
                </div>
            </div>
            <div class="col-sm-6">
                <div class="card-material">
                    {include uri='design:dashboard/classes.tpl'}
                </div>
            </div>
        </div>
    {*/if*}
{set $i = $i|sum(1)}
{/foreach}