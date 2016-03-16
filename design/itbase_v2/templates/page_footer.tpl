{* Footer con Grafica richiesta da PAT *}

<footer>
    <div class="container">
        <div class="row">
            
            <div class="col-md-4 text-center">
                {include uri='design:footer/notes.tpl'}
            </div>
            <div class="col-md-8">
                <div class="row footer-links">
                    {include uri='design:footer/link_top.tpl'}
                </div>
                <div class="row footer-links-bottom">
                    <div class="col-sm-6">
                        <div class="row text-center">
                            {include uri='design:footer/link_bottom.tpl'}
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row text-center">
                            <div class="col-xs-4 text-center">
                                {include uri='design:footer/social.tpl'}
                            </div>
                            <div class="col-xs-4 text-center">
                                {include uri='design:footer/rss_skype.tpl'}
                            </div>
                            <div class="col-xs-4 text-center">
                                {include uri='design:footer/user.tpl'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>