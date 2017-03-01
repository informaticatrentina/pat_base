<div class="related-panel">
    <div class="row">
        <div class="col-xs-8">
            {def $file = $node|attribute( 'file' )}
            <a href={concat("content/download/",$file.contentobject_id,"/",$file.id,"/file/",$file.content.original_filename)|ezurl}>
            <h3>scarica</h3>
            </a>
            {undef $file}
        </div>
        <div class="col-xs-4 text-right">
            <span class="fa-stack fa-3x related-icon">
                <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                <i class="fa fa-download fa-stack-1x"></i>
            </span>
        </div>
    </div>
</div>
