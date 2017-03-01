{if is_set($pagedata.contacts.feed)}
    <a class="footer-bottom-icon" href={$pagedata.contacts.skype}>
        <span class="fa-stack">
            <i class="fa fa-circle fa-inverse footer-social-circle"></i>
            <i class="fa fa-rss fa-stack-1x footer-social-icon"></i>
        </span>
    </a>
{/if}
{if is_set($pagedata.contacts.skype)}
    <a class="footer-bottom-icon" href={$pagedata.contacts.skype}>
        <span class="fa-stack">
            <i class="fa fa-circle fa-inverse footer-social-circle"></i>
            <i class="fa fa-skype fa-stack-1x footer-social-icon"></i>
        </span>
    </a>
{/if}