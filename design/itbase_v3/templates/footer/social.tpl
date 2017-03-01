{if is_set($pagedata.contacts.facebook)}
    <a class="footer-bottom-icon"  href={$pagedata.contacts.facebook}>
        <span class="fa-stack">
            <i class="fa fa-circle fa-inverse footer-social-circle"></i>
            <i class="fa fa-facebook fa-stack-1x footer-social-icon"></i>
        </span>
    </a>
{/if}
{if is_set($pagedata.contacts.twitter)}
    <a class="footer-bottom-icon"  href={$pagedata.contacts.twitter}>
        <span class="fa-stack">
            <i class="fa fa-circle fa-inverse footer-social-circle"></i>
            <i class="fa fa-twitter fa-stack-1x footer-social-icon"></i>
        </span>
    </a>
{/if}
{if is_set($pagedata.contacts.youtube)}
    <a class="footer-bottom-icon"  href={$pagedata.contacts.youtube}>
        <span class="fa-stack">
            <i class="fa fa-circle fa-inverse footer-social-circle"></i>
            <i class="fa fa-youtube fa-stack-1x footer-social-icon"></i>
        </span>
    </a>
{/if}