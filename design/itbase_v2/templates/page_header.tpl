<header id="header" role="banner">
    {include uri='design:header/top-banner.tpl'}
    
    <div class="container">
        <div class="row">
            <div class="branding col-sm-6">        
                {*include uri='design:page_header_logo.tpl'*}
            </div>
            <div class="col-sm-6">
                <div class="clearfix">
                    {include uri='design:page_header_languages.tpl'}
                    {*
                    <div class="hidden-xs">
                        {include uri='design:page_header_links.tpl'}
                    </div>
                    *}
                </div>
                <div class="row">
                    <div class="col-md-6 col-md-offset-6 col-xs-10" style="padding-top: 10px;">
                          {*include uri='design:page_header_searchbox.tpl'*}
                    </div>
                    <div class="col-xs-2">
                        <button type="button" class="navbar-default navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
                          <i class="fa fa-bars fa-lg"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
