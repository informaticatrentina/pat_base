{def $i = 0}

<div class="dashboard">
    {foreach $blocks as $block}
        {if $i|mod(2)|eq(0)}
            <div class="row">
        {/if}
            <div class="col-sm-6">
                <div class="card-material" style="max-height: 500px; overflow-y: scroll;"
                    {if $block.template}
                        {include uri=concat( 'design:', $block.template )}
                    {else}
                        {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
                    {/if}
                </div> 
            </div>
        {if $i|mod(2)|eq(1)}
            </div>
        {/if}
        {set $i = $i|sum(1)}
    {/foreach}
    
    {if $i|mod(2)|eq(1)}
        </div>
    {/if}
</div>

{* 
@TODO: 
Gestione Colori del Sito
Creare DashboardBlock chiamato: css_color
*}