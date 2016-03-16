{def $footer_top_links = footer('footer_bottom_links')}
{def $numerolinkPopolati = $footer_top_links|count()}

{def $arrayLink = array()} 
{def $arrayDecLink = array()} 
{* Crea un array con i link popolati*}
{*mappa_sito*}
{if is_set($footer_top_links.mappa_sito)}
    {set $arrayLink = $arrayLink|append($footer_top_links.mappa_sito)}
    {set $arrayDecLink = $arrayDecLink|append("mappa sito")}
{/if} 
{*credits*}
{if is_set($footer_top_links.credits)}
    {set $arrayLink = $arrayLink|append($footer_top_links.credits)}
    {set $arrayDecLink = $arrayDecLink|append("credits")}
{/if} 
{*accessibilita*}
{if is_set($footer_top_links.accessibilita)}   
    {set $arrayLink = $arrayLink|append($footer_top_links.accessibilita)}
    {set $arrayDecLink = $arrayDecLink|append("accessibilità")}
{/if} 
{*note_legali*}
{if is_set($footer_top_links.note_legali)}
    {set $arrayLink = $arrayLink|append($footer_top_links.note_legali)}
    {set $arrayDecLink = $arrayDecLink|append("note legali")}
{/if}
{*info_cookies*}
{if is_set($footer_top_links.info_cookies)}
    {set $arrayLink = $arrayLink|append($footer_top_links.info_cookies)}
    {set $arrayDecLink = $arrayDecLink|append("info cookies")}
{/if}
{*privacy*}
{if is_set($footer_top_links.privacy)}
    {set $arrayLink = $arrayLink|append($footer_top_links.privacy)}
    {set $arrayDecLink = $arrayDecLink|append("privacy")}
{/if}

{def $numeroColonne=4}
{switch match=$numerolinkPopolati}
    {case match=6}  
        {set $numeroColonne = 4}
    {/case}
    {case match=5} 
        {set $numeroColonne = 4}
    {/case}
    {case match=4} 
        {set $numeroColonne = 6}
    {/case}
    {case match=3} 
        {set $numeroColonne = 6}
    {/case}
    {case match=2} 
        {set $numeroColonne = 12}
    {/case}
    {case match=1}
        {set $numeroColonne = 12}
    {/case}
{/switch}  

{if $arrayLink|count()|gt(0)}
 <div class="col-xs-{$numeroColonne} text-center">
    <p>
        <a href={$arrayLink[0]}>{$arrayDecLink[0]}</a>
    </p>
    <p>
       <a href={$arrayLink[1]}>{$arrayDecLink[1]}</a>
     </p>
</div>
{/if}   
{if $arrayLink|count()|gt(2)}
 <div class="col-xs-{$numeroColonne} text-center">
    <p>
        <a href={$arrayLink[2]}>{$arrayDecLink[2]}</a>
    </p>
    <p>
        <a href={$arrayLink[3]}>{$arrayDecLink[3]}</a>
    </p>
</div>
{/if}   

{if $arrayLink|count()|gt(4)}
 <div class="col-xs-{$numeroColonne} text-center">
    <p>
      <a href={$arrayLink[4]}>{$arrayDecLink[4]}</a>
    </p>
    <p>
       <a href={$arrayLink[5]}>{$arrayDecLink[5]}</a>
    </p>
</div>
{/if}   

