<ul class="list-unstyled">
{foreach $items as $item}
    <li><i class="fa fa-file-video-o" aria-hidden="true"></i>{content_view_gui content_object=$item.object view=embed}</li>
{/foreach}
</ul>