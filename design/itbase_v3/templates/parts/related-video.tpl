{if gt($video|count,0)} 
    <div class="related-panel">
        <div class="row">
            <div class="col-xs-8">
                <h3>video</h3>
            </div>
            <div class="col-xs-4 text-right">
                <span class="fa-stack fa-3x related-icon">
                    <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                    <i class="fa fa-video-camera  fa-stack-1x"></i>
                </span>
            </div>
        </div> 
        
        {include uri='design:atoms/video.tpl' items=$video}        
    </div>
{/if}