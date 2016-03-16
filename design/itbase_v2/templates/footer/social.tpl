<br/>
{if is_set($pagedata.contacts.facebook)}
    <a href={$pagedata.contacts.facebook}><i style="font-size:2em;" class="fa fa-facebook"></i></a>
{/if}
{if is_set($pagedata.contacts.twitter)}
&nbsp;
    <a href={$pagedata.contacts.twitter}><i style="font-size:2em;" class="fa fa-twitter"></i></a>
{/if}
{if is_set($pagedata.contacts.youtube)}
    &nbsp;
    <a href={$pagedata.contacts.youtube}><i style="font-size:2em;" class="fa fa-youtube"></i></a>
{/if}