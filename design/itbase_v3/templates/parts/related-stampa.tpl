<div class="related-panel">
    <div class="row">
            <div class="col-xs-8">
                 <h3>{"print"|i18n('design/pat_base/generic')}</h3> 
        </div>
        <div class="col-xs-4 text-right">
            <span class="fa-stack fa-3x related-icon">
                <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                <i class="fa fa-print fa-stack-1x"></i>
            </span>
        </div>
    </div>
    <a title="{'Export'|i18n('design/standard/parts/website_toolbar')}"
        href={concat('/content/view/pdf/', $node.node_id)|ezurl()}
        >{'printable version'|i18n('design/pat_base/generic')}
     </a>
</div>
