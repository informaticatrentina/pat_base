{def $footer_top_links = footer('footer_top_links')}


{*$footer_top_links|attribute('show')*}
{* Calcolo del numero di link poplati*}
{def $numerolinkPopolati = $footer_top_links|count()}
{def $numeroColonne=2}
{switch match=$numerolinkPopolati}
    {case match=1} 
        {def $numeroColonne = 12}
    {/case}
    {case match=2} 
        {def $numeroColonne = 6}
    {/case}
     {case match=3} 
        {def $numeroColonne = 4}
    {/case}
    {case match=4} 
        {def $numeroColonne = 3}
    {/case}
{/switch}  
{if is_set($footer_top_links.dove_siamo)} 
    <div class="col-xs-{$numeroColonne} text-center">
        <a href={$footer_top_links.dove_siamo}>
            <i class="fa fa-map-marker footer-icon"></i><div class="hidden-xs">DOVE SIAMO</div>
        </a>
    </div>
{/if}
{if is_set($footer_top_links.contatti)}
    <div class="col-xs-{$numeroColonne} text-center">
        <a href={$footer_top_links.contatti|ezurl(no)}>
            <i class="fa fa-phone-square footer-icon"></i><div class="hidden-xs">CONTATTI</div>
        </a>
    </div>
{/if}
{if is_set($footer_top_links.scrivici)}
    <div class="col-xs-{$numeroColonne} text-center">
        <a href={$footer_top_links.scrivici}>
            <i class="fa fa-envelope footer-icon"></i><div class="hidden-xs">SCRIVICI</div>
        </a>
    </div>
{/if}
{if is_set($footer_top_links.social_media_policy)}
    <div class="col-xs-{$numeroColonne} text-center">
        <a href={$footer_top_links.social_media_policy}>
            <i class="fa fa-globe footer-icon"></i><div class="hidden-xs">SOCIAL MEDIA<br/>POLICY</div>
        </a>
    </div>
{/if}
{if is_set($footer_top_links.aiuto)}
    <div class="col-xs-{$numeroColonne} text-center">
        <a href={$footer_top_links.aiuto}>
            <i class="fa fa-info-circle footer-icon"></i><div class="hidden-xs">AIUTO</div>
        </a>
    </div>
{/if}
{if is_set($footer_top_links.intranet)}
    <div class="col-xs-{$numeroColonne} text-center">
        <a href={$footer_top_links.intranet}>
            <i class="fa fa-user footer-icon"></i><div class="hidden-xs">INTRANET</div>
        </a>
    </div>
{/if}
{undef $numerolinkPopolati} 
{undef $numeroColonne} 